package com.example.groccery.services;

import com.example.groccery.dtos.OrderDTOs;
import com.example.groccery.models.Order;
import com.example.groccery.models.Product;
import com.example.groccery.repos.OrderRepo;
import com.example.groccery.repos.ProductRepo;
import com.example.groccery.utils.OrderQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Arrays;

@Service
public class OrderService {

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private OrderQueue orderQueue;

    @Autowired
    private ProductRepo productRepo;

    public List<OrderDTOs.OrderResponse> getAllOrders() throws IOException {
        return orderRepo.findAll().stream()
                .map(OrderDTOs.OrderResponse::new)
                .collect(Collectors.toList());
    }

    public Optional<OrderDTOs.OrderResponse> getOrderById(String id) throws IOException {
        return orderRepo.findById(id).map(OrderDTOs.OrderResponse::new);
    }

    public OrderDTOs.OrderResponse createOrder(OrderDTOs.OrderRequest request) throws IOException {
        Order order = request.toOrder();
        order.setId(orderRepo.generateId());
        orderRepo.save(order);
        return new OrderDTOs.OrderResponse(order);
    }

    public Optional<OrderDTOs.OrderResponse> updateOrder(String id, OrderDTOs.OrderUpdateRequest request) throws IOException {
        Optional<Order> optionalOrder = orderRepo.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            String oldStatus = order.getStatus();
            Order newOrder = request.updateOrder(order);

            // If status is changing to "Shipped" or "Delivered", update product quantities
            if ((newOrder.getStatus().equals("Shipped") || newOrder.getStatus().equals("Delivered")) 
                && !oldStatus.equals("Shipped") && !oldStatus.equals("Delivered")) {
                updateProductQuantities(newOrder);
            }

            orderRepo.save(newOrder);
            return Optional.of(new OrderDTOs.OrderResponse(newOrder));
        }
        return Optional.empty();
    }

    private void updateProductQuantities(Order order) throws IOException {
        for (Order.ProductSummary productSummary : order.getProducts()) {
            Optional<Product> optionalProduct = productRepo.findById(productSummary.getProductId());
            if (optionalProduct.isPresent()) {
                Product product = optionalProduct.get();
                int newQuantity = product.getInStockQuantity() - productSummary.getQuantity();
                if (newQuantity >= 0) {
                    product.setInStockQuantity(newQuantity);
                    productRepo.save(product);
                } else {
                    throw new RuntimeException("Insufficient stock for product: " + product.getName());
                }
            }
        }
    }

    public boolean deleteOrder(String id) throws IOException {
        return orderRepo.deleteById(id);
    }

    // Get orders by customer
    public List<OrderDTOs.OrderResponse> getOrdersByCustomerEmail(String email) throws IOException {
        return orderRepo.findByCustomerEmail(email).stream()
                .map(OrderDTOs.OrderResponse::new)
                .collect(Collectors.toList());
    }

    // Queue methods
    public void addToQueue(String orderId) throws IOException {
        orderQueue.enqueue(orderId);
    }

    public String processNextOrder() throws IOException {
        return orderQueue.dequeue();
    }

    public List<String> getAllQueuedOrderIds() {
        return Arrays.asList(orderQueue.getAllOrdersInQueue());
    }
}