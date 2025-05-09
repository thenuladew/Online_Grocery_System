package com.example.groccery.services;

import com.example.groccery.dtos.SupplierDTOs;
import com.example.groccery.models.Supplier;
import com.example.groccery.repos.SupplierRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class SupplierService {

    @Autowired
    private SupplierRepo supplierRepo;

    public List<Supplier> getAllSuppliers() throws IOException {
        return supplierRepo.findAll();
    }

    public Optional<Supplier> getSupplierById(String id) throws IOException {
        return supplierRepo.findById(id);
    }

    public Supplier createSupplier(Supplier supplier) throws IOException {
        supplier.setId(supplierRepo.generateId());
        supplierRepo.save(supplier);
        return supplier;
    }

    public Optional<Supplier> updateSupplier(String id, SupplierDTOs.SupplierRequest request) throws IOException {
        Optional<Supplier> optionalSupplier = supplierRepo.findById(id);
        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            SupplierDTOs.updateSupplier(supplier, request);
            supplierRepo.save(supplier);
            return Optional.of(supplier);
        }
        return Optional.empty();
    }

    public boolean deleteSupplier(String id) throws IOException {
        return supplierRepo.deleteById(id);
    }
}