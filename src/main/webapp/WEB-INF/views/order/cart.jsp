<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-5xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/" class="font-bold text-black-700 flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-700" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Back to Shopping</span>
        </a>
    </div>
        <div class="bg-white rounded-2xl shadow-md p-8 mb-8">
            <h1 class="text-3xl mb-6 text-green-700 font-['Koulen']">Your Cart</h1>

            <!-- Empty Cart Message -->
            <div id="emptyCart" class="hidden text-center text-gray-600 text-lg">
                Your cart is empty.
            </div>

            <!-- Cart Table -->
            <div id="cartTableContainer" class="overflow-x-auto hidden">
                <table class="min-w-full bg-white shadow-md rounded-lg">
                    <thead class="bg-green-100 text-green-800">
                    <tr>
                        <th class="py-3 px-4 text-left">Product Name</th>
                        <th class="py-3 px-4 text-right">Unit Price</th>
                        <th class="py-3 px-4 text-center">Quantity</th>
                        <th class="py-3 px-4 text-right">Total</th>
                        <th class="py-3 px-4 text-right">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="cartBody">
                    <!-- Cart items will be inserted here -->
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="3" class="text-right py-3 px-4 font-semibold text-gray-700">Grand Total:</td>
                        <td id="grandTotal" class="text-right py-3 px-4 font-bold text-green-700">0.00</td>
                        <td class="py-3 px-4"></td>
                    </tr>
                    </tfoot>
                </table>
        </div>    
    </div>

    <!-- Create Order Button -->
    <div class="mt-8 text-right">
        <button onclick="createOrder()"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-6 rounded-md transition duration-200 font-['Koulen']">
            Proceed to Checkout
        </button>
    </div>
</div>

<script>
    window.onload = function () {
        loadCart();
    };

    function loadCart() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        const cartBody = document.getElementById("cartBody");
        const cartTableContainer = document.getElementById("cartTableContainer");
        const emptyCart = document.getElementById("emptyCart");
        const grandTotalEl = document.getElementById("grandTotal");

        cartBody.innerHTML = "";
        if (!cart || cart.length === 0) {
            cartTableContainer.classList.add("hidden");
            emptyCart.classList.remove("hidden");
            grandTotalEl.textContent = "0.00";
            return;
        }

        emptyCart.classList.add("hidden");
        cartTableContainer.classList.remove("hidden");

        let grandTotal = 0;

        cart.forEach(function (item) {
            const itemTotal = item.price * item.quantity;

            grandTotal += itemTotal;

            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(item.name) + "</td>" +
                "<td class='py-3 px-4 border-b text-right'>LKR " + parseFloat(item.price).toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b text-center'>" +
                "<div class='flex justify-center space-x-2'>" +
                "<button onclick='updateQuantity(\"" + escapeHtml(item.id) + "\", -1)' class='px-3 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600'>-</button>" +
                "<span class='font-medium'>" + item.quantity + "</span>" +
                "<button onclick='updateQuantity(\"" + escapeHtml(item.id) + "\", 1)' class='px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700'>+</button>" +
                "</div>" +
                "</td>" +
                "<td class='py-3 px-4 border-b text-right'>LKR " + itemTotal.toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b text-right'>" +
                "<button onclick='removeItem(\"" + escapeHtml(item.id) + "\")' class='text-red-600 hover:text-red-900'>Remove</button>" +
                "</td>";

            cartBody.appendChild(row);
        });

        grandTotalEl.textContent = 'LKR ' + grandTotal.toFixed(2);
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

    // Update quantity of an item
    function updateQuantity(productId, change) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        // First check current stock
        fetch("/api/products/" + productId)
            .then(response => response.json())
            .then(product => {
                const cartItem = cart.find(item => item.id === productId);
                const newQuantity = cartItem ? parseInt(cartItem.quantity) + change : 1;

                if (newQuantity > product.inStockQuantity) {
                    alert("Sorry, we only have " + product.inStockQuantity + " items in stock.");
                    return;
                }

                for (let i = 0; i < cart.length; i++) {
                    if (cart[i].id === productId) {
                        cart[i].quantity = newQuantity;

                        if (cart[i].quantity <= 0) {
                            cart.splice(i, 1); // Remove if quantity is zero
                        }

                        break;
                    }
                }

                localStorage.setItem("cart", JSON.stringify(cart));
                loadCart();
            })
            .catch(error => {
                console.error("Error checking stock:", error);
                alert("Error checking stock availability. Please try again.");
            });
    }

    // Remove item from cart
    function removeItem(productId) {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        cart = cart.filter(item => item.id !== productId);

        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
    }

    // Navigate to create order page
    function createOrder() {
        let cart = JSON.parse(localStorage.getItem("cart")) || [];
        
        if (!cart || cart.length === 0) {
            alert("Your cart is empty. Please add items before creating an order.");
            return;
        }

        if (confirm("Are you sure you want to place this order?")) {
            window.location.href = "/create-order";
        }
    }
</script>

</body>
</html>