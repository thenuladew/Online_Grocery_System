package com.example.groccery.controllers;

import com.example.groccery.dtos.FeedbackDTOs;
import com.example.groccery.models.Feedback;
import com.example.groccery.services.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/feedbacks")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @PostMapping
    public ResponseEntity<Feedback> createFeedback(@RequestBody FeedbackDTOs.FeedbackRequest request) throws IOException {
        Feedback feedback = new Feedback();
        feedback.setComment(request.getComment());
        feedback.setRating(request.getRating());
        feedback.setProductId(request.getProductId());
        feedback.setUserId(request.getUserId());
        Feedback created = feedbackService.createFeedback(feedback);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @GetMapping
    public ResponseEntity<List<FeedbackDTOs.FeedbackResponse>> getAllFeedbacksWithProducts() throws IOException {
        return ResponseEntity.ok(feedbackService.getAllFeedbacksWithProducts());
    }

    @GetMapping("/{productId}")
    public ResponseEntity<List<FeedbackDTOs.FeedbackResponse>> getFeedbacksByProductId(@PathVariable String productId) throws IOException {
        List<FeedbackDTOs.FeedbackResponse> feedbacks = feedbackService.getFeedbacksByProductId(productId);
        return ResponseEntity.ok(feedbacks);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFeedback(@PathVariable String id) throws IOException {
        boolean deleted = feedbackService.deleteById(id);
        return deleted
                ? ResponseEntity.noContent().build()
                : ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateFeedback(
            @PathVariable String id,
            @RequestBody FeedbackDTOs.FeedbackUpdateRequest request) throws IOException {

        boolean updated = feedbackService.updateFeedback(id, request);

        return updated
                ? ResponseEntity.ok().build()
                : ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }
}