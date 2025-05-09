package com.example.groccery.repos;

import com.example.groccery.models.Order;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class OrderRepo {

    private static final String FILE_NAME = "orders.txt";

    public String generateId() throws IOException {
        List<Order> orders = findAll();
        AtomicInteger max = new AtomicInteger(0);
        orders.forEach(o -> {
            try {
                int idNum = Integer.parseInt(o.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    public List<Order> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Order> orders = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split(";");
            if (parts.length < 5) continue;

            String id = parts[0];
            String customerName = parts[1];
            String customerEmail = parts[2];
            String address = parts[3];
            String status = parts[4];

            List<Order.ProductSummary> products = new ArrayList<>();
            if (parts.length > 5) {
                String[] productEntries = parts[5].split("\\|");
                for (String entry : productEntries) {
                    String[] data = entry.split(",");
                    if (data.length == 3) {
                        products.add(new Order.ProductSummary(data[0], data[1], data[2]));
                    }
                }
            }

            orders.add(new Order(id, products, customerName, customerEmail, address, status));
        }

        return orders;
    }

    public Optional<Order> findById(String id) throws IOException {
        return findAll().stream().filter(o -> o.getId().equals(id)).findFirst();
    }

    public List<Order> findByCustomerEmail(String email) throws IOException {
        List<Order> all = findAll();
        List<Order> result = new ArrayList<>();
        for (Order o : all) {
            if (o.getCustomerEmail().equals(email)) {
                result.add(o);
            }
        }
        return result;
    }

    public void save(Order order) throws IOException {
        List<Order> orders = findAll();
        boolean exists = false;

        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getId().equals(order.getId())) {
                orders.set(i, order); // Replace existing
                exists = true;
                break;
            }
        }

        if (!exists) {
            orders.add(order); // Add new
        }

        writeToFile(orders);
    }

    public boolean deleteById(String id) throws IOException {
        List<Order> orders = findAll();
        boolean removed = orders.removeIf(o -> o.getId().equals(id));
        if (removed) writeToFile(orders);
        return removed;
    }

    private void writeToFile(List<Order> orders) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Order o : orders) {
            StringBuilder sb = new StringBuilder();
            sb.append(o.getId()).append(";")
                    .append(o.getCustomerName()).append(";")
                    .append(o.getCustomerEmail()).append(";")
                    .append(o.getAddress()).append(";")
                    .append(o.getStatus()).append(";");

            List<String> productStrings = new ArrayList<>();
            for (Order.ProductSummary p : o.getProducts()) {
                productStrings.add(String.join(",", p.getProductId(), p.getName(), p.getCategory()));
            }

            if (!productStrings.isEmpty()) {
                sb.append(String.join("|", productStrings));
            }

            lines.add(sb.toString());
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}