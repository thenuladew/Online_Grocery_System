<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Animated Background */
        body {
            margin: 0;
            padding: 0;
            position: relative;
            min-height: 100vh;
            overflow: hidden;
            font-family: 'Koulen', Arial, sans-serif;
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

    <!-- Welcome Title -->
    <h1 class="text-2xl mb-2 text-green-700">Create Account</h1>
    <p class="text-gray-600 mb-6">Sign up to start shopping.</p>

    <!-- Name Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Name</label>
        <input type="text" id="name"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"
               placeholder="John Doe">
        <p id="nameError" class="text-red-500 text-xs mt-1 hidden">Enter a valid full name.</p>
    </div>

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
        <p id="passwordError" class="text-red-500 text-xs mt-1 hidden">Password must be at least 6 characters.</p>
    </div>

    <!-- Contact Number Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Contact Number</label>
        <input type="text" id="contactNumber"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"
               placeholder="+1234567890">
        <p id="contactError" class="text-red-500 text-xs mt-1 hidden">Enter a valid contact number.</p>
    </div>

    <!-- Address Input -->
    <div class="mb-4 text-left">
        <label class="block text-sm font-medium text-gray-700">Address</label>
        <input type="text" id="address"
               class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"
               placeholder="123 Main St, City">
        <p id="addressError" class="text-red-500 text-xs mt-1 hidden">Enter a valid address.</p>
    </div>

    <!-- Submit Button -->
    <button onclick="handleRegister()"
            class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200">
        Register
    </button>

    <!-- Loading Spinner -->
    <div id="loading" class="hidden flex justify-center items-center mt-4">
        <div class="animate-spin rounded-full h-6 w-6 border-t-2 border-b-2 border-green-600"></div>
        <span class="ml-2 text-white">Registering...</span>
    </div>

    <!-- Error Message -->
    <p id="registerError" class="mt-4 text-center text-red-500 text-sm hidden">
        Registration failed. Please try again.
    </p>

    <!-- Back to Login Link -->
    <p class="mt-6 text-sm text-gray-600">
        Already have an account?
        <a href="/login" class="text-green-600 hover:text-green-800 font-medium">Login here</a>
    </p>
</div>

<script>
    function handleRegister() {
        const name = document.getElementById("name").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();
        const contactNumber = document.getElementById("contactNumber").value.trim();
        const address = document.getElementById("address").value.trim();

        // Reset errors
        document.getElementById("nameError").classList.add("hidden");
        document.getElementById("emailError").classList.add("hidden");
        document.getElementById("passwordError").classList.add("hidden");
        document.getElementById("contactError").classList.add("hidden");
        document.getElementById("registerError").classList.add("hidden");
        document.getElementById("loading").classList.remove("hidden");

        let isValid = true;

        // Regex patterns
        const nameRegex = /^[A-Za-z\s]{3,}$/; // Only letters and spaces
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Standard email format
        const passwordRegex = /^.{6,}$/; // At least 6 characters
        const contactRegex = /^\+?[0-9]{10,15}$/; // Optional + with 10–15 digits

        if (!nameRegex.test(name)) {
            document.getElementById("nameError").classList.remove("hidden");
            isValid = false;
        }

        if (!emailRegex.test(email)) {
            document.getElementById("emailError").classList.remove("hidden");
            isValid = false;
        }

        if (!passwordRegex.test(password)) {
            document.getElementById("passwordError").classList.remove("hidden");
            isValid = false;
        }

        if (contactNumber && !contactRegex.test(contactNumber)) {
            document.getElementById("contactError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) {
            document.getElementById("loading").classList.add("hidden");
            return;
        }

        const registerData = {
            name: name,
            email: email,
            password: password,
            contactNumber: contactNumber,
            address: address || "" // Make address optional
        };

        fetch("/api/customers", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(registerData)
        })
            .then(function(response) {
                document.getElementById("loading").classList.add("hidden");
                if (response.ok) {
                    alert("Registration successful!");
                    window.location.href = "/login";
                } else {
                    document.getElementById("registerError").classList.remove("hidden");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
                document.getElementById("registerError").classList.remove("hidden");
                document.getElementById("loading").classList.add("hidden");
            });
    }
</script>

</body>
</html>