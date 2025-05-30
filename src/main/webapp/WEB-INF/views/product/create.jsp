<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-2xl bg-white rounded-lg shadow-md p-6">
    <!-- Back Button -->
    <div class="mb-4 text-right">
        <a href="/products"
           class="inline-block bg-gray-600 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200 font-['Koulen']">
            &larr; Back
        </a>
    </div>

    <h1 class="text-2xl text-green-700 mb-6 font-['Koulen']">Create New Product</h1>

    <form id="productForm" class="space-y-4">
        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Name</label>
            <input type="text" id="name" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
                   placeholder="Organic Apples">
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid name.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Description</label>
            <textarea id="description" rows="3"
                      class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
                      placeholder="Describe the product..."></textarea>
            <p id="descError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Description must be at least 10 characters.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Image URL</label>
            <input type="text" id="imageUrl"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
                   placeholder="https://example.com/images/apples.jpg">
            <p id="imageError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid image URL.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Stock Quantity</label>
            <input type="number" id="inStockQuantity" min="0"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
                   placeholder="50">
            <p id="quantityError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid quantity.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Price (LKR)</label>
            <input type="number" id="price" step="0.01" min="0"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']"
                   placeholder="2.99">
            <p id="priceError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid price.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Category</label>
            <select id="category" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
                <option value="">Select a category</option>
                <option value="Meat & Fish">Meat & Fish</option>
                <option value="Grains & Bread">Grains & Bread</option>
                <option value="Fruits">Fruits</option>
                <option value="Vegetables">Vegetables</option>
                <option value="Dairy & Eggs">Dairy & Eggs</option>
                <option value="Condiments">Condiments</option>
            </select>
            <p id="categoryError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please select a category.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Supplier</label>
            <select id="supplierId" required class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
                <option value="">Select a supplier</option>
                <!-- Suppliers will be loaded here dynamically -->
            </select>
            <p id="supplierError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please select a supplier.</p>
        </div>

        <button type="submit"
                class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200 font-['Koulen']">
            Create Product
        </button>
    </form>
</div>

<script>
    // Load suppliers when the page loads
    window.onload = function() {
        fetch("/api/suppliers")
            .then(response => response.json())
            .then(suppliers => {
                const supplierSelect = document.getElementById("supplierId");
                suppliers.forEach(supplier => {
                    const option = document.createElement("option");
                    option.value = supplier.id;
                    option.textContent = supplier.companyName + " (" + supplier.name + ")";
                    supplierSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error("Error loading suppliers:", error);
                alert("Failed to load suppliers. Please try again.");
            });
    };

    document.getElementById("productForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const name = document.getElementById("name").value.trim();
        const description = document.getElementById("description").value.trim();
        const imageUrl = document.getElementById("imageUrl").value.trim();
        const inStockQuantity = parseInt(document.getElementById("inStockQuantity").value);
        const price = parseFloat(document.getElementById("price").value);
        const category = document.getElementById("category").value;
        const supplierId = document.getElementById("supplierId").value;

        let isValid = true;

        // Reset errors
        document.querySelectorAll(".hidden").forEach(function (el) {
            el.classList.add("hidden");
        });

        const nameRegex = /^[a-zA-Z0-9\s\-_]{3,}$/;
        if (!nameRegex.test(name)) {
            document.getElementById("nameError").classList.remove("hidden");
            isValid = false;
        }

        if (description.length > 0 && description.length < 10) {
            document.getElementById("descError").classList.remove("hidden");
            isValid = false;
        }

        if (imageUrl.length > 0 && !/^https?:\/\//.test(imageUrl)) {
            document.getElementById("imageError").classList.remove("hidden");
            isValid = false;
        }

        if (isNaN(inStockQuantity) || inStockQuantity < 0) {
            document.getElementById("quantityError").classList.remove("hidden");
            isValid = false;
        }

        if (isNaN(price) || price < 0) {
            document.getElementById("priceError").classList.remove("hidden");
            isValid = false;
        }

        if (!category) {
            document.getElementById("categoryError").classList.remove("hidden");
            isValid = false;
        }

        if (!supplierId) {
            document.getElementById("supplierError").classList.remove("hidden");
            isValid = false;
        }

        // Stop if validation failed
        if (!isValid) return;

        const productData = {
            name: name,
            description: description,
            imageUrl: imageUrl,
            inStockQuantity: inStockQuantity,
            price: price,
            category: category,
            supplierId: supplierId
        };

        fetch("/api/products", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(productData)
        })
            .then(function(response) {
                if (response.ok) {
                    alert("Product created successfully!");
                    window.location.href = "/products";
                } else {
                    alert("Failed to create product.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
                alert("An error occurred while creating product.");
            });
    });
</script>

</body>
</html>