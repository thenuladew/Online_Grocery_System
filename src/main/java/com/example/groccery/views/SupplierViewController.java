package com.example.groccery.views;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class SupplierViewController {

    @GetMapping("/create-supplier")
    public String showCreateSupplierForm() {
        return "supplier/create";
    }

    @GetMapping("/edit-supplier/{id}")
    public String showEditSupplierForm(@PathVariable String id) {
        return "supplier/edit";
    }
}