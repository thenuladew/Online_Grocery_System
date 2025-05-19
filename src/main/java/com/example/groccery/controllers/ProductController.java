package com.example.groccery.controllers;

import com.example.groccery.dtos.FeedbackDTOs;
import com.example.groccery.dtos.ProductDTOs;
import com.example.groccery.models.Product;
import com.example.groccery.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() throws IOException {
        return ResponseEntity.ok(productService.getAllProducts());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable String id) throws IOException {
        return productService.getProductById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @PostMapping
    public ResponseEntity<Product> createProduct(@RequestBody Product product) throws IOException {
        Product created = productService.createProduct(product);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Product> updateProduct(
            @PathVariable String id,
            @RequestBody ProductDTOs.ProductRequest request) throws IOException {
        return productService.updateProduct(id, request)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable String id) throws IOException {
        boolean deleted = productService.deleteProduct(id);
        return deleted
                ? ResponseEntity.noContent().build()
                : ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @GetMapping("/{id}/feedbacks")
    public ResponseEntity<List<FeedbackDTOs.FeedbackResponse>> getProductFeedbacks(@PathVariable String id) throws IOException {
        List<FeedbackDTOs.FeedbackResponse> feedbacks = productService.getProductFeedbacks(id);
        return ResponseEntity.ok(feedbacks);
    }
    @GetMapping("/sorted")
    public ResponseEntity<List<Product>> getAllProductsSorted(@RequestParam(defaultValue = "price") String sortBy) throws IOException {
        return ResponseEntity.ok(productService.getAllProductsSorted(sortBy));
    }
}