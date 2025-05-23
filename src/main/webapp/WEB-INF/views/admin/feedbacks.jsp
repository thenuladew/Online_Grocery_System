<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Feedbacks</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">

    <jsp:include page="../common/navbarAdmin.jsp"/>

<div class="max-w-6xl mx-auto px-4 py-8">

    <!-- Back Button -->
    <div class="mb-6">
        <a href="/admin" class="font-bold text-black-700 flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Back to Dashboard</span>
        </a>
    </div>

    <!-- Page Title -->
    <h1 class="text-3xl font-bold mb-6 text-green-700">All Customer Feedbacks</h1>

    <!-- Search Bar -->
    <div class="mb-6">
        <div class="flex gap-4">
            <div class="flex-1">
                <input type="text" id="searchInput" 
                       placeholder="Search by customer name or product name..."
                       class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent">
            </div>
            <button onclick="clearSearch()" 
                    class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition duration-200">
                Clear
            </button>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div id="loading" class="text-center text-green-600 font-semibold mb-4">
        Loading feedbacks...
    </div>

    <!-- Feedback Grid -->
    <div id="feedbackGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 hidden">
        <!-- Feedback cards will be inserted here -->
    </div>

    <!-- No Results Message -->
    <div id="noResults" class="text-center text-gray-500 text-lg hidden">
        No feedbacks found matching your search.
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const feedbackGrid = document.getElementById("feedbackGrid");
    const noResultsDiv = document.getElementById("noResults");
    const searchInput = document.getElementById("searchInput");
    let allFeedbacks = [];

    // Load feedbacks on page load
    window.onload = function () {
        fetch("/api/feedbacks")
            .then(function (response) {
                return response.json();
            })
            .then(function (feedbacks) {
                allFeedbacks = feedbacks;
                renderFeedbacks(feedbacks);
            })
            .catch(function (error) {
                console.error("Error fetching feedbacks:", error);
                loadingDiv.textContent = "Failed to load feedbacks.";
            });
    };

    // Add search input event listener
    searchInput.addEventListener('input', function() {
        filterFeedbacks(this.value.trim());
    });

    
    function filterFeedbacks(searchTerm) {
        if (!searchTerm) {
            renderFeedbacks(allFeedbacks);
            return;
        }

        const filteredFeedbacks = allFeedbacks.filter(feedback => {
            const customerName = feedback.user ? feedback.user.name.toLowerCase() : 'anonymous';
            const productName = feedback.product.name.toLowerCase();
            const searchLower = searchTerm.toLowerCase();

            return customerName.includes(searchLower) || productName.includes(searchLower);
        });

        renderFeedbacks(filteredFeedbacks);
    }

    // Clear search and show all feedbacks
    function clearSearch() {
        searchInput.value = '';
        renderFeedbacks(allFeedbacks);
    }

    // Render feedbacks into cards
    function renderFeedbacks(feedbacks) {
        feedbackGrid.innerHTML = "";
        loadingDiv.classList.add("hidden");
        feedbackGrid.classList.remove("hidden");
        noResultsDiv.classList.add("hidden");

        if (feedbacks.length === 0) {
            feedbackGrid.classList.add("hidden");
            noResultsDiv.classList.remove("hidden");
            return;
        }

        feedbacks.forEach(function (feedback) {
            var card = document.createElement("div");
            card.className = "bg-white rounded-lg shadow-md p-4 hover:shadow-lg transition duration-200";

            var stars = '';
            for (var i = 0; i < 5; i++) {
                if (i < feedback.rating) {
                    stars += '<span class="text-yellow-500">&#9733;</span>';
                } else {
                    stars += '<span class="text-gray-400">&#9733;</span>';
                }
            }

            card.innerHTML =
                "<h2 class=\"text-xl font-semibold text-gray-800 mb-2\">" + escapeHtml(feedback.product.name) + "</h2>" +
                "<p class=\"text-sm text-gray-600 mb-2\">" + escapeHtml(feedback.product.category) + "</p>" +
                "<div class=\"flex mb-2\">" + stars + "</div>" +
                "<p class=\"text-gray-700 mb-2\">" + escapeHtml(feedback.comment) + "</p>" +
                "<p class=\"text-sm text-gray-500\">By: " + (feedback.user ? escapeHtml(feedback.user.name) : "Anonymous") + "</p>";

            feedbackGrid.appendChild(card);
        });
    }

    // Escape HTML to prevent XSS
    function escapeHtml(text) {
        return text.replace(/[&<>"']/g, function(m) {
            return ({
                '&': '&amp;',
                '<': '<',
                '>': '>',
                '"': '&quot;',
                "'": '&#39;'
            })[m];
        });
    }
</script>

</body>
</html>