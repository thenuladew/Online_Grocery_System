package com.example.groccery.dtos;

import com.example.groccery.models.Feedback;

public class FeedbackDTOs {

    // DTO for creating feedback
    public static class FeedbackRequest {

        private String comment;
        private int rating;
        private String productId;
        private String userId;

        public FeedbackRequest() {}

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }

        public int getRating() {
            return rating;
        }

        public void setRating(int rating) {
            this.rating = rating;
        }

        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public String getUserId() {
            return userId;
        }

        public void setUserId(String userId) {
            this.userId = userId;
        }
    }
    public static class FeedbackUpdateRequest {
        private String comment;
        private int rating;

        public String getComment() {
            return comment;
        }

        public void setComment(String comment) {
            this.comment = comment;
        }

        public int getRating() {
            return rating;
        }

        public void setRating(int rating) {
            this.rating = rating;
        }
    }
    // DTO for response that includes product info
    public static class FeedbackResponse {

        private String id;
        private String comment;
        private int rating;
        private ProductResponse product;
        private UserResponse user;

        public FeedbackResponse(String id, String comment, int rating, ProductResponse product, UserResponse user) {
            this.id = id;
            this.comment = comment;
            this.rating = rating;
            this.product = product;
            this.user = user;
        }

        public String getId() {
            return id;
        }

        public String getComment() {
            return comment;
        }

        public int getRating() {
            return rating;
        }

        public ProductResponse getProduct() {
            return product;
        }

        public UserResponse getUser() {
            return user;
        }
    }

    // Nested ProductResponse for embedding in feedback response
    public static class ProductResponse {
        private String id;
        private String name;
        private String category;

        public ProductResponse(String id, String name, String category) {
            this.id = id;
            this.name = name;
            this.category = category;
        }

        public String getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }
    }

    // Nested UserResponse for embedding in feedback response
    public static class UserResponse {
        private String id;
        private String name;

        public UserResponse(String id, String name) {
            this.id = id;
            this.name = name;
        }

        public String getId() {
            return id;
        }

        public String getName() {
            return name;
        }
    }
}