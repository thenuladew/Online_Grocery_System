package com.example.groccery.models;

public class Feedback {

    private String id;
    private String comment;
    private int rating; // 1 to 5
    private String productId;

    public Feedback() {}

    public Feedback(String id, String comment, int rating, String productId) {
        this.id = id;
        this.comment = comment;
        this.rating = rating;
        this.productId = productId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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
}