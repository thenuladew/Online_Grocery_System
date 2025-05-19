<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Order</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-5xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/cart"
           class="inline-flex items-center bg-green-600 text-white py-2 px-4 rounded-lg hover:bg-green-700 transition duration-200 shadow-sm">
            <i class="fas fa-arrow-left mr-2"></i> Back to Cart
        </a>
    </div>

    <div class="bg-white shadow-lg rounded-xl overflow-hidden mb-8 border border-gray-100">
        <div class="bg-green-600 text-white px-6 py-4">
            <h1 class="text-3xl font-bold flex items-center">
                <i class="fas fa-shopping-bag mr-3"></i>Create Your Order
            </h1>
            <p class="text-green-100 mt-1">Please review your order details before confirming</p>
        </div>

        <div class="p-6">
            <!-- Loading Message -->
            <div id="loading" class="text-center text-green-600 font-semibold mb-4 hidden flex items-center justify-center">
                <i class="fas fa-spinner fa-spin mr-2"></i> Creating your order...
            </div>

            <!-- Customer Information Section -->
            <div class="mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800 border-b pb-2 flex items-center">
                    <i class="fas fa-user mr-2 text-green-600"></i> Customer Information
                </h2>
                <div class="grid md:grid-cols-2 gap-6">
                    <div class="mb-4">
                        <label for="customerName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                        <input type="text" id="customerName" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" readonly>
                    </div>
                    <div class="mb-4">
                        <label for="customerEmail" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                        <input type="email" id="customerEmail" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" readonly>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Delivery Address</label>
                    <textarea id="address" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" rows="2" readonly></textarea>
                </div>
                <div class="grid md:grid-cols-2 gap-6">

                    <div class="mb-4">
                        <label for="deliveryDate" class="block text-sm font-medium text-gray-700 mb-1">Preferred Delivery Date</label>
                        <input type="date" id="deliveryDate" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                    </div>
                </div>
                <div class="mb-4">
                    <label for="notes" class="block text-sm font-medium text-gray-700 mb-1">Order Notes (Optional)</label>
                    <textarea id="notes" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" rows="2" placeholder="Special instructions for delivery"></textarea>
                </div>
            </div>

            <!-- Payment Method Section -->
            <div class="mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800 border-b pb-2 flex items-center">
                    <i class="fas fa-credit-card mr-2 text-green-600"></i> Payment Method
                </h2>
                <div class="flex flex-wrap gap-4">
                    <div class="flex items-center">
                        <input type="radio" id="creditCard" name="paymentMethod" value="creditCard" class="mr-2" checked>
                        <label for="creditCard" class="flex items-center">
                            <i class="fas fa-credit-card mr-1 text-blue-600"></i> Credit Card
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="radio" id="paypal" name="paymentMethod" value="paypal" class="mr-2">
                        <label for="paypal" class="flex items-center">
                            <i class="fab fa-paypal mr-1 text-blue-800"></i> PayPal
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="radio" id="cash" name="paymentMethod" value="cash" class="mr-2">
                        <label for="cash" class="flex items-center">
                            <i class="fas fa-money-bill-wave mr-1 text-green-600"></i> Cash on Delivery
                        </label>
                    </div>
                </div>
            </div>

            <!-- Order Summary Table -->
            <div class="mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800 border-b pb-2 flex items-center">
                    <i class="fas fa-clipboard-list mr-2 text-green-600"></i> Order Summary
                </h2>
                <div class="bg-white shadow-md rounded-lg overflow-hidden">
                    <table class="min-w-full">
                        <thead class="bg-green-100 text-green-800">
                        <tr>
                            <th class="py-3 px-4 text-left">Product Name</th>
                            <th class="py-3 px-4 text-left">Category</th>
                            <th class="py-3 px-4 text-right">Quantity</th>
                            <th class="py-3 px-4 text-right">Price</th>
                            <th class="py-3 px-4 text-right">Total</th>
                        </tr>
                        </thead>
                        <tbody id="orderSummaryBody">
                        <!-- Items will be injected here -->
                        </tbody>
                        <tfoot class="bg-gray-50">
                        <tr>
                            <td colspan="4" class="text-right py-3 px-4 font-semibold text-gray-700">Subtotal:</td>
                            <td id="subtotal" class="py-3 px-4 font-bold text-green-700 text-right">LKR 0.00</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-right py-3 px-4 font-semibold text-gray-700">Shipping:</td>
                            <td id="shipping" class="py-3 px-4 font-bold text-green-700 text-right">LKR 0.00</td>
                        </tr>
                        <tr class="bg-green-50">
                            <td colspan="4" class="text-right py-4 px-4 font-bold text-gray-800">Grand Total:</td>
                            <td id="grandTotal" class="py-4 px-4 font-bold text-xl text-green-700 text-right">LKR 0.00</td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- Order Status -->
            <div class="mb-8">
                <h2 class="text-xl font-bold mb-4 text-gray-800 border-b pb-2 flex items-center">
                    <i class="fas fa-info-circle mr-2 text-green-600"></i> Order Status
                </h2>
                <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 rounded">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-clock text-yellow-500"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm text-yellow-700" id="statusText">Status: Pending</p>
                            <p class="text-xs text-yellow-600 mt-1">Your order will be processed once confirmed.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Terms and Conditions -->
            <div class="mb-8">
                <div class="flex items-start">
                    <input type="checkbox" id="termsCheckbox" class="mt-1 mr-2">
                    <label for="termsCheckbox" class="text-sm text-gray-600">
                        I agree to the <a href="#" class="text-green-600 hover:underline">Terms and Conditions</a> and <a href="#" class="text-green-600 hover:underline">Privacy Policy</a>
                    </label>
                </div>
            </div>

            <!-- Confirm Order Button -->
            <div class="flex justify-end">
                <button id="confirmButton" onclick="submitOrder()" disabled
                        class="bg-green-600 hover:bg-green-700 text-white py-3 px-8 rounded-lg transition duration-200 font-bold shadow-md flex items-center">
                    <i class="fas fa-check-circle mr-2"></i> Confirm Order
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    const currentUserId = localStorage.getItem("userId");
    let cart = JSON.parse(localStorage.getItem("cart")) || [];

    if (!currentUserId || cart.length === 0) {
        alert("You must be logged in and have items in your cart.");
        window.location.href = "/login";
    }

    // Update confirm button state when terms checkbox is clicked
    document.getElementById("termsCheckbox").addEventListener("change", function() {
        document.getElementById("confirmButton").disabled = !this.checked;
        if (this.checked) {
            document.getElementById("confirmButton").classList.remove("opacity-50", "cursor-not-allowed");
        } else {
            document.getElementById("confirmButton").classList.add("opacity-50", "cursor-not-allowed");
        }
    });

    // Set minimum date for delivery to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById("deliveryDate").min = tomorrow.toISOString().split("T")[0];
    document.getElementById("deliveryDate").value = tomorrow.toISOString().split("T")[0];

    // Load cart into UI
    window.onload =async function  () {
       await fetch("/api/customers/" + currentUserId)
            .then(function (response) {
                return response.json();
            })
            .then(function (customer) {
                displayCustomerInfo(customer);
                displayCart(cart);
            })
            .catch(function (error) {
                console.error("Error fetching customer:", error);
                alert("Failed to load customer details.");
                window.location.href = "/login";
            });
    };

    function displayCustomerInfo(customer) {
        document.getElementById("customerName").value = customer.name || "";
        document.getElementById("customerEmail").value = customer.email || "";
        document.getElementById("address").value = customer.address || "";

    }

    function displayCart(items) {
        const tbody = document.getElementById("orderSummaryBody");
        const subtotalEl = document.getElementById("subtotal");
        const shippingEl = document.getElementById("shipping");
        const grandTotalEl = document.getElementById("grandTotal");

        let subtotal = 0;
        let shipping = 0;

        tbody.innerHTML = ""; // Clear existing rows

        if (items.length === 0) {
            const emptyRow = document.createElement("tr");
            emptyRow.innerHTML = "<td colspan='5' class='py-4 px-4 text-center text-gray-500'>Your cart is empty</td>";
            tbody.appendChild(emptyRow);
        } else {
            items.forEach(function (item) {
                const itemTotal = (item.price * item.quantity).toFixed(2);
                subtotal += parseFloat(itemTotal);

                const row = document.createElement("tr");
                row.className = "hover:bg-green-50 transition duration-150";

                row.innerHTML =
                    "<td class='py-3 px-4 border-b'>" + escapeHtml(item.name) + "</td>" +
                    "<td class='py-3 px-4 border-b'>" + escapeHtml(item.category || "N/A") + "</td>" +
                    "<td class='py-3 px-4 border-b text-right'>" + item.quantity + "</td>" +
                    "<td class='py-3 px-4 border-b text-right'>LKR " + parseFloat(item.price).toFixed(2) + "</td>" +
                    "<td class='py-3 px-4 border-b text-right'>LKR " + itemTotal + "</td>";

                tbody.appendChild(row);
            });
        }

        // Calculate shipping based on subtotal
        if (subtotal >= 1000) {
            shipping = 200;
        } else if (subtotal >= 500) {
            shipping = 100;
        } else if (subtotal >= 100) {
            shipping = 50;
        } else {
            shipping = 10;
        }

        subtotalEl.textContent = "LKR " + subtotal.toFixed(2);
        shippingEl.textContent = "LKR" + shipping.toFixed(2);

        const grandTotal = subtotal + shipping;
        grandTotalEl.textContent = "LKR " + grandTotal.toFixed(2);
    }

    function submitOrder() {
        // Check if terms are accepted
        if (!document.getElementById("termsCheckbox").checked) {
            alert("Please accept the terms and conditions to proceed.");
            return;
        }

        const loadingDiv = document.getElementById("loading");
        loadingDiv.classList.remove("hidden");

        // Disable confirm button while processing
        const confirmButton = document.getElementById("confirmButton");
        confirmButton.disabled = true;
        confirmButton.classList.add("opacity-50");

        // First check stock availability for all items
        const stockChecks = cart.map(item => 
            fetch("/api/products/" + item.id)
                .then(response => response.json())
                .then(product => ({
                    product,
                    requestedQuantity: item.quantity
                }))
        );

        Promise.all(stockChecks)
            .then(results => {
                const outOfStockItems = results.filter(result => 
                    result.requestedQuantity > result.product.inStockQuantity
                );

                if (outOfStockItems.length > 0) {
                    const errorMessage = outOfStockItems.map(item => 
                        `${item.product.name}: Only ${item.product.inStockQuantity} available`
                    ).join('\n');
                    
                    alert("Some items are out of stock:\n" + errorMessage);
                    loadingDiv.classList.add("hidden");
                    confirmButton.disabled = false;
                    confirmButton.classList.remove("opacity-50");
                    return;
                }

                // If all items are in stock, proceed with order creation
                return fetch("/api/customers/" + encodeURIComponent(currentUserId));
            })
            .then(function (response) {
                if (!response) return; // Stop if stock check failed
                
                return response.json();
            })
            .then(function (customerData) {
                if (!customerData) return; // Stop if previous step failed

                const orderData = {
                    products: cart.map(item => ({
                        productId: item.id,
                        name: item.name,
                        category: item.category,
                        price: item.price,
                        quantity: parseInt(item.quantity) || 1
                    })),
                    customerName: customerData.name,
                    customerEmail: customerData.email,
                    address: customerData.address,
                    deliveryDate: document.getElementById("deliveryDate").value,
                    notes: document.getElementById("notes").value,
                    paymentMethod: document.querySelector('input[name="paymentMethod"]:checked').value,
                    subtotal: parseFloat(document.getElementById("subtotal").textContent.replace("LKR ", "")),
                    shipping: parseFloat(document.getElementById("shipping").textContent.replace("LKR ", "")),
                    total: parseFloat(document.getElementById("grandTotal").textContent.replace("LKR ", "")),
                    status: "Pending"
                };

                return fetch("/api/orders", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(orderData)
                });
            })
            .then(function (response) {
                if (!response) return; // Stop if previous step failed
                
                loadingDiv.classList.add("hidden");

                if (response.ok) {
                    // Show success message with animation
                    const successMessage = document.createElement("div");
                    successMessage.className = "fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50";
                    successMessage.innerHTML = `
                        <div class="bg-white p-8 rounded-lg shadow-xl max-w-md w-full animate-fadeIn">
                            <div class="text-center">
                                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-green-100 mb-4">
                                    <i class="fas fa-check-circle text-3xl text-green-600"></i>
                                </div>
                                <h2 class="text-2xl font-bold text-gray-800 mb-2">Order Placed Successfully!</h2>
                                <p class="text-gray-600 mb-6">Thank you for your purchase. Your order has been received and is being processed.</p>
                                <button id="viewOrdersBtn" class="bg-green-600 text-white py-2 px-6 rounded-lg hover:bg-green-700 transition duration-200">
                                    View My Orders
                                </button>
                            </div>
                        </div>
                    `;
                    document.body.appendChild(successMessage);

                    // Clear cart
                    localStorage.removeItem("cart");

                    // Add event listener to button
                    document.getElementById("viewOrdersBtn").addEventListener("click", function() {
                        window.location.href = "/my-orders";
                    });

                    // Automatically redirect after 5 seconds
                    setTimeout(function() {
                        window.location.href = "/orders";
                    }, 5000);
                } else {
                    // Re-enable button if there's an error
                    confirmButton.disabled = false;
                    confirmButton.classList.remove("opacity-50");
                    alert("Failed to create order. Please try again.");
                }
            })
            .catch(function (error) {
                loadingDiv.classList.add("hidden");
                confirmButton.disabled = false;
                confirmButton.classList.remove("opacity-50");
                console.error("Error:", error);
                alert("An error occurred while creating the order.");
            });
    }

    // Escape HTML to prevent XSS
    function escapeHtml(text) {
        if (!text) return "";
        return text.toString().replace(/[&<>"']/g, function(m) {
            return ({
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;'
            })[m];
        });
    }
</script>

<style>
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    .animate-fadeIn {
        animation: fadeIn 0.3s ease-out;
    }
    /* Disable button styling */
    button:disabled {
        cursor: not-allowed;
    }
</style>

</body>
</html>