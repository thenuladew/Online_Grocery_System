<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-5xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/"
           class="inline-block bg-gray-600 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200">
            &larr; Continue Shopping
        </a>
    </div>

    <h1 class="text-3xl font-bold mb-6 text-green-700">Your Cart</h1>

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

    <!-- Create Order Button -->
    <div class="mt-8 text-right">
        <button onclick="createOrder()"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-6 rounded-md transition duration-200">
            Create Order
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
                "<td class='py-3 px-4 border-b text-right'>$" + parseFloat(item.price).toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b text-center'>" +
                "<div class='flex justify-center space-x-2'>" +
                "<button onclick='updateQuantity(\"" + escapeHtml(item.id) + "\", -1)' class='px-3 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600'>-</button>" +
                "<span class='font-medium'>" + item.quantity + "</span>" +
                "<button onclick='updateQuantity(\"" + escapeHtml(item.id) + "\", 1)' class='px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700'>+</button>" +
                "</div>" +
                "</td>" +
                "<td class='py-3 px-4 border-b text-right'>$" + itemTotal.toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b text-right'>" +
                "<button onclick='removeItem(\"" + escapeHtml(item.id) + "\")' class='text-red-600 hover:text-red-900'>Remove</button>" +
                "</td>";

            cartBody.appendChild(row);
        });

        grandTotalEl.textContent = grandTotal.toFixed(2);
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

        for (let i = 0; i < cart.length; i++) {
            if (cart[i].id === productId) {
                cart[i].quantity += change;

                if (cart[i].quantity <= 0) {
                    cart.splice(i, 1); // Remove if quantity is zero
                }

                break;
            }
        }

        localStorage.setItem("cart", JSON.stringify(cart));
        loadCart();
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
        if (confirm("Are you sure you want to place this order?")) {
            window.location.href = "/create-order";
        }
    }
</script>

</body>
</html>