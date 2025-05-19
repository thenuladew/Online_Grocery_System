package com.example.groccery.repos;

import com.example.groccery.models.Customer;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class CustomerRepo {

    private static final String FILE_NAME = "customer.txt";

    public String generateId() throws IOException {
        List<Customer> customers = findAll();
        AtomicInteger max = new AtomicInteger(0);
        customers.forEach(c -> {
            try {
                int idNum = Integer.parseInt(c.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    public List<Customer> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Customer> customers = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length == 6) {
                Customer customer = new Customer(
                        parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]
                );
                customers.add(customer);
            }
        }

        return customers;
    }

    public Optional<Customer> findById(String id) throws IOException {
        List<Customer> customers = findAll();
        return customers.stream().filter(c -> c.getId().equals(id)).findFirst();
    }

    public Optional<Customer> findByEmail(String email) throws IOException {
        List<Customer> customers = findAll();
        return customers.stream().filter(c -> c.getEmail().equals(email)).findFirst();
    }

    public boolean existsByEmail(String email) throws IOException {
        return findByEmail(email).isPresent();
    }

    public void save(Customer customer) throws IOException {
        List<Customer> customers = findAll();
        boolean exists = false;

        for (int i = 0; i < customers.size(); i++) {
            if (customers.get(i).getId().equals(customer.getId())) {
                customers.set(i, customer);
                exists = true;
                break;
            }
        }

        if (!exists) {
            customers.add(customer);
        }

        writeToFile(customers);
    }

    public boolean deleteById(String id) throws IOException {
        List<Customer> customers = findAll();
        boolean removed = customers.removeIf(c -> c.getId().equals(id));
        if (removed) writeToFile(customers);
        return removed;
    }

    private void writeToFile(List<Customer> customers) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Customer c : customers) {
            lines.add(String.join("|",
                    c.getId(),
                    c.getName(),
                    c.getAddress(),
                    c.getEmail(),
                    c.getContactNumber(),
                    c.getPassword()
            ));
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}