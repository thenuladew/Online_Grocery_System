package com.example.groccery.models;

public class Supplier {

    private String id;
    private String name;
    private String contactNumber;
    private String address;
    private String companyName;
    private String businessRegistrationNumber;

    // Default constructor
    public Supplier() {}

    // Parameterized constructor (all fields)
    public Supplier(String id, String name, String contactNumber, String address,
                    String companyName, String businessRegistrationNumber) {
        this.id = id;
        this.name = name;
        this.contactNumber = contactNumber;
        this.address = address;
        this.companyName = companyName;
        this.businessRegistrationNumber = businessRegistrationNumber;
    }

    // Getters and Setters

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

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