package com.example.groccery.utils;

import com.example.groccery.repos.OrderRepo;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.io.*;
import java.nio.file.*;

@Component
public class OrderQueue {

    private static final String QUEUE_FILE = "order_queue.txt";
    private final OrderRepo orderRepo;
    private final SimpleQueue orderIds = new SimpleQueue();

    @Autowired
    public OrderQueue(OrderRepo orderRepo) {
        this.orderRepo = orderRepo;
    }

    @PostConstruct
    public void init() throws IOException {
        loadQueueFromFile();
    }

    public void enqueue(String orderId) throws IOException {
        if (orderRepo.findById(orderId).isPresent()) {
            orderIds.enqueue(orderId);
            saveQueueToFile();
        }
    }

    public String dequeue() throws IOException {
        String orderId = orderIds.dequeue();
        if (orderId != null) {
            saveQueueToFile();
        }
        return orderId;
    }

    public boolean contains(String orderId) {
        return orderIds.contains(orderId);
    }

    public String[] getAllOrdersInQueue() {
        return orderIds.toArray();
    }

    private void loadQueueFromFile() throws IOException {
        Path path = Paths.get(QUEUE_FILE);
        if (!Files.exists(path)) Files.createFile(path);

        orderIds.clear();
        java.util.List<String> lines = Files.readAllLines(path);
        if (!lines.isEmpty()) {
            String[] ids = lines.get(0).split(",");
            for (String id : ids) {
                if (!id.trim().isEmpty()) orderIds.enqueue(id.trim());
            }
        }
    }

    private void saveQueueToFile() throws IOException {
        String[] arr = orderIds.toArray();
        String line = String.join(",", arr);
        Files.write(Paths.get(QUEUE_FILE), java.util.Collections.singletonList(line));
    }
}