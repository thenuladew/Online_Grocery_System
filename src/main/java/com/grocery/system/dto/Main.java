package com.grocery.system.dto;

public class Main {
    public static void main(String[] args) {
        // Create a product with values
        Product p1 = new Product();
        p1.setProductID("P001");
        p1.setProductName("Apple");
        p1.setCategory("Fruits");
        p1.setPrice(1.99);
        p1.setQuantity(100);
        p1.setDescription("Fresh red apples");

        // Print the product
        System.out.println(p1.toString());

        // Or create using constructor if you have one
        Product p2 = new Product("P002", "Banana", "Fruits", (int) 0.99, 150, "Yellow bananas");
        System.out.println(p2.toString());

        // Test getters
        System.out.println("Product name: " + p1.getProductName());
        System.out.println("Product price: $" + p1.getPrice());
    }
}
