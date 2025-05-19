package com.example.groccery.dtos;

import com.example.groccery.models.Supplier;

public class SupplierDTOs {

    // DTO
    public static class SupplierRequest {

        private String name;
        private String contactNumber;
        private String address;
        private String companyName;
        private String businessRegistrationNumber;

        public SupplierRequest() {}

        // Getters for all fields

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getCompanyName() {
            return companyName;
        }

        public void setCompanyName(String companyName) {
            this.companyName = companyName;
        }

        public String getBusinessRegistrationNumber() {
            return businessRegistrationNumber;
        }

        public void setBusinessRegistrationNumber(String businessRegistrationNumber) {
            this.businessRegistrationNumber = businessRegistrationNumber;
        }
    }

    // Utility method to apply partial updates to a Supplier from the DTO
    public static void updateSupplier(Supplier supplier, SupplierRequest request) {
        if (request.getName() != null) {
            supplier.setName(request.getName());
        }
        if (request.getContactNumber() != null) {
            supplier.setContactNumber(request.getContactNumber());
        }
        if (request.getAddress() != null) {
            supplier.setAddress(request.getAddress());
        }
        if (request.getCompanyName() != null) {
            supplier.setCompanyName(request.getCompanyName());
        }
        if (request.getBusinessRegistrationNumber() != null) {
            supplier.setBusinessRegistrationNumber(request.getBusinessRegistrationNumber());
        }
    }
}