<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-7xl mx-auto px-4 py-8">

    <!-- Back Button -->
    <div class="mb-6">
        <a href="/admin"
           class="inline-block bg-gray-600 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200">
            &larr; Back to Dashboard
        </a>
    </div>

    <!-- Title and Create Button -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-green-700">All Orders</h1>

    </div>

    <!-- Search Bar -->
    <div class="mb-6">
        <input type="text" id="searchInput"
               placeholder="Search by Order ID or Customer Name"
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
    </div>

    <!-- Loading Spinner -->
    <div id="loading" class="text-center text-green-600 font-semibold mb-4">
        Loading orders...
    </div>

    <!-- Orders Table -->
    <div class="overflow-x-auto">
        <table id="ordersTable" class="min-w-full bg-white shadow-md rounded-lg hidden">
            <thead class="bg-green-100 text-green-800">
            <tr>
                <th class="py-3 px-4 text-left">Order ID</th>
                <th class="py-3 px-4 text-left">Customer</th>
                <th class="py-3 px-4 text-left">Status</th>
                <th class="py-3 px-4 text-right">Actions</th>
            </tr>
            </thead>
            <tbody id="ordersBody">
            <!-- Rows will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<!-- Modal for Viewing Order Details -->
<div id="orderModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white w-11/12 max-w-2xl p-6 rounded-lg shadow-xl relative">
        <button onclick="closeModal()" class="absolute top-3 right-4 text-gray-500 hover:text-gray-800 text-xl">&times;</button>
        <h2 class="text-2xl font-bold mb-4 text-green-700">Order Details</h2>
        <table class="min-w-full mb-4">
            <thead class="bg-gray-100">
            <tr>
                <th class="py-2 px-4 text-left">Product Name</th>
                <th class="py-2 px-4 text-left">Category</th>
                <th class="py-2 px-4 text-left">Quantity</th>
                <th class="py-2 px-4 text-right">Price</th>
            </tr>
            </thead>
            <tbody id="modalBody">
            <!-- Modal product rows go here -->
            </tbody>
        </table>
        <div class="text-right">
            <button onclick="closeModal()"
                    class="bg-gray-600 hover:bg-gray-700 text-white py-2 px-4 rounded">
                Close
            </button>
        </div>
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const ordersTable = document.getElementById("ordersTable");
    const ordersBody = document.getElementById("ordersBody");
    const searchInput = document.getElementById("searchInput");

    // Load orders on page load
    window.onload = function () {
        fetch("/api/orders")
            .then(function (response) {
                return response.json();
            })
            .then(function (orders) {
                renderOrders(orders);
            })
            .catch(function (error) {
                console.error("Error fetching orders:", error);
                loadingDiv.textContent = "Failed to load orders.";
            });
    };

    // Render orders into table
    function renderOrders(orders, filterText) {
        ordersBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        ordersTable.classList.remove("hidden");

        if (!filterText) filterText = "";

        filterText = filterText.toLowerCase();

        let filtered = orders.filter(function (order) {
            return (
                order.id.toLowerCase().includes(filterText) ||
                order.customerName.toLowerCase().includes(filterText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='4' class='py-4 px-6 text-center text-gray-500'>No orders found.</td>";
            ordersBody.appendChild(row);
            return;
        }

        filtered.forEach(function (order) {
            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(order.id) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(order.customerName) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(order.status) + "</td>" +
                "<td class='py-3 px-4 border-b text-right'>" +
                "<div class='space-x-2'>" +
                "<button onclick=\"viewOrderDetails(" + JSON.stringify(order).replace(/"/g, '&quot;') + ")\" " +
                "class='text-blue-600 hover:text-blue-900'><i class='fas fa-eye'></i> View</button>" +
                "<select onchange=\"updateOrderStatus('" + escapeHtml(order.id) + "', this.value)\" " +
                "class='border border-gray-300 rounded px-2 py-1 text-sm mr-2'>" +
                "<option value='Pending'" + (order.status === 'Pending' ? ' selected' : '') + ">Pending</option>" +
                "<option value='Processing'" + (order.status === 'Processing' ? ' selected' : '') + ">Processing</option>" +
                "<option value='Shipped'" + (order.status === 'Shipped' ? ' selected' : '') + ">Shipped</option>" +
                "<option value='Delivered'" + (order.status === 'Delivered' ? ' selected' : '') + ">Delivered</option>" +
                "</select>" +
                "<button onclick=\"deleteOrder('" + escapeHtml(order.id) + "')\" " +
                "class='text-red-600 hover:text-red-900 ml-4'>Delete</button>" +
                "</div>" +
                "</td>";

            ordersBody.appendChild(row);
        });
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

    // Handle search input
    searchInput.addEventListener("input", function () {
        fetch("/api/orders")
            .then(function (response) {
                return response.json();
            })
            .then(function (orders) {
                renderOrders(orders, searchInput.value);
            });
    });

    // View order details in modal
    function viewOrderDetails(order) {
        const modalBody = document.getElementById("modalBody");
        modalBody.innerHTML = "";

        order.products.forEach(function (item) {
            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-2 px-4 border-b'>" + escapeHtml(item.name) + "</td>" +
                "<td class='py-2 px-4 border-b'>" + escapeHtml(item.category || "N/A") + "</td>" +
                "<td class='py-2 px-4 border-b'>1</td>" +
                "<td class='py-2 px-4 border-b text-right'>$" + escapeHtml(item.price ? item.price.toFixed(2) : "0.00") + "</td>";

            modalBody.appendChild(row);
        });

        document.getElementById("orderModal").classList.remove("hidden");
    }

    // Close modal
    function closeModal() {
        document.getElementById("orderModal").classList.add("hidden");
    }

    // Update order status
    function updateOrderStatus(orderId, newStatus) {
        fetch("/api/orders/" + encodeURIComponent(orderId), {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ status: newStatus })
        })
            .then(function (response) {
                if (!response.ok) {
                    alert("Failed to update order status.");
                }
            })
            .catch(function (error) {
                console.error("Error updating status:", error);
                alert("An error occurred while updating the status.");
            });
    }

    // Confirm and delete order
    function deleteOrder(id) {
        if (confirm("Are you sure you want to delete this order?")) {
            fetch("/api/orders/" + encodeURIComponent(id), {
                method: "DELETE"
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("Order deleted successfully.");
                        window.location.reload();
                    } else {
                        alert("Failed to delete order.");
                    }
                })
                .catch(function (error) {
                    console.error("Error:", error);
                    alert("An error occurred while deleting.");
                });
        }
    }
</script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</body>
</html>