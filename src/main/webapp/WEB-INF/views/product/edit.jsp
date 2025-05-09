<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-2xl bg-white rounded-lg shadow-md p-6">
    <h1 class="text-2xl font-bold mb-6 text-green-700">Edit Product</h1>

    <form id="productForm" class="space-y-4">
        <input type="hidden" id="id">

        <div>
            <label class="block text-sm font-medium text-gray-700">Name</label>
            <input type="text" id="name" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden">Enter a valid name.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Description</label>
            <textarea id="description" rows="3"
                      class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500"></textarea>
            <p id="descError" class="text-red-500 text-xs mt-1 hidden">Enter a valid description.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Image URL</label>
            <input type="text" id="imageUrl"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
            <p id="imageError" class="text-red-500 text-xs mt-1 hidden">Enter a valid image URL.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Stock Quantity</label>
            <input type="number" id="inStockQuantity" min="0"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
            <p id="quantityError" class="text-red-500 text-xs mt-1 hidden">Enter a valid quantity.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Price</label>
            <input type="number" id="price" step="0.01" min="0"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
            <p id="priceError" class="text-red-500 text-xs mt-1 hidden">Enter a valid price.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Category</label>
            <input type="text" id="category"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
            <p id="categoryError" class="text-red-500 text-xs mt-1 hidden">Enter a valid category.</p>
        </div>

        <button type="submit"
                class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-4 rounded-md transition duration-200">
            Save Changes
        </button>
    </form>
</div>

<script>

    const pathSegments = window.location.pathname.split('/');
    const productId = pathSegments[pathSegments.length - 1];



    if (!productId) {
        alert("Product ID not provided.");
        window.location.href = "/admin";
    }

    // Load existing product data
    fetch("/api/products/" + productId)
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            document.getElementById("id").value = data.id;
            document.getElementById("name").value = data.name;
            document.getElementById("description").value = data.description;
            document.getElementById("imageUrl").value = data.imageUrl;
            document.getElementById("inStockQuantity").value = data.inStockQuantity;
            document.getElementById("price").value = data.price;
            document.getElementById("category").value = data.category;
        })
        .catch(function (error) {
            console.error("Error fetching product:", error);
            alert("Could not load product data.");
        });

    document.getElementById("productForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const name = document.getElementById("name").value.trim();
        const description = document.getElementById("description").value.trim();
        const imageUrl = document.getElementById("imageUrl").value.trim();
        const inStockQuantity = parseInt(document.getElementById("inStockQuantity").value);
        const price = parseFloat(document.getElementById("price").value);
        const category = document.getElementById("category").value.trim();

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

        if (category.length > 0 && !/^[a-zA-Z\s]+$/.test(category)) {
            document.getElementById("categoryError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) {
            return
        };

        const productData = {
            id: productId,
            name: name,
            description: description,
            imageUrl: imageUrl,
            inStockQuantity: inStockQuantity,
            price: price,
            category: category
        };

        fetch("/api/products/" + productId, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(productData)
        })
            .then(function(response) {
                if (response.ok) {
                    alert("Product updated successfully!");
                    window.location.href = "/products";
                } else {
                    alert("Failed to update product.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
                alert("An error occurred while saving.");
            });
    });
</script>

</body>
</html>