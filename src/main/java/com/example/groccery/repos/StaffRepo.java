package com.example.groccery.repos;

import com.example.groccery.models.Staff;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class StaffRepo {

    private static final String FILE_NAME = "staff.txt";

    public String generateId() throws IOException {
        List<Staff> staffList = findAll();
        AtomicInteger max = new AtomicInteger(0);
        staffList.forEach(s -> {
            try {
                int idNum = Integer.parseInt(s.getId());
                if (idNum > max.get()) max.set(idNum);
            } catch (NumberFormatException ignored) {}
        });
        return String.valueOf(max.get() + 1);
    }

    public List<Staff> findAll() throws IOException {
        Path path = Paths.get(FILE_NAME);
        if (!Files.exists(path)) Files.createFile(path);

        List<String> lines = Files.readAllLines(path);
        List<Staff> staffList = new ArrayList<>();

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length == 7) {
                Staff staff = new Staff(
                        parts[0], parts[1], parts[2], parts[3],
                        Double.parseDouble(parts[4]), parts[5], parts[6]
                );
                staffList.add(staff);
            }
        }

        return staffList;
    }

    public Optional<Staff> findById(String id) throws IOException {
        List<Staff> staffList = findAll();
        return staffList.stream().filter(s -> s.getId().equals(id)).findFirst();
    }

    public void save(Staff staff) throws IOException {
        List<Staff> staffList = findAll();
        boolean exists = false;

        for (int i = 0; i < staffList.size(); i++) {
            if (staffList.get(i).getId().equals(staff.getId())) {
                staffList.set(i, staff);
                exists = true;
                break;
            }
        }

        if (!exists) {
            staffList.add(staff);
        }

        writeToFile(staffList);
    }

    public boolean deleteById(String id) throws IOException {
        List<Staff> staffList = findAll();
        boolean removed = staffList.removeIf(s -> s.getId().equals(id));
        if (removed) writeToFile(staffList);
        return removed;
    }

    private void writeToFile(List<Staff> staffList) throws IOException {
        List<String> lines = new ArrayList<>();
        for (Staff s : staffList) {
            lines.add(String.join("|",
                    s.getId(),
                    s.getName(),
                    s.getNicNumber(),
                    s.getJoinedDate(),
                    String.valueOf(s.getSalary()),
                    s.getAddress(),
                    s.getContactNumber()
            ));
        }
        Files.write(Paths.get(FILE_NAME), lines);
    }
}