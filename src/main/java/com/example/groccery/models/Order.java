package com.example.groccery.models;

import java.util.ArrayList;
import java.util.List;

public class Order {

    private String id;
    private List<ProductSummary> products;
    private String customerName;
    private String customerEmail;
    private String address; // new field
    private String status;

    public Order() {
        this.products = new ArrayList<>();
    }

    public Order(String id, List<ProductSummary> products, String customerName, String customerEmail, String address, String status) {
        this.id = id;
        this.products = products != null ? products : new ArrayList<>();
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.address = address;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<ProductSummary> getProducts() {
        return products;
    }

    public void setProducts(List<ProductSummary> products) {
        this.products = products;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void addProduct(ProductSummary productSummary) {
        this.products.add(productSummary);
    }

    public static class ProductSummary {
        private String productId;
        private String name;
        private String category;

        public ProductSummary() {}

        public ProductSummary(String productId, String name, String category) {
            this.productId = productId;
            this.name = name;
            this.category = category;
        }

        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getCategory() {
            return category;
        }

        public void setCategory(String category) {
            this.category = category;
        }
    }
}