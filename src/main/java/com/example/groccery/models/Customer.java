package com.example.groccery.models;

public class Customer {

    private String id;
    private String name;
    private String address;
    private String email;
    private String contactNumber;
    private String password;

    public Customer() {}

    public Customer(String id, String name, String address, String email, String contactNumber, String password) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.email = email;
        this.contactNumber = contactNumber;
        this.password = password;
    }

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
}