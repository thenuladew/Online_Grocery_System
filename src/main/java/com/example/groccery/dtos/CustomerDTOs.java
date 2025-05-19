package com.example.groccery.dtos;

import com.example.groccery.models.Customer;

public class CustomerDTOs {

    // DTO for creating or updating customer
    public static class CustomerRequest {

        private String name;
        private String address;
        private String email;
        private String contactNumber;
        private String password;

        public CustomerRequest() {}

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public static void updateCustomer(Customer customer, CustomerRequest request) {
            if (request.getName() != null) {
                customer.setName(request.getName());
            }
            if (request.getAddress() != null) {
                customer.setAddress(request.getAddress());
            }
            if (request.getEmail() != null) {
                customer.setEmail(request.getEmail());
            }
            if (request.getContactNumber() != null) {
                customer.setContactNumber(request.getContactNumber());
            }
            if (request.getPassword() != null) {
                customer.setPassword(request.getPassword());
            }
        }
    }

    // DTO for login request
    public static class LoginRequest {
        private String email;
        private String password;

        public LoginRequest() {}

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    // DTO for login response
    public static class LoginResponse {
        private boolean success;
        private String message;
        private String customerId;

        public LoginResponse(boolean success, String message, String customerId) {
            this.success = success;
            this.message = message;
            this.customerId = customerId;
        }

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public String getCustomerId() {
            return customerId;
        }

        public void setCustomerId(String customerId) {
            this.customerId = customerId;
        }
    }
}