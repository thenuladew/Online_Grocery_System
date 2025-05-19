<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Animated Background */
        body {
            background: linear-gradient(-45deg, #10b981, #34d399, #059669, #047857);
            background-size: 400% 400%;
            animation: gradientBG 10s ease infinite;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-md bg-white rounded-lg shadow-xl p-8 text-center">

    <!-- Welcome Title -->
    <h1 class="text-2xl font-bold mb-2 text-green-700">Welcome Back!</h1>
    <p class="text-gray-600 mb-6">Please login to continue.</p>

    <!-- Email Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Email</label>
        <input type="email" id="email"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"
               placeholder="jane@example.com">
        <p id="emailError" class="text-red-500 text-xs mt-1 hidden">Enter a valid email address.</p>
    </div>

    <!-- Password Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Password</label>
        <input type="password" id="password"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"
               placeholder="••••••••">
        <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Password is required.</p>
    </div>

    <!-- Submit Button -->
    <button onclick="handleLogin()"
            class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-4 rounded-md transition duration-200">
        Login
    </button>

    <!-- Loading Spinner -->
    <div id="loading" class="hidden flex justify-center items-center mt-4">
        <div class="animate-spin rounded-full h-6 w-6 border-t-2 border-b-2 border-green-600"></div>
        <span class="ml-2 text-white">Logging in...</span>
    </div>

    <!-- Error Message -->
    <p id="loginError" class="mt-4 text-center text-red-500 text-sm hidden"></p>

    <!-- Register Link -->
    <p class="mt-4 text-sm text-gray-600">
        Don't have an account?
        <a href="/register" class="text-green-600 hover:text-green-800 font-medium">Register here</a>
    </p>
</div>

<script>
    function handleLogin() {
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        // Reset errors
        document.getElementById("emailError").classList.add("hidden");
        document.getElementById("passwordError").classList.add("hidden");
        document.getElementById("loginError").classList.add("hidden");
        document.getElementById("loading").classList.remove("hidden");

        let isValid = true;

        // Simple email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById("loginError").textContent = "Invalid Email or Password.";
            document.getElementById("loginError").classList.remove("hidden");
            isValid = false;
        }

        if (password.length < 6) {
            document.getElementById("loginError").textContent = "Invalid Email or Password.";
            document.getElementById("loginError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) {
            document.getElementById("loading").classList.add("hidden");
            return;
        }

        // admin check
        if (email === "admin@urbancart.com" && password === "admin123") {
            localStorage.setItem("userId", "admin");
            localStorage.setItem("userEmail", email);
            localStorage.setItem("userRole", "admin");
            window.location.href = "/admin";
            return;
        }

        const loginData = {
            email: email,
            password: password
        };

        fetch("/api/customers/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(loginData)
        })
        .then(function(response) {
            document.getElementById("loading").classList.add("hidden");
            return response.json();
        })
        .then(function(data) {
            if (data.success) {
                localStorage.setItem("userId", data.customerId);
                localStorage.setItem("userEmail", email);
                localStorage.setItem("userRole", "customer");
                window.location.href = "/";
            } else {
                document.getElementById("loginError").textContent = "Invalid email or password.";
                document.getElementById("loginError").classList.remove("hidden");
            }
        })
        .catch(function(error) {
            console.error("Error:", error);
            document.getElementById("loginError").textContent = "Invalid email or password.";
            document.getElementById("loginError").classList.remove("hidden");
            document.getElementById("loading").classList.add("hidden");
        });
    }
</script>

</body>
</html>