package com.grocery.system.dto;

public class Customer {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String address;

    public Customer() {
        id = 0;
        name = "null";
        phone = "empty";
        email = "null";
        address = "empty";
    }

    public Customer(int id, String address, String email, String phone, String name) {
        this.id = id;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.name = name;
    }

    //getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    

}
