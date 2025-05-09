package com.example.groccery.views;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ProductViewController {

    @GetMapping("/create-product")
    public String showCreateProductForm() {
        return "product/create";
    }

    @GetMapping("/edit-product/{id}")
    public String showEditProductForm(@PathVariable String id) {
        return "product/edit";
    }
}