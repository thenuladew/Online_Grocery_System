package com.example.groccery.views;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping
    public String home() {
        return "index";
    }

    @GetMapping("/admin")
    public String admin() {
        return "admin/index";
    }

    @GetMapping("/orders")
    public String orders() {
        return "admin/orders";
    }

    @GetMapping("/staff")
    public String staff() {
        return "admin/staff";
    }

    @GetMapping("/products")
    public String products() {
        return "admin/products";
    }

    @GetMapping("/customers")
    public String customers() {
        return "admin/customers";
    }

    @GetMapping("/feedbacks")
    public String feedbacks() {
        return "admin/feedbacks";
    }

    @GetMapping("/supplier")
    public String supplier() {
        return "admin/supplier";
    }

    @GetMapping("/login")
    public String login() {
        return "customer/login";
    }

    @GetMapping("/register")
    public String register() {
        return "customer/create";
    }

    @GetMapping("/profile")
    public String profile() {
        return "customer/profile";
    }
    @GetMapping("/edit-profile")
    public String editProfile() {
        return "customer/edit";
    }

    @GetMapping("/cart")
    public String cart() {
        return "order/cart";
    }

    @GetMapping("/create-order")
    public String createOrder() {
        return "order/create";
    }

    @GetMapping("/my-orders")
    public String myOrders() {
        return "order/my_orders";
    }
}