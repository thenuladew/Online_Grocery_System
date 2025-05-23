<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-50 min-h-screen text-gray-800">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-4xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/" class="font-bold text-black-700 flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Back to Shopping</span>
        </a>
    </div>

    <!-- Loading Message -->
    <div id="loading" class="text-center py-12">
        <div class="flex justify-center mb-4">
            <i class="fas fa-circle-notch fa-spin text-3xl text-green-600"></i>
        </div>
        <p class="text-green-600 font-semibold">Loading profile...</p>
    </div>

    <!-- Profile Card -->
    <div id="profileCard" class="hidden bg-white shadow-lg rounded-xl p-8 border border-gray-100">
        <div class="flex items-center justify-between mb-6">
            <h1 class="text-2xl text-green-700 font-['Koulen']">Your Profile</h1>
            <div class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-medium">
                Active
            </div>
        </div>

        <div class="grid md:grid-cols-2 gap-6">
            <div class="space-y-4">
                <div class="bg-gray-50 p-4 rounded-lg">
                    <p class="text-sm text-gray-500 mb-1">Full Name</p>
                    <p id="name" class="font-medium"></p>
                </div>

                <div class="bg-gray-50 p-4 rounded-lg">
                    <p class="text-sm text-gray-500 mb-1">Email Address</p>
                    <p id="email" class="font-medium"></p>
                </div>
            </div>

            <div class="space-y-4">
                <div class="bg-gray-50 p-4 rounded-lg">
                    <p class="text-sm text-gray-500 mb-1">Contact Number</p>
                    <p id="contactNumber" class="font-medium"></p>
                </div>

                <div class="bg-gray-50 p-4 rounded-lg">
                    <p class="text-sm text-gray-500 mb-1">Address</p>
                    <p id="address" class="font-medium"></p>
                </div>
            </div>
        </div>

        <div class="mt-8 flex flex-wrap gap-4">
            <button onclick="editProfile()"
                    class="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white py-2 px-5 rounded-lg transition duration-200 shadow font-['Koulen']">
                <i class="fas fa-pen"></i> Edit Profile
            </button>

            <button onclick="logoutUser()"
                    class="flex items-center gap-2 bg-gray-600 hover:bg-gray-700 text-white py-2 px-5 rounded-lg transition duration-200 shadow font-['Koulen']">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>

            <button onclick="deleteAccount()"
                    class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white py-2 px-5 rounded-lg transition duration-200 shadow font-['Koulen']">
                <i class="fas fa-trash"></i> Delete Account
            </button>
        </div>
    </div>

    <!-- Error Message -->
    <div id="errorDiv" class="hidden bg-red-50 border border-red-200 text-red-700 p-4 rounded-lg mt-6 text-center">
        <i class="fas fa-exclamation-circle mr-2"></i>
        Failed to load profile. Please login again.
        <div class="mt-3">
            <a href="/login" class="inline-block bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition duration-200">
                Go to Login
            </a>
        </div>
    </div>
</div>

<script>
    // Get stored user ID
    var userIdFromStorage = localStorage.getItem("userId");
    var loadingDiv = document.getElementById("loading");
    var profileCard = document.getElementById("profileCard");
    var errorDiv = document.getElementById("errorDiv");

    if (!userIdFromStorage) {
        alert("You must be logged in to view your profile.");
        window.location.href = "/login";
    }

    // Load user data on page load
    window.onload = function () {
        fetch("/api/customers/" + userIdFromStorage)
            .then(function (response) {
                if (!response.ok) {
                    throw new Error("Failed to fetch profile");
                }
                return response.json();
            })
            .then(function (data) {
                displayProfile(data);
            })
            .catch(function (err) {
                console.error("Error fetching profile:", err);
                loadingDiv.classList.add("hidden");
                errorDiv.classList.remove("hidden");
            });
    };

    function displayProfile(customer) {
        loadingDiv.classList.add("hidden");
        profileCard.classList.remove("hidden");

        document.getElementById("name").textContent = customer.name || "Not provided";
        document.getElementById("email").textContent = customer.email || "Not provided";
        document.getElementById("contactNumber").textContent = customer.contactNumber || "Not provided";
        document.getElementById("address").textContent = customer.address || "Not provided";
    }

    function editProfile() {
        window.location.href = "/edit-profile?userId=" + encodeURIComponent(userIdFromStorage);
    }

    function deleteAccount() {
        if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
            fetch("/api/customers/" + encodeURIComponent(userIdFromStorage), {
                method: "DELETE"
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("Your account has been deleted.");
                        localStorage.removeItem("userId");
                        window.location.href = "/login";
                    } else {
                        alert("Failed to delete account.");
                    }
                })
                .catch(function (error) {
                    console.error("Error:", error);
                    alert("An error occurred while deleting your account.");
                });
        }
    }

    function logoutUser() {
        if (confirm("Are you sure you want to log out?")) {
            localStorage.removeItem("userId");
            alert("Logged out successfully.");
            window.location.href = "/login";
        }
    }
</script>

</body>
</html>