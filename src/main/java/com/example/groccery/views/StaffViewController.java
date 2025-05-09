package com.example.groccery.views;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class StaffViewController {

    @GetMapping("/create-staff")
    public String showCreateStaffForm() {
        return "staff/create";
    }

    @GetMapping("/edit-staff/{id}")
    public String showEditStaffForm(@PathVariable String id) {
        return "staff/edit";
    }
}