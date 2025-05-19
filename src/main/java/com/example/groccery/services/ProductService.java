package com.example.groccery.services;

import com.example.groccery.dtos.FeedbackDTOs;
import com.example.groccery.dtos.ProductDTOs;
import com.example.groccery.models.Product;
import com.example.groccery.repos.ProductRepo;
import com.example.groccery.utils.ProductsMergeSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepo productRepo;

    public List<Product> getAllProducts() throws IOException {
        return productRepo.findAll();
    }

    public Optional<Product> getProductById(String id) throws IOException {
        return productRepo.findById(id);
    }

    public Product createProduct(Product product) throws IOException {
        product.setId(productRepo.generateId());
        productRepo.save(product);
        return product;
    }

    public Optional<Product> updateProduct(String id, ProductDTOs.ProductRequest request) throws IOException {
        Optional<Product> optionalProduct = productRepo.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            ProductDTOs.ProductRequest.updateProduct(product, request);
            productRepo.save(product);
            return Optional.of(product);
        }
        return Optional.empty();
    }

    public boolean deleteProduct(String id) throws IOException {
        return productRepo.deleteById(id);
    }

    @Autowired
    private FeedbackService feedbackService;

    public List<FeedbackDTOs.FeedbackResponse> getProductFeedbacks(String productId) throws IOException {
        return feedbackService.getFeedbacksByProductId(productId);
    }

    public List<Product> getAllProductsSorted(String sortBy) throws IOException {
        List<Product> products = productRepo.findAll();
        ProductsMergeSort.sort(products, sortBy);
        return products;
    }
}