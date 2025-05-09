package com.example.groccery.dtos;

import com.example.groccery.models.Product;

public class ProductDTOs {

    // DTO for creating and updating product
    public static class ProductRequest {

        private String name;
        private String description;
        private String imageUrl;
        private Integer inStockQuantity;
        private Double price;
        private String category;

        public ProductRequest() {}

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }

        public Integer getInStockQuantity() {
            return inStockQuantity;
        }

        public void setInStockQuantity(Integer inStockQuantity) {
            this.inStockQuantity = inStockQuantity;
        }

        public Double getPrice() {
            return price;
        }

        public void setPrice(Double price) {
            this.price = price;
        }

        public String getCategory() {
            return category;
        }

        public void setCategory(String category) {
            this.category = category;
        }

        // Method to apply partial updates
        public static void updateProduct(Product product, ProductRequest request) {
            if (request.getName() != null) {
                product.setName(request.getName());
            }
            if (request.getDescription() != null) {
                product.setDescription(request.getDescription());
            }
            if (request.getImageUrl() != null) {
                product.setImageUrl(request.getImageUrl());
            }
            if (request.getInStockQuantity() != null) {
                product.setInStockQuantity(request.getInStockQuantity());
            }
            if (request.getPrice() != null) {
                product.setPrice(request.getPrice());
            }
            if (request.getCategory() != null) {
                product.setCategory(request.getCategory());
            }
        }
    }
}