package com.example.groccery.dtos;

import com.example.groccery.models.Staff;

public class StaffDTOs {

    public static class StaffRequest {

        private String name;
        private String nicNumber;
        private String joinedDate;
        private Double salary;
        private String address;
        private String contactNumber;

        public StaffRequest() {}

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getNicNumber() {
            return nicNumber;
        }

        public void setNicNumber(String nicNumber) {
            this.nicNumber = nicNumber;
        }

        public String getJoinedDate() {
            return joinedDate;
        }

        public void setJoinedDate(String joinedDate) {
            this.joinedDate = joinedDate;
        }

        public Double getSalary() {
            return salary;
        }

        public void setSalary(Double salary) {
            this.salary = salary;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getContactNumber() {
            return contactNumber;
        }

        public void setContactNumber(String contactNumber) {
            this.contactNumber = contactNumber;
        }


    }
    public static void updateStaff(Staff staff, StaffRequest request) {
        if (request.getName() != null) {
            staff.setName(request.getName());
        }
        if (request.getNicNumber() != null) {
            staff.setNicNumber(request.getNicNumber());
        }
        if (request.getJoinedDate() != null) {
            staff.setJoinedDate(request.getJoinedDate());
        }
        if (request.getSalary() != null) {
            staff.setSalary(request.getSalary());
        }
        if (request.getAddress() != null) {
            staff.setAddress(request.getAddress());
        }
        if (request.getContactNumber() != null) {
            staff.setContactNumber(request.getContactNumber());
        }
    }
}