package com.example.groccery.utils;

import com.example.groccery.repos.OrderRepo;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@Component
public class OrderQueue {

    private static final String QUEUE_FILE = "order_queue.txt";
    private final OrderRepo orderRepo;
    private final Queue<String> orderIds = new LinkedList<>();

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
            orderIds.offer(orderId);
            saveQueueToFile();
        }
    }

    public String dequeue() throws IOException {
        String orderId = orderIds.poll();
        if (orderId != null) {
            saveQueueToFile();
        }
        return orderId;
    }

    public boolean contains(String orderId) {
        return orderIds.contains(orderId);
    }

    public List<String> getAllOrdersInQueue() {
        return new ArrayList<>(orderIds);
    }

    private void loadQueueFromFile() throws IOException {
        Path path = Paths.get(QUEUE_FILE);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        if (!lines.isEmpty()) {
            String[] ids = lines.get(0).split(",");
            orderIds.clear();
            for (String id : ids) {
                if (!id.trim().isEmpty()) orderIds.offer(id.trim());
            }
        }
    }

    private void saveQueueToFile() throws IOException {
        List<String> line = Arrays.asList(String.join(",", orderIds));
        Files.write(Paths.get(QUEUE_FILE), line);
    }
}