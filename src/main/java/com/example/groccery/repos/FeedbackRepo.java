package com.example.groccery.repos;

import com.example.groccery.models.Feedback;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class FeedbackRepo {

    private static final String FILE_NAME = "feedback.txt";

    public String generateId() throws IOException {
        List<Feedback> feedbacks = findAll();
        AtomicInteger max = new AtomicInteger(0);
        feedbacks.forEach(f -> {
            try {
                int idNum = Integer.parseInt(f.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    public List<Feedback> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Feedback> feedbacks = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length == 4) {
                Feedback feedback = new Feedback(parts[0], parts[1], Integer.parseInt(parts[2]), parts[3]);
                feedbacks.add(feedback);
            }
        }

        return feedbacks;
    }
    public boolean update(Feedback feedback) throws IOException {
        List<Feedback> feedbacks = findAll();
        boolean found = false;

        for (int i = 0; i < feedbacks.size(); i++) {
            if (feedbacks.get(i).getId().equals(feedback.getId())) {
                feedbacks.set(i, feedback);
                found = true;
                break;
            }
        }

        if (!found) return false;

        writeToFile(feedbacks);
        return true;
    }
    public List<Feedback> findByProductId(String productId) throws IOException {
        List<Feedback> all = findAll();
        List<Feedback> result = new ArrayList<>();
        for (Feedback f : all) {
            if (f.getProductId().equals(productId)) {
                result.add(f);
            }
        }
        return result;
    }

    public Optional<Feedback> findById(String id) throws IOException {
        List<Feedback> feedbacks = findAll();
        return feedbacks.stream().filter(f -> f.getId().equals(id)).findFirst();
    }

    public void save(Feedback feedback) throws IOException {
        List<Feedback> feedbacks = findAll();
        boolean exists = false;

        for (int i = 0; i < feedbacks.size(); i++) {
            if (feedbacks.get(i).getId().equals(feedback.getId())) {
                feedbacks.set(i, feedback);
                exists = true;
                break;
            }
        }

        if (!exists) {
            feedbacks.add(feedback);
        }

        writeToFile(feedbacks);
    }

    public boolean deleteById(String id) throws IOException {
        List<Feedback> feedbacks = findAll();
        boolean removed = feedbacks.removeIf(f -> f.getId().equals(id));
        if (removed) writeToFile(feedbacks);
        return removed;
    }

    private void writeToFile(List<Feedback> feedbacks) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Feedback f : feedbacks) {
            lines.add(String.join("|",
                    f.getId(),
                    f.getComment(),
                    String.valueOf(f.getRating()),
                    f.getProductId()
            ));
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}