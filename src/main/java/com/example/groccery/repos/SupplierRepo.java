package com.example.groccery.repos;

import com.example.groccery.models.Supplier;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class SupplierRepo {

    private static final String FILE_NAME = "supplier.txt";

    // Generate next ID based on current max
    public String generateId() throws IOException {
        List<Supplier> suppliers = findAll();
        AtomicInteger max = new AtomicInteger(0);
        suppliers.forEach(s -> {
            try {
                int idNum = Integer.parseInt(s.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    // Read all suppliers from file
    public List<Supplier> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Supplier> suppliers = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length == 6) {
                Supplier supplier = new Supplier(
                        parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]
                );
                suppliers.add(supplier);
            }
        }

        return suppliers;
    }

    // Find by ID
    public Optional<Supplier> findById(String id) throws IOException {
        List<Supplier> suppliers = findAll();
        return suppliers.stream().filter(s -> s.getId().equals(id)).findFirst();
    }

    // Save or update supplier
    public void save(Supplier supplier) throws IOException {
        List<Supplier> suppliers = findAll();
        boolean exists = false;

        for (int i = 0; i < suppliers.size(); i++) {
            if (suppliers.get(i).getId().equals(supplier.getId())) {
                suppliers.set(i, supplier);
                exists = true;
                break;
            }
        }

        if (!exists) {
            suppliers.add(supplier);
        }

        writeToFile(suppliers);
    }

    // Delete by ID
    public boolean deleteById(String id) throws IOException {
        List<Supplier> suppliers = findAll();
        boolean removed = suppliers.removeIf(s -> s.getId().equals(id));
        if (removed) writeToFile(suppliers);
        return removed;
    }

    // Write list of suppliers back to file
    private void writeToFile(List<Supplier> suppliers) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Supplier s : suppliers) {
            lines.add(String.join("|",
                    s.getId(),
                    s.getName(),
                    s.getContactNumber(),
                    s.getAddress(),
                    s.getCompanyName(),
                    s.getBusinessRegistrationNumber()
            ));
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}