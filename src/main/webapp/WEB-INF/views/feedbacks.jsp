<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .star {
        cursor: pointer;
    }
    .star svg {
        width: 1.5rem;
        height: 1.5rem;
        margin: 0 0.125rem;
    }
    .text-yellow-400 {
        color: #facc15;
    }
</style>
<div class="p-4">
    <h1 class="text-3xl text-[#2B2B2B]-700 mb-4 font-['Koulen']">Customer Feedback</h1>
    <div class="flex justify-end items-center mb-4">
        <button type="button" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition flex items-center font-['Koulen']" onclick="openCreateModal()">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-11a1 1 0 10-2 0v2H7a1 1 0 100 2h2v2a1 1 0 102 0v-2h2a1 1 0 100-2h-2V7z" clip-rule="evenodd" />
            </svg>
            Add Feedback
        </button>
    </div>

    <div id="errorAlert" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative hidden" role="alert"></div>

    <div id="feedbacksContainer" class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <!-- Feedbacks will be loaded here dynamically -->
        <div class="col-span-2 text-center py-4 text-gray-500" id="loadingMessage">
            Loading feedback data...
        </div>
        <div class="col-span-2 text-center py-4 text-gray-500 hidden" id="noFeedbackMessage">
            No feedback available. Be the first to leave feedback!
        </div>
    </div>

    <!-- Create Feedback Modal -->
    <div id="createFeedbackModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center hidden z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="flex justify-between items-center border-b px-6 py-3">
                <h5 class="text-lg font-medium">Add New Feedback</h5>
                <button type="button" class="text-gray-400 hover:text-gray-500" onclick="closeModal('createFeedbackModal')">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <div class="px-6 py-4">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative hidden" id="createModalError"></div>
                <div class="mb-4">
                    <label for="createProductSelect" class="block text-gray-700 text-sm font-bold mb-2">Product</label>
                    <select class="shadow border rounded w-full py-2 px-3 text-gray-700" id="createProductSelect" required>
                        <option value="">Select a product</option>
                        <!-- Products will be loaded here dynamically -->
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Rating</label>
                    <div class="star-rating">
                        <div class="flex">
                            <span class="star" data-rating="1"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="2"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="3"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="4"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="5"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                        </div>
                        <input type="hidden" id="createRatingInput" value="5">
                    </div>
                </div>
                <div class="mb-4">
                    <label for="createCommentInput" class="block text-gray-700 text-sm font-bold mb-2">Comment</label>
                    <textarea class="shadow border rounded w-full py-2 px-3 text-gray-700" id="createCommentInput" rows="3" required></textarea>
                </div>
            </div>
            <div class="bg-gray-50 px-6 py-3 flex justify-end">
                <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-medium py-2 px-4 rounded mr-2" onclick="closeModal('createFeedbackModal')">
                    Cancel
                </button>
                <button type="button" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded" onclick="createFeedback()">
                    Submit
                </button>
            </div>
        </div>
    </div>

    <!-- Edit Feedback Modal -->
    <div id="editFeedbackModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center hidden z-50">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
            <div class="flex justify-between items-center border-b px-6 py-3">
                <h5 class="text-lg font-medium">Edit Feedback</h5>
                <button type="button" class="text-gray-400 hover:text-gray-500" onclick="closeModal('editFeedbackModal')">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <div class="px-6 py-4">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative hidden" id="editModalError"></div>
                <input type="hidden" id="editFeedbackId">
                <div class="mb-4">
                    <label for="editProductSelect" class="block text-gray-700 text-sm font-bold mb-2">Product</label>
                    <select class="shadow border rounded w-full py-2 px-3 text-gray-700" id="editProductSelect" required>
                        <option value="">Select a product</option>
                        <!-- Products will be loaded here dynamically -->
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Rating</label>
                    <div class="star-rating">
                        <div class="flex">
                            <span class="star" data-rating="1"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="2"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="3"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="4"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                            <span class="star" data-rating="5"><svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg></span>
                        </div>
                        <input type="hidden" id="editRatingInput" value="5">
                    </div>
                </div>
                <div class="mb-4">
                    <label for="editCommentInput" class="block text-gray-700 text-sm font-bold mb-2">Comment</label>
                    <textarea class="shadow border rounded w-full py-2 px-3 text-gray-700" id="editCommentInput" rows="3" required></textarea>
                </div>
            </div>
            <div class="bg-gray-50 px-6 py-3 flex justify-end">
                <button type="button" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-medium py-2 px-4 rounded mr-2" onclick="closeModal('editFeedbackModal')">
                    Cancel
                </button>
                <button type="button" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded" onclick="updateFeedback()">
                    Update
                </button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetchFeedbacks();
            fetchProducts();
            setupStarRatings();
        });

        // Modal functions
        function openCreateModal() {
            // Reset form
            document.getElementById("createProductSelect").value = "";
            document.getElementById("createCommentInput").value = "";
            document.getElementById("createRatingInput").value = "5";
            document.getElementById("createModalError").classList.add("hidden");

            // Reset star display
            setStarRating(document.querySelector("#createFeedbackModal .star-rating"), 5);

            // Open modal
            document.getElementById("createFeedbackModal").classList.remove("hidden");
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.add("hidden");
        }

        // Fetch all feedbacks
        function fetchFeedbacks() {
            fetch("/api/feedbacks")
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch feedbacks");
                    }
                    return response.json();
                })
                .then(data => {
                    displayFeedbacks(data);
                })
                .catch(error => {
                    console.error("Error fetching feedbacks:", error);
                    showError("Error loading feedbacks");
                });
        }

        // Fetch all products
        function fetchProducts() {
            fetch("/api/products")
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch products");
                    }
                    return response.json();
                })
                .then(data => {
                    populateProductDropdowns(data);
                })
                .catch(error => {
                    console.error("Error fetching products:", error);
                    showError("Error loading products");
                });
        }

        // Display feedbacks in the UI
        function displayFeedbacks(feedbacks) {
            const container = document.getElementById("feedbacksContainer");
            const loadingMessage = document.getElementById("loadingMessage");
            const noFeedbackMessage = document.getElementById("noFeedbackMessage");
            const currentUserId = localStorage.getItem("userId");

            loadingMessage.classList.add("hidden");

            if (feedbacks.length === 0) {
                noFeedbackMessage.classList.remove("hidden");
                return;
            }

            noFeedbackMessage.classList.add("hidden");

            // Sort feedbacks to show current user's feedbacks first
            feedbacks.sort((a, b) => {
                const aIsCurrentUser = a.user && a.user.id === currentUserId;
                const bIsCurrentUser = b.user && b.user.id === currentUserId;
                if (aIsCurrentUser && !bIsCurrentUser) return -1;
                if (!aIsCurrentUser && bIsCurrentUser) return 1;
                return 0;
            });

            let html = "";
            feedbacks.forEach(feedback => {
                const isOwnFeedback = feedback.user && feedback.user.id === currentUserId;
                html +=
                    "<div class=\"bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300\">" +
                    "<div class=\"p-4\">" +
                    "<div class=\"flex justify-between\">" +
                    "<div>" +
                    "<h5 class=\"text-lg font-medium text-[#008637]\">" + feedback.product.name + "</h5>" +
                    "<h6 class=\"text-sm text-gray-500 mb-1\">" + feedback.product.category + "</h6>" +
                    "<div class=\"mb-2 flex text-yellow-400\">" +
                    generateStarRating(feedback.rating) +
                    "</div>" +
                    "<p class=\"text-gray-700\">" + feedback.comment + "</p>" +
                    "<p class=\"text-sm text-gray-500 mt-2\">By: " + (feedback.user ? feedback.user.name : "Anonymous") + "</p>" +
                    "</div>" +
                    (isOwnFeedback ? 
                    "<div>" +
                    "<button class=\"text-blue-600 hover:text-blue-800 p-1 mr-1\" onclick=\"openEditModal('" + feedback.id + "', '" + feedback.product.id + "', " + feedback.rating + ", '" + feedback.comment.replace(/'/g, "\\'") + "')\">" +
                    "<svg class=\"h-5 w-5\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">" +
                    "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z\" />" +
                    "</svg>" +
                    "</button>" +
                    "<button class=\"text-red-600 hover:text-red-800 p-1\" onclick=\"deleteFeedback('" + feedback.id + "')\">" +
                    "<svg class=\"h-5 w-5\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">" +
                    "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16\" />" +
                    "</svg>" +
                    "</button>" +
                    "</div>" : "") +
                    "</div>" +
                    "</div>" +
                    "</div>";
            });

            container.innerHTML = html;
        }

        // Populate product dropdowns
        function populateProductDropdowns(products) {
            const createDropdown = document.getElementById("createProductSelect");
            const editDropdown = document.getElementById("editProductSelect");

            let options = '<option value="">Select a product</option>';

            products.forEach(function(product) {
                options += "<option value=\"" + product.id + "\">" + product.name + " - " + product.category + "</option>";

            });

            createDropdown.innerHTML = options;
            editDropdown.innerHTML = options;
        }

        // Set up star rating functionality
        function setupStarRatings() {
            document.querySelectorAll(".star-rating .star").forEach(star => {
                star.addEventListener("click", function() {
                    const rating = parseInt(this.getAttribute("data-rating"));
                    const container = this.closest(".star-rating");
                    const input = container.querySelector("input[type='hidden']");

                    // Update hidden input value
                    input.value = rating;

                    // Update star display
                    setStarRating(container, rating);
                });
            });
        }

        // Set star rating display
        function setStarRating(container, rating) {
            container.querySelectorAll(".star").forEach(s => {
                const starRating = parseInt(s.getAttribute("data-rating"));
                if (starRating <= rating) {
                    s.querySelector("svg").classList.add("text-yellow-400");
                } else {
                    s.querySelector("svg").classList.remove("text-yellow-400");
                }
            });
        }

        // Generate star rating HTML
        function generateStarRating(rating) {
            let html = "";
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) {
                    html += '<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>';
                } else {
                    html += '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path></svg>';
                }
            }
            return html;
        }

        // Open edit feedback modal
        function openEditModal(feedbackId, productId, rating, comment) {
            document.getElementById("editFeedbackId").value = feedbackId;
            document.getElementById("editProductSelect").value = productId;
            document.getElementById("editCommentInput").value = comment;
            document.getElementById("editRatingInput").value = rating;
            document.getElementById("editModalError").classList.add("hidden");

            // Update star display
            setStarRating(document.querySelector("#editFeedbackModal .star-rating"), rating);

            // Open modal
            document.getElementById("editFeedbackModal").classList.remove("hidden");
        }

        // Create new feedback
        function createFeedback() {
            const productId = document.getElementById("createProductSelect").value;
            const comment = document.getElementById("createCommentInput").value;
            const rating = parseInt(document.getElementById("createRatingInput").value);
            const errorElement = document.getElementById("createModalError");

            // Validate input
            if (!productId || !comment.trim()) {
                errorElement.textContent = "Please fill in all required fields";
                errorElement.classList.remove("hidden");
                return;
            }

            const payload = {
                productId: productId,
                comment: comment,
                rating: rating,
                userId: localStorage.getItem("userId")
            };

            fetch("/api/feedbacks", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(payload)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Failed to create feedback");
                    }
                    return response.json();
                })
                .then(() => {
                    // Close modal and refresh feedbacks
                    closeModal("createFeedbackModal");
                    window.location.reload()
                })
                .catch(error => {
                    console.error("Error creating feedback:", error);
                    errorElement.textContent = "Failed to save feedback";
                    errorElement.classList.remove("hidden");
                });
        }

        // Update feedback
        function updateFeedback() {
            const feedbackId = document.getElementById("editFeedbackId").value;
            const productId = document.getElementById("editProductSelect").value;
            const comment = document.getElementById("editCommentInput").value;
            const rating = parseInt(document.getElementById("editRatingInput").value);
            const errorElement = document.getElementById("editModalError");

            // Validate input
            if (!productId || !comment.trim()) {
                errorElement.textContent = "Please fill in all required fields";
                errorElement.classList.remove("hidden");
                return;
            }

            const payload = {
                productId: productId,
                comment: comment,
                rating: rating
            };

            fetch(`/api/feedbacks/`+feedbackId, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(payload)
            })
                .then(response => {

                })
                .then(() => {
                    // Close modal and refresh feedbacks
                    closeModal("editFeedbackModal");
                    window.location.reload()
                })
                .catch(error => {
                    console.error("Error updating feedback:", error);
                    errorElement.textContent = "Failed to update feedback";
                    errorElement.classList.remove("hidden");
                });
        }

        // Delete feedback
        function deleteFeedback(feedbackId) {
            if (confirm("Are you sure you want to delete this feedback?")) {
                fetch(`/api/feedbacks/`+feedbackId, {
                    method: "DELETE"
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Failed to delete feedback");
                        }
                        // Refresh feedbacks
                        window.location.reload()
                    })
                    .catch(error => {
                        console.error("Error deleting feedback:", error);
                        showError("Failed to delete feedback");
                    });
            }
        }

        // Show error message
        function showError(message) {
            const errorAlert = document.getElementById("errorAlert");
            errorAlert.textContent = message;
            errorAlert.classList.remove("hidden");
            setTimeout(() => {
                errorAlert.classList.add("hidden");
            }, 5000);
        }
    </script>
</div>
