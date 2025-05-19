package com.example.groccery.services;

import com.example.groccery.dtos.CustomerDTOs;
import com.example.groccery.models.Customer;
import com.example.groccery.repos.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepo customerRepo;

    public List<Customer> getAllCustomers() throws IOException {
        return customerRepo.findAll();
    }

    public Optional<Customer> getCustomerById(String id) throws IOException {
        return customerRepo.findById(id);
    }

    public Customer createCustomer(Customer customer) throws IOException {
        if (customerRepo.existsByEmail(customer.getEmail())) {
            throw new RuntimeException("Email already registered");
        }
        customer.setId(customerRepo.generateId());
        customerRepo.save(customer);
        return customer;
    }

    public Optional<Customer> updateCustomer(String id, CustomerDTOs.CustomerRequest request) throws IOException {
        Optional<Customer> optionalCustomer = customerRepo.findById(id);
        if (optionalCustomer.isPresent()) {
            Customer customer = optionalCustomer.get();
            CustomerDTOs.CustomerRequest.updateCustomer(customer, request);
            customerRepo.save(customer);
            return Optional.of(customer);
        }
        return Optional.empty();
    }

    public boolean deleteCustomer(String id) throws IOException {
        return customerRepo.deleteById(id);
    }

    public CustomerDTOs.LoginResponse login(String email, String password) throws IOException {
        Optional<Customer> optionalCustomer = customerRepo.findByEmail(email);
        if (optionalCustomer.isPresent()) {
            Customer customer = optionalCustomer.get();
            if (customer.getPassword().equals(password)) {
                return new CustomerDTOs.LoginResponse(true, "Login successful", customer.getId());
            } else {
                return new CustomerDTOs.LoginResponse(false, "Invalid password", null);
            }
        } else {
            return new CustomerDTOs.LoginResponse(false, "Email not found", null);
        }
    }
}