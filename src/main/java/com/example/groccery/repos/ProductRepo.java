package com.example.groccery.repos;

import com.example.groccery.models.Product;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class ProductRepo {

    private static final String FILE_NAME = "product.txt";

    public String generateId() throws IOException {
        List<Product> products = findAll();
        AtomicInteger max = new AtomicInteger(0);
        products.forEach(p -> {
            try {
                int idNum = Integer.parseInt(p.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    public List<Product> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Product> products = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length == 8) {
                Product product = new Product(
                        parts[0], parts[1], parts[2], parts[3],
                        Integer.parseInt(parts[4]), Double.parseDouble(parts[5]), parts[6], parts[7]
                );
                products.add(product);
            }
        }

        return products;
    }

    public Optional<Product> findById(String id) throws IOException {
        List<Product> products = findAll();
        return products.stream().filter(p -> p.getId().equals(id)).findFirst();
    }

    public void save(Product product) throws IOException {
        List<Product> products = findAll();
        boolean exists = false;

        for (int i = 0; i < products.size(); i++) {
            if (products.get(i).getId().equals(product.getId())) {
                products.set(i, product);
                exists = true;
                break;
            }
        }

        if (!exists) {
            products.add(product);
        }

        writeToFile(products);
    }

    public boolean deleteById(String id) throws IOException {
        List<Product> products = findAll();
        boolean removed = products.removeIf(p -> p.getId().equals(id));
        if (removed) writeToFile(products);
        return removed;
    }

    private void writeToFile(List<Product> products) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Product p : products) {
            lines.add(String.join("|",
                    p.getId(),
                    p.getName(),
                    p.getDescription(),
                    p.getImageUrl(),
                    String.valueOf(p.getInStockQuantity()),
                    String.valueOf(p.getPrice()),
                    p.getCategory(),
                    p.getSupplierId()
            ));
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}