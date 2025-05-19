package com.example.groccery.services;

import com.example.groccery.dtos.StaffDTOs;
import com.example.groccery.models.Staff;
import com.example.groccery.repos.StaffRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class StaffService {

    @Autowired
    private StaffRepo staffRepo;

    public List<Staff> getAllStaff() throws IOException {
        return staffRepo.findAll();
    }

    public Optional<Staff> getStaffById(String id) throws IOException {
        return staffRepo.findById(id);
    }

    public Staff createStaff(Staff staff) throws IOException {
        staff.setId(staffRepo.generateId());
        staffRepo.save(staff);
        return staff;
    }

    public Optional<Staff> updateStaff(String id, StaffDTOs.StaffRequest request) throws IOException {
        Optional<Staff> optionalStaff = staffRepo.findById(id);
        if (optionalStaff.isPresent()) {
            Staff staff = optionalStaff.get();
            StaffDTOs.updateStaff(staff, request);
            staffRepo.save(staff);
            return Optional.of(staff);
        }
        return Optional.empty();
    }

    public boolean deleteStaff(String id) throws IOException {
        return staffRepo.deleteById(id);
    }
}
