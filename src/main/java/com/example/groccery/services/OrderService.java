package com.example.groccery.services;

import com.example.groccery.dtos.OrderDTOs;
import com.example.groccery.models.Order;
import com.example.groccery.repos.OrderRepo;
import com.example.groccery.utils.OrderQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private OrderQueue orderQueue;

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
            System.out.println(optionalOrder.get().getStatus());
            Order order = optionalOrder.get();

            Order neworder=  request.updateOrder(order);

            System.out.println(neworder.getStatus());
            orderRepo.save(neworder);
            return Optional.of(new OrderDTOs.OrderResponse(order));
        }
        System.out.println("Order not find from id "+id);
        return Optional.empty();

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
        return orderQueue.getAllOrdersInQueue();
    }
}