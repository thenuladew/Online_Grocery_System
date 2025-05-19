package com.example.groccery.models;

public class Staff {

    private String id;
    private String name;
    private String nicNumber;
    private String joinedDate;
    private double salary;
    private String address;
    private String contactNumber;

    public Staff() {}

    public Staff(String id, String name, String nicNumber, String joinedDate, double salary, String address, String contactNumber) {
        this.id = id;
        this.name = name;
        this.nicNumber = nicNumber;
        this.joinedDate = joinedDate;
        this.salary = salary;
        this.address = address;
        this.contactNumber = contactNumber;
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

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
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