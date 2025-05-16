package com.example.groccery.controllers;

import com.example.groccery.dtos.OrderDTOs;
import com.example.groccery.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public ResponseEntity<List<OrderDTOs.OrderResponse>> getAllOrders() throws IOException {
        return ResponseEntity.ok(orderService.getAllOrders());
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTOs.OrderResponse> getOrderById(@PathVariable String id) throws IOException {
        return orderService.getOrderById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @PostMapping
    public ResponseEntity<OrderDTOs.OrderResponse> createOrder(@RequestBody OrderDTOs.OrderRequest request) throws IOException {
        OrderDTOs.OrderResponse created = orderService.createOrder(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<OrderDTOs.OrderResponse> updateOrder(
            @PathVariable String id,
            @RequestBody OrderDTOs.OrderUpdateRequest request) throws IOException {

        return orderService.updateOrder(id, request)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable String id) throws IOException {
        boolean deleted = orderService.deleteOrder(id);
        return deleted
                ? ResponseEntity.noContent().build()
                : ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    // Customer-related endpoints
    @GetMapping("/customer/{email}")
    public ResponseEntity<List<OrderDTOs.OrderResponse>> getOrdersByCustomerEmail(@PathVariable String email) throws IOException {
        return ResponseEntity.ok(orderService.getOrdersByCustomerEmail(email));
    }

    // Queue-related endpoints
    @PostMapping("/{id}/enqueue")
    public ResponseEntity<Void> enqueueOrder(@PathVariable String id) throws IOException {
        orderService.addToQueue(id);
        return ResponseEntity.accepted().build();
    }

    @PostMapping("/process")
    public ResponseEntity<String> processNextOrder() throws IOException {
        String orderId = orderService.processNextOrder();
        if (orderId != null) {
            return ResponseEntity.ok("Processed order ID: " + orderId);
        } else {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("No orders in queue.");
        }
    }

    @GetMapping("/queue")
    public ResponseEntity<List<String>> getQueueStatus() {
        return ResponseEntity.ok(orderService.getAllQueuedOrderIds());
    }
}