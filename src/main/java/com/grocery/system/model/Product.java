package com.grocery.system.model;

public class Product {
    private String productID;
    private String productName;
    private double price;
    private int quantity;
    private String category;
    private String description;

    //default constructor
    public Product(){
        productID = "none";
        productName = "none";
        price = 0;
        quantity = 0;
        category = "null";
        description = "null";
    }

    //constructor with parameters

    public Product(String productID, String description, String category, int quantity, double price, String productName) {
        this.productID = productID;
        this.description = description;
        this.category = category;
        this.quantity = quantity;
        this.price = price;
        this.productName = productName;
    }

    //getters and setters

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    //Show all the parameters
    public void Display(){
        System.out.println("Product ID: " + productID);
        System.out.println("Product Name: " + productName);
        System.out.println("Product Price: " + price);
        System.out.println("Product Quantity: " + quantity);
        System.out.println("Product Category: " + category);
        System.out.println("Product Description: " + description);
    }

    public String toString() {
        return "Product{" +
                "productID='" + productID + '\'' +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", category='" + category + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
