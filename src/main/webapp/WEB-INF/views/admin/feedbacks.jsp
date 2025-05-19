<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Feedbacks</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-6xl mx-auto px-4 py-8">

    <!-- Back Button -->
    <div class="mb-6">
        <a href="/admin"
           class="inline-block bg-gray-600 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200">
            &larr; Back to Dashboard
        </a>
    </div>

    <!-- Page Title -->
    <h1 class="text-3xl font-bold mb-6 text-green-700">All Customer Feedbacks</h1>

    <!-- Loading Spinner -->
    <div id="loading" class="text-center text-green-600 font-semibold mb-4">
        Loading feedbacks...
    </div>

    <!-- Feedback Grid -->
    <div id="feedbackGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 hidden">
        <!-- Feedback cards will be inserted here -->
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const feedbackGrid = document.getElementById("feedbackGrid");

    // Load feedbacks on page load
    window.onload = function () {
        fetch("/api/feedbacks")
            .then(function (response) {
                return response.json();
            })
            .then(function (feedbacks) {
                renderFeedbacks(feedbacks);
            })
            .catch(function (error) {
                console.error("Error fetching feedbacks:", error);
                loadingDiv.textContent = "Failed to load feedbacks.";
            });
    };

    // Render feedbacks into cards
    function renderFeedbacks(feedbacks) {
        feedbackGrid.innerHTML = "";
        loadingDiv.classList.add("hidden");
        feedbackGrid.classList.remove("hidden");

        if (feedbacks.length === 0) {
            var noData = document.createElement("div");
            noData.className = "col-span-full text-center text-gray-500 text-lg";
            noData.textContent = "No feedbacks found.";
            feedbackGrid.appendChild(noData);
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