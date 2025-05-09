<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<jsp:include page="common/navbar.jsp"/>

<div class="max-w-6xl mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6 text-green-700">All Products</h1>

    <!-- Loading Spinner -->
    <div id="loading" class="text-center text-green-600 font-semibold">
        Loading products...
    </div>

    <!-- Product Grid -->
    <div id="productGrid" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 hidden">
        <!-- Products will be injected here -->
    </div>

    <jsp:include page="feedbacks.jsp"/>
</div>

<script>
    const productGrid = document.getElementById("productGrid");
    const loadingDiv = document.getElementById("loading");

    // Fetch products from API
    fetch("/api/products")
        .then(function (response) {
            return response.json();
        })
        .then(function (products) {
            loadingDiv.classList.add("hidden");
            productGrid.classList.remove("hidden");
            renderProducts(products);
        })
        .catch(function (error) {
            console.error("Error fetching products:", error);
            loadingDiv.textContent = "Failed to load products.";
        });

    function renderProducts(products) {
        productGrid.innerHTML = ""; // Clear previous content

        products.forEach(function (product) {
            var productCard = document.createElement("div");
            productCard.className = "bg-white rounded-lg shadow-md overflow-hidden transition transform hover:scale-105 duration-300";

            productCard.innerHTML =
                "<img src=\"" + product.imageUrl + "\" alt=\"" + product.name + "\" class=\"w-full h-48 object-cover\">" +
                "<div class=\"p-4\">" +
                "<h2 class=\"text-xl font-semibold text-gray-800 mb-2\">" + product.name + "</h2>" +
                "<p class=\"text-sm text-gray-600 mb-2\">" + product.description + "</p>" +
                "<p class=\"font-bold text-green-600 mb-4\">$" + product.price.toFixed(2) + "</p>";

            // Add to Cart Button
            productCard.innerHTML +=
                "<button onclick=\"addToCart('" + product.id + "', '" + product.name + "', " + product.price + ")\" " +
                "class=\"mt-2 w-full bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition duration-200\">" +
                "Add to Cart" +
                "</button>";

            productCard.innerHTML += "</div>";

            productGrid.appendChild(productCard);
        });
    }

    function addToCart(productId, productName, productPrice) {
        const userId = localStorage.getItem("userId");

        if (!userId ) {
            alert("You need to login first.");
            window.location.href = "/login";
            return;
        }

        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        const existingItem = cart.find(item => item.id === productId);

        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.push({
                id: productId,
                name: productName,
                price: productPrice,
                category: "OrderedItem",
                quantity: 1
            });
        }

        localStorage.setItem("cart", JSON.stringify(cart));
        alert(productName + " added to cart!");
    }
</script>

</body>
</html>