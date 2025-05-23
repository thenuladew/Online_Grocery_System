<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Koulen', Arial, sans-serif;
            margin: 0;
            padding: 0;
            position: relative;
            min-height: 100vh;
            overflow: hidden;
        }

        .logo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 24px;
        }

        .logo {
            width: 220px;
            height: 112px;
            object-fit: contain;
        }

        .photo-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 0;
            pointer-events: none;
        }
        .photo-bg img {
            width: 100vw;
            height: 100vh;
            object-fit: cover;
            filter: blur(6px) brightness(0.8);
        }
        .photo-bg::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(16, 24, 32, 0.4);
            z-index: 1;
        }
        .main-content {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">
    <div class="photo-bg">
        <img src="https://i.pinimg.com/736x/cb/3f/29/cb3f295cdda243a045d145b1eb0004dc.jpg" alt="Grocery background" />
    </div>
    <div class="main-content w-full max-w-md bg-white rounded-lg shadow-xl p-8 text-center">

    <div class="logo-container">
           <img src="./images/UrbanCart.png" alt="UrbanCart Logo" class="logo">
    </div>

    <!-- Welcome Title -->
    <h1 class="text-2xl mb-1 text-green-700">Welcome Back!</h1>
    <p class="text-gray-600 mb-6">Please login to continue.</p>

    <!-- Email Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Email</label>
        <input type="email" id="email"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
               placeholder="jane@example.com">
        <p id="emailError" class="text-red-500 text-xs mt-1 hidden">Enter a valid email address.</p>
    </div>

    <!-- Password Input -->
    <div class="mb-4 text-left relative">
        <label class="block text-sm font-medium text-gray-700">Password</label>
        <input type="password" id="password"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel'] pr-12"
               placeholder="••••••••">
        <button type="button" id="togglePassword" tabindex="-1"
                class="absolute right-3 top-9 text-gray-400 hover:text-green-700 focus:outline-none"
                aria-label="Toggle password visibility">
            <svg id="eyeIcon" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
            </svg>
        </button>
        <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Password is required.</p>
    </div>

    <!-- Submit Button -->
    <button onclick="handleLogin()"
            class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200">
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
        <a href="/register" class="text-green-600 hover:text-green-800 font-medium">Create an Account</a>
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

    // Password toggle logic
    const passwordInput = document.getElementById('password');
    const togglePassword = document.getElementById('togglePassword');
    const eyeIcon = document.getElementById('eyeIcon');
    let passwordVisible = false;
    togglePassword.addEventListener('click', function() {
        passwordVisible = !passwordVisible;
        passwordInput.type = passwordVisible ? 'text' : 'password';
        eyeIcon.innerHTML = passwordVisible
            ? `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.477 0-8.268-2.943-9.542-7a9.956 9.956 0 012.042-3.292m3.087-2.727A9.956 9.956 0 0112 5c4.477 0 8.268 2.943 9.542 7a9.956 9.956 0 01-4.421 5.568M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3l18 18" />`
            : `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />\n<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />`;
    });
</script>

</body>
</html>