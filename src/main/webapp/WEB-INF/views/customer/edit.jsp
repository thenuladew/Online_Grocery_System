<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-50 min-h-screen text-gray-800">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-4xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/profile" class="font-bold text-black-700 flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Back to Profile</span>
        </a>
    </div>

    <!-- Loading Message -->
    <div id="loading" class="text-center py-12">
        <div class="flex justify-center mb-4">
            <i class="fas fa-circle-notch fa-spin text-3xl text-green-600"></i>
        </div>
        <p class="text-green-600 font-semibold">Loading your profile data...</p>
    </div>

    <!-- Edit Profile Form -->
    <div id="editProfileForm" class="hidden bg-white shadow-lg rounded-xl p-8 border border-gray-100">
        <h1 class="text-2xl text-green-700 mb-6 font-['Koulen']">Edit Your Profile</h1>

        <form id="profileForm" class="space-y-6">
            <div class="grid md:grid-cols-2 gap-6">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">Full Name</label>
                    <input type="text" id="name" name="name" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                    <p id="nameError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please enter a valid name (minimum 3 characters).</p>
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">Email Address</label>
                    <input type="email" id="email" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                    <p id="emailError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please enter a valid email address.</p>
                </div>

                <div>
                    <label for="contactNumber" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">Contact Number</label>
                    <input type="tel" id="contactNumber" name="contactNumber"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                    <p id="contactError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please enter a valid phone number.</p>
                </div>

                <div>
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">Address</label>
                    <input type="text" id="address" name="address"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                    <p id="addressError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please enter a valid address.</p>
                </div>
            </div>

            <div class="mt-4">
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">New Password (leave blank to keep current)</label>
                <input type="password" id="password" name="password"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                <p id="passwordError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Password must be at least 8 characters long.</p>
            </div>

            <div>
                <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1 font-['Abel']">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 font-['Abel']">
                <p id="confirmPasswordError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Passwords do not match.</p>
            </div>

            <div class="flex flex-wrap gap-4 pt-4">
                <button type="submit"
                        class="flex items-center gap-2 bg-green-600 hover:bg-green-700 text-white py-2 px-5 rounded-lg shadow transition duration-200 font-['Koulen']">
                    <i class="fas fa-save"></i> Save Changes
                </button>

                <button type="button" onclick="window.location.href='/profile'"
                        class="flex items-center gap-2 bg-gray-400 hover:bg-gray-500 text-white py-2 px-5 rounded-lg shadow transition duration-200 font-['Koulen']">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </form>
    </div>

    <!-- Error Message -->
    <div id="errorDiv" class="hidden bg-red-50 border border-red-200 text-red-700 p-4 rounded-lg mt-6 text-center">
        <i class="fas fa-exclamation-circle mr-2"></i>
        Failed to load profile data. Please try again.
        <div class="mt-3">
            <a href="/profile" class="inline-block bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition duration-200">
                Return to Profile
            </a>
        </div>
    </div>
</div>

<script>
    // Get stored user ID
    var userIdFromStorage = localStorage.getItem("userId");
    var loadingDiv = document.getElementById("loading");
    var editProfileForm = document.getElementById("editProfileForm");
    var errorDiv = document.getElementById("errorDiv");

    // Get URL parameters
    var urlParams = new URLSearchParams(window.location.search);


    if (!userIdFromStorage || !userId) {
        alert("You must be logged in to edit your profile.");
        window.location.href = "/login";
    }

    // Ensure user is editing their own profile
    if (userIdFromStorage !== userId) {
        alert("You can only edit your own profile.");
        window.location.href = "/profile";
    }

    // Load user data on page load
    window.onload = function () {
        fetch("/api/customers/" + userId)
            .then(function (response) {
                if (!response.ok) {
                    throw new Error("Failed to fetch profile");
                }
                return response.json();
            })
            .then(function (data) {
                populateForm(data);
                loadingDiv.classList.add("hidden");
                editProfileForm.classList.remove("hidden");
            })
            .catch(function (err) {
                console.error("Error fetching profile:", err);
                loadingDiv.classList.add("hidden");
                errorDiv.classList.remove("hidden");
            });
    };

    function populateForm(customer) {
        document.getElementById("name").value = customer.name || "";
        document.getElementById("email").value = customer.email || "";
        document.getElementById("contactNumber").value = customer.contactNumber || "";
        document.getElementById("address").value = customer.address || "";
    }

    // Form validation and submission
    document.getElementById("profileForm").addEventListener("submit", function (e) {
        e.preventDefault();

        // Reset error messages
        document.querySelectorAll("[id$='Error']").forEach(function(el) {
            el.classList.add("hidden");
        });

        var name = document.getElementById("name").value.trim();
        var email = document.getElementById("email").value.trim();
        var contactNumber = document.getElementById("contactNumber").value.trim();
        var address = document.getElementById("address").value.trim();
        var password = document.getElementById("password").value.trim();
        var confirmPassword = document.getElementById("confirmPassword").value.trim();

        var isValid = true;

        // Validate name
        if (!name || name.length < 3) {
            document.getElementById("nameError").classList.remove("hidden");
            isValid = false;
        }

        // Validate email
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email || !emailRegex.test(email)) {
            document.getElementById("emailError").classList.remove("hidden");
            isValid = false;
        }

        // Validate contact number if provided
        if (contactNumber && !/^\d{10,15}$/.test(contactNumber.replace(/[-()\s]/g, ''))) {
            document.getElementById("contactError").classList.remove("hidden");
            isValid = false;
        }

        // Validate password if provided
        if (password && password.length < 8) {
            document.getElementById("passwordError").classList.remove("hidden");
            isValid = false;
        }

        // Check if passwords match
        if (password && password !== confirmPassword) {
            document.getElementById("confirmPasswordError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) {
            return;
        }

        // Prepare data for update
        var updateData = {
            name: name,
            email: email,
            contactNumber: contactNumber,
            address: address
        };

        // Only include password if it was provided
        if (password) {
            updateData.password = password;
        }

        // Submit the update
        fetch("/api/customers/" + userId, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(updateData)
        })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Failed to update profile");
                }
                return response.json();
            })
            .then(function() {
                alert("Profile updated successfully!");
                window.location.href = "/profile";
            })
            .catch(function(error) {
                console.error("Error updating profile:", error);
                alert("Failed to update profile. Please try again.");
            });
    });
</script>

</body>
</html>