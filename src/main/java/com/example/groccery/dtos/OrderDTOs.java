package com.example.groccery.dtos;

import com.example.groccery.models.Order;

import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class OrderDTOs {

    public static class OrderRequest {

        private List<ProductRequest> products;
        private String customerName;
        private String customerEmail;
        private String address;
        private String status;
        private String orderDate;

        public Order toOrder() {
            List<Order.ProductSummary> productSummaries = new ArrayList<>();
            if (products != null) {
                for (ProductRequest pr : products) {
                    productSummaries.add(new Order.ProductSummary(
                        pr.getProductId(),
                        pr.getName(),
                        pr.getCategory(),
                        pr.getPrice(),
                        pr.getQuantity()
                    ));
                }
            }
            return new Order(null, productSummaries, customerName, customerEmail, address, status, orderDate);
        }

        public List<ProductRequest> getProducts() {
            return products;
        }

        public void setProducts(List<ProductRequest> products) {
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

        public String getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(String orderDate) {
            this.orderDate = orderDate;
        }
    }

    public static class OrderUpdateRequest {
        private List<ProductRequest> products;
        private String status;
        private String address;
        private String orderDate;

        public Order updateOrder(Order order) {
            System.out.println("Incoming status: " + this.status);
            System.out.println("Current order status before update: " + order.getStatus());

            if (this.products != null) {
                List<Order.ProductSummary> productSummaries = new ArrayList<>();
                for (ProductRequest pr : this.products) {
                    productSummaries.add(new Order.ProductSummary(
                            pr.getProductId(),
                            pr.getName(),
                            pr.getCategory(),
                            pr.getPrice(),
                            pr.getQuantity()
                    ));
                }
                order.setProducts(productSummaries);
            }

            if (this.status != null) {
                order.setStatus(this.status);
                System.out.println("Status updated to: " + this.status);
            }

            if (this.address != null) {
                order.setAddress(this.address);
            }

            if (this.orderDate != null) {
                order.setOrderDate(this.orderDate);
            }

            return order;
        }

        public void setProducts(List<ProductRequest> products) {
            this.products = products;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(String orderDate) {
            this.orderDate = orderDate;
        }
    }

    public static class ProductRequest {
        private String productId;
        private String name;
        private String category;
        private double price;
        private int quantity;

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

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }

    public static class ProductSummaryResponse {
        private String productId;
        private String name;
        private String category;
        private double price;
        private int quantity;

        public ProductSummaryResponse(String productId, String name, String category, double price, int quantity) {
            this.productId = productId;
            this.name = name;
            this.category = category;
            this.price = price;
            this.quantity = quantity;
        }

        public String getProductId() {
            return productId;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }

        public double getPrice() {
            return price;
        }

        public int getQuantity() {
            return quantity;
        }
    }

    public static class OrderResponse {

        private String id;
        private List<ProductSummaryResponse> products;
        private String customerName;
        private String customerEmail;
        private String address;
        private String status;
        private String orderDate;

        public OrderResponse(Order order) {
            this.id = order.getId();
            this.customerName = order.getCustomerName();
            this.customerEmail = order.getCustomerEmail();
            this.address = order.getAddress();
            this.status = order.getStatus();
            this.orderDate = order.getOrderDate();

            this.products = new ArrayList<>();
            for (Order.ProductSummary ps : order.getProducts()) {
                this.products.add(new ProductSummaryResponse(
                    ps.getProductId(),
                    ps.getName(),
                    ps.getCategory(),
                    ps.getPrice(),
                    ps.getQuantity()
                ));
            }
        }

        public String getId() {
            return id;
        }

        public List<ProductSummaryResponse> getProducts() {
            return products;
        }

        public String getCustomerName() {
            return customerName;
        }

        public String getCustomerEmail() {
            return customerEmail;
        }

        public String getAddress() {
            return address;
        }

        public String getStatus() {
            return status;
        }

        public String getOrderDate() {
            return orderDate;
        }
    }
}