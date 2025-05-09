package com.example.groccery.dtos;

import com.example.groccery.models.Order;

import java.util.ArrayList;
import java.util.List;

public class OrderDTOs {

    public static class OrderRequest {

        private List<ProductRequest> products;
        private String customerName;
        private String customerEmail;
        private String address;
        private String status;

        public Order toOrder() {
            List<Order.ProductSummary> productSummaries = new ArrayList<>();
            if (products != null) {
                for (ProductRequest pr : products) {
                    productSummaries.add(new Order.ProductSummary(
                            pr.getProductId(),
                            pr.getName(),
                            pr.getCategory()
                    ));
                }
            }
            return new Order(null, productSummaries, customerName, customerEmail, address, status);
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
    }

    public static class OrderUpdateRequest {
        private List<ProductRequest> products;
        private String status;
        private String address;

        public Order updateOrder(Order order) {
            System.out.println("Incoming status: " + this.status);
            System.out.println("Current order status before update: " + order.getStatus());

            if (this.products != null) {
                List<Order.ProductSummary> productSummaries = new ArrayList<>();
                for (ProductRequest pr : this.products) {
                    productSummaries.add(new Order.ProductSummary(
                            pr.getProductId(),
                            pr.getName(),
                            pr.getCategory()
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

    }

    public static class ProductRequest {
        private String productId;
        private String name;
        private String category;

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

    public static class OrderResponse {

        private String id;
        private List<ProductSummaryResponse> products;
        private String customerName;
        private String customerEmail;
        private String address;
        private String status;

        public OrderResponse(Order order) {
            this.id = order.getId();
            this.customerName = order.getCustomerName();
            this.customerEmail = order.getCustomerEmail();
            this.address = order.getAddress();
            this.status = order.getStatus();

            this.products = new ArrayList<>();
            for (Order.ProductSummary ps : order.getProducts()) {
                this.products.add(new ProductSummaryResponse(
                        ps.getProductId(), ps.getName(), ps.getCategory()
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

        public static class ProductSummaryResponse {
            private String productId;
            private String name;
            private String category;

            public ProductSummaryResponse(String productId, String name, String category) {
                this.productId = productId;
                this.name = name;
                this.category = category;
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
        }
    }
}