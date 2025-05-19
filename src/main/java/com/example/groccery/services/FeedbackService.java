package com.example.groccery.services;

import com.example.groccery.dtos.FeedbackDTOs;
import com.example.groccery.models.Feedback;
import com.example.groccery.models.Product;
import com.example.groccery.models.Customer;
import com.example.groccery.repos.FeedbackRepo;
import com.example.groccery.repos.ProductRepo;
import com.example.groccery.repos.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepo feedbackRepo;

    @Autowired
    private ProductRepo productRepo;

    @Autowired
    private CustomerRepo customerRepo;

    public List<FeedbackDTOs.FeedbackResponse> getAllFeedbacksWithProducts() throws IOException {
        List<Feedback> feedbacks = feedbackRepo.findAll();
        return mapToResponses(feedbacks);
    }

    public List<FeedbackDTOs.FeedbackResponse> getFeedbacksByProductId(String productId) throws IOException {
        List<Feedback> feedbacks = feedbackRepo.findByProductId(productId);
        return mapToResponses(feedbacks);
    }

    public Feedback createFeedback(Feedback feedback) throws IOException {
        feedback.setId(feedbackRepo.generateId());
        feedbackRepo.save(feedback);
        return feedback;
    }

    public boolean deleteById(String id) throws IOException {
        return feedbackRepo.deleteById(id);
    }

    private List<FeedbackDTOs.FeedbackResponse> mapToResponses(List<Feedback> feedbacks) throws IOException {
        return feedbacks.stream().map(f -> {
            try {
                Optional<Product> productOpt = productRepo.findById(f.getProductId());
                FeedbackDTOs.ProductResponse productResp = productOpt.map(p ->
                        new FeedbackDTOs.ProductResponse(
                                p.getId(), p.getName(), p.getCategory()
                        )
                ).orElse(null);

                Optional<Customer> customerOpt = customerRepo.findById(f.getUserId());
                FeedbackDTOs.UserResponse userResp = customerOpt.map(c ->
                        new FeedbackDTOs.UserResponse(
                                c.getId(), c.getName()
                        )
                ).orElse(null);

                return new FeedbackDTOs.FeedbackResponse(f.getId(), f.getComment(), f.getRating(), productResp, userResp);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
    }

    public boolean updateFeedback(String id, FeedbackDTOs.FeedbackUpdateRequest request) throws IOException {
        Optional<Feedback> optional = feedbackRepo.findById(id);
        if (optional.isPresent()) {
            Feedback feedback = optional.get();

            if (request.getComment() != null) {
                feedback.setComment(request.getComment());
            }

            if (request.getRating() > 0) {
                feedback.setRating(request.getRating());
            }

            return feedbackRepo.update(feedback);
        }
        return false;
    }
}