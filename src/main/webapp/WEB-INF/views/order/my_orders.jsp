<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 min-h-screen">

<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-6xl mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-green-700 flex items-center">
            <i class="fas fa-box-open mr-3"></i>My Orders
        </h1>
        <a href="/" class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-lg transition duration-200 flex items-center">
            <i class="fas fa-shopping-basket mr-2"></i> Continue Shopping
        </a>
    </div>

    <!-- Dashboard Summary -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-green-500">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-green-100 mr-4">
                    <i class="fas fa-shopping-bag text-green-600 text-xl"></i>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Total Orders</p>
                    <p class="text-xl font-bold text-gray-800" id="totalOrders">0</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-blue-100 mr-4">
                    <i class="fas fa-clock text-blue-600 text-xl"></i>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Pending Orders</p>
                    <p class="text-xl font-bold text-gray-800" id="pendingOrders">0</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-purple-500">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-purple-100 mr-4">
                    <i class="fas fa-truck text-purple-600 text-xl"></i>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Shipped Orders</p>
                    <p class="text-xl font-bold text-gray-800" id="shippedOrders">0</p>
                </div>
            </div>
        </div>
        <div class="bg-white rounded-lg shadow-md p-4 border-l-4 border-green-500">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-green-100 mr-4">
                    <i class="fas fa-check-circle text-green-600 text-xl"></i>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Completed Orders</p>
                    <p class="text-xl font-bold text-gray-800" id="completedOrders">0</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter and Search -->
    <div class="bg-white p-4 mb-6 rounded-lg shadow-md">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div class="relative flex-grow md:max-w-md">
                <input type="text" id="searchInput" placeholder="Search orders..."
                       class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                <div class="absolute left-3 top-2.5 text-gray-400">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="flex flex-wrap gap-2">
                <select id="statusFilter" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                    <option value="all">All Statuses</option>
                    <option value="Pending">Pending</option>
                    <option value="Shipped">Shipped</option>
                    <option value="Delivered">Delivered</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
                <select id="sortOrder" class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                    <option value="newest">Newest First</option>
                    <option value="oldest">Oldest First</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Loading Indicator -->
    <div id="loading" class="text-center text-green-600 my-12 hidden">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
        <p class="mt-2">Loading your orders...</p>
    </div>

    <!-- No Orders Message -->
    <div id="noOrders" class="hidden bg-white rounded-lg shadow-md p-8 text-center">
        <div class="inline-block p-4 rounded-full bg-gray-100 mb-4">
            <i class="fas fa-shopping-cart text-4xl text-gray-400"></i>
        </div>
        <h2 class="text-2xl font-bold text-gray-700 mb-2">No Orders Found</h2>
        <p class="text-gray-500 mb-6">You haven't placed any orders yet.</p>
        <a href="/" class="inline-block bg-green-600 hover:bg-green-700 text-white py-2 px-6 rounded-lg transition duration-200">
            Start Shopping
        </a>
    </div>

    <!-- Orders List -->
    <div id="ordersList" class="space-y-6"></div>

    <!-- Pagination -->
    <div class="mt-8 flex justify-center">
        <nav class="inline-flex rounded-md shadow">
            <button id="prevPage" class="px-3 py-1 rounded-l-md border border-gray-300 bg-white text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                <i class="fas fa-chevron-left"></i>
            </button>
            <div id="paginationNumbers" class="flex border-t border-b border-gray-300"></div>
            <button id="nextPage" class="px-3 py-1 rounded-r-md border border-gray-300 bg-white text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                <i class="fas fa-chevron-right"></i>
            </button>
        </nav>
    </div>
</div>

<!-- Order Detail Modal -->
<div id="orderModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center hidden">
    <div class="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div class="p-6 border-b border-gray-200">
            <div class="flex justify-between items-center">
                <h2 class="text-2xl font-bold text-green-700">Order Details</h2>
                <button id="closeModal" class="text-gray-500 hover:text-gray-700">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>
        </div>
        <div class="p-6" id="modalContent">
            <!-- Modal content will be injected here -->
        </div>
    </div>
</div>

<script>
    // Constants and Variables
    const currentUserId = localStorage.getItem("userId");
    const ITEMS_PER_PAGE = 5;
    let allOrders = [];
    let filteredOrders = [];
    let currentPage = 1;

    // DOM Elements
    const loadingEl = document.getElementById("loading");
    const noOrdersEl = document.getElementById("noOrders");
    const ordersListEl = document.getElementById("ordersList");
    const searchInputEl = document.getElementById("searchInput");
    const statusFilterEl = document.getElementById("statusFilter");
    const sortOrderEl = document.getElementById("sortOrder");
    const prevPageBtn = document.getElementById("prevPage");
    const nextPageBtn = document.getElementById("nextPage");
    const paginationNumbersEl = document.getElementById("paginationNumbers");
    const orderModal = document.getElementById("orderModal");
    const closeModalBtn = document.getElementById("closeModal");
    const modalContentEl = document.getElementById("modalContent");

    // Check if user is logged in
    if (!currentUserId) {
        alert("You must be logged in to view your orders.");
        window.location.href = "/login";
    }

    // Event Listeners
    window.addEventListener("load", fetchOrders);
    searchInputEl.addEventListener("input", filterOrders);
    statusFilterEl.addEventListener("change", filterOrders);
    sortOrderEl.addEventListener("change", filterOrders);
    prevPageBtn.addEventListener("click", () => changePage(currentPage - 1));
    nextPageBtn.addEventListener("click", () => changePage(currentPage + 1));
    closeModalBtn.addEventListener("click", closeModal);

    // Close modal when clicking outside
    window.addEventListener("click", (e) => {
        if (e.target === orderModal) {
            closeModal();
        }
    });

    // Fetch Orders
    function fetchOrders() {
        loadingEl.classList.remove("hidden");
        ordersListEl.innerHTML = "";
        noOrdersEl.classList.add("hidden");

        // In a real app, you would filter by user ID
        // fetch("/api/orders?userId=" + encodeURIComponent(currentUserId))
        fetch("/api/orders") // Using the sample data for now
            .then(response => response.json())
            .then(data => {
                loadingEl.classList.add("hidden");

                if (!data || data.length === 0) {
                    noOrdersEl.classList.remove("hidden");
                    return;
                }

                // Store orders and update UI
                allOrders = data;
                updateDashboardSummary(data);
                filterOrders();
            })
            .catch(error => {
                console.error("Error fetching orders:", error);
                loadingEl.classList.add("hidden");
                alert("Failed to load orders. Please try again.");
            });
    }

    // Update Dashboard Summary
    function updateDashboardSummary(orders) {
        document.getElementById("totalOrders").textContent = orders.length;

        const pendingCount = orders.filter(order => order.status === "Pending").length;
        const shippedCount = orders.filter(order => order.status.includes("Shipped")).length;
        const completedCount = orders.filter(order => order.status === "Delivered").length;

        document.getElementById("pendingOrders").textContent = pendingCount;
        document.getElementById("shippedOrders").textContent = shippedCount;
        document.getElementById("completedOrders").textContent = completedCount;
    }

    // Filter Orders
    function filterOrders() {
        const searchTerm = searchInputEl.value.toLowerCase();
        const statusFilter = statusFilterEl.value;
        const sortOrder = sortOrderEl.value;

        // Apply filters
        filteredOrders = allOrders.filter(order => {
            // Search term filter
            const matchesSearch =
                order.id.toLowerCase().includes(searchTerm) ||
                order.customerName.toLowerCase().includes(searchTerm) ||
                order.status.toLowerCase().includes(searchTerm) ||
                order.products.some(p => p.name.toLowerCase().includes(searchTerm));

            // Status filter
            const matchesStatus = statusFilter === "all" || order.status === statusFilter;

            return matchesSearch && matchesStatus;
        });

        // Apply sorting
        filteredOrders.sort((a, b) => {
            if (sortOrder === "newest") {
                return parseInt(b.id) - parseInt(a.id);
            } else {
                return parseInt(a.id) - parseInt(b.id);
            }
        });

        // Reset to first page when filters change
        currentPage = 1;
        renderOrders();
        updatePagination();
    }

    // Render Orders
    function renderOrders() {
        ordersListEl.innerHTML = "";

        if (filteredOrders.length === 0) {
            noOrdersEl.classList.remove("hidden");
            return;
        }

        noOrdersEl.classList.add("hidden");

        // Calculate pagination
        const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        const endIndex = startIndex + ITEMS_PER_PAGE;
        const paginatedOrders = filteredOrders.slice(startIndex, endIndex);

        // Render each order
        paginatedOrders.forEach(order => {
            const orderElement = document.createElement("div");
            orderElement.className = "bg-white rounded-lg shadow-md overflow-hidden border border-gray-100";

            // Determine status color
            let statusColor, statusIcon;
            switch(order.status.toLowerCase()) {
                case "pending":
                    statusColor = "bg-yellow-100 text-yellow-800";
                    statusIcon = "clock";
                    break;
                case "shipped":
                case "asdadshipped":
                    statusColor = "bg-blue-100 text-blue-800";
                    statusIcon = "truck";
                    break;
                case "delivered":
                    statusColor = "bg-green-100 text-green-800";
                    statusIcon = "check-circle";
                    break;
                case "cancelled":
                    statusColor = "bg-red-100 text-red-800";
                    statusIcon = "times-circle";
                    break;
                default:
                    statusColor = "bg-gray-100 text-gray-800";
                    statusIcon = "question-circle";
            }

            // Calculate total number of items
            const totalItems = order.products.reduce((sum, product) => sum + (product.quantity || 1), 0);

            orderElement.innerHTML =
                "<div class=\"p-6\">" +
                "<div class=\"flex flex-col md:flex-row md:justify-between md:items-center\">" +
                "<div class=\"mb-4 md:mb-0\">" +
                "<div class=\"flex items-center mb-2\">" +
                "<span class=\"text-gray-500 mr-2\">Order #" + order.id + "</span>" +
                "<span class=\"inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium " + statusColor + "\">" +
                "<i class=\"fas fa-" + statusIcon + " mr-1\"></i>" +
                order.status +
                "</span>" +
                "</div>" +
                "<h3 class=\"text-lg font-semibold text-gray-800\">" +
                escapeHtml(order.customerName) +
                "</h3>" +
                "<div class=\"flex flex-wrap items-center text-sm text-gray-500 mt-1\">" +
                "<span class=\"mr-4\">" +
                "<i class=\"fas fa-envelope mr-1\"></i>" +
                escapeHtml(order.customerEmail) +
                "</span>" +
                "<span>" +
                "<i class=\"fas fa-map-marker-alt mr-1\"></i>" +
                escapeHtml(order.address) +
                "</span>" +
                "</div>" +
                "</div>" +
                "<div class=\"flex items-center\">" +
                "<div class=\"text-right mr-4\">" +
                "<div class=\"text-sm text-gray-500\">Items</div>" +
                "<div class=\"font-semibold\">" + order.products.length + " products</div>" +
                "</div>" +
                "<button class=\"view-details-btn bg-green-50 hover:bg-green-100 text-green-700 px-4 py-2 rounded-lg transition flex items-center\" data-order-id=\"" + order.id + "\">" +
                "<span class=\"mr-1\">Details</span>" +
                "<i class=\"fas fa-chevron-right\"></i>" +
                "</button>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "<div class=\"bg-gray-50 px-6 py-3 flex flex-wrap gap-2\">" +
                order.products.map(function(product) {
                    return (
                        "<div class=\"inline-flex items-center bg-white px-3 py-1 rounded-full text-sm border border-gray-200\">" +
                        "<span class=\"w-2 h-2 rounded-full bg-green-500 mr-2\"></span>" +
                        escapeHtml(product.name) +
                        "</div>"
                    );
                }).join('') +
                "</div>";


            ordersListEl.appendChild(orderElement);

            // Add event listener to the button
            const viewButton = orderElement.querySelector(".view-details-btn");
            viewButton.addEventListener("click", () => showOrderDetails(order));
        });

        // Add event listeners to all view detail buttons
        document.querySelectorAll(".view-details-btn").forEach(btn => {
            btn.addEventListener("click", () => {
                const orderId = btn.getAttribute("data-order-id");
                const order = allOrders.find(o => o.id === orderId);
                if (order) {
                    showOrderDetails(order);
                }
            });
        });
    }

    // Show Order Details Modal
    function showOrderDetails(order) {
        // Determine status color
        let statusColor;
        switch(order.status.toLowerCase()) {
            case "pending":
                statusColor = "bg-yellow-100 text-yellow-800 border-yellow-200";
                break;
            case "shipped":
            case "asdadshipped":
                statusColor = "bg-blue-100 text-blue-800 border-blue-200";
                break;
            case "delivered":
                statusColor = "bg-green-100 text-green-800 border-green-200";
                break;
            case "cancelled":
                statusColor = "bg-red-100 text-red-800 border-red-200";
                break;
            default:
                statusColor = "bg-gray-100 text-gray-800 border-gray-200";
        }

        modalContentEl.innerHTML =
            "<div class=\"flex flex-col md:flex-row justify-between\">" +
            "<div>" +
            "<div class=\"flex items-center mb-2\">" +
            "<span class=\"text-lg font-bold text-gray-800 mr-3\">Order #" + order.id + "</span>" +
            "<span class=\"px-3 py-1 rounded-full text-sm font-medium " + statusColor + "\">" +
            order.status +
            "</span>" +
            "</div>" +
            "<p class=\"text-gray-600 mb-4\">Placed on " + getRandomOrderDate() + "</p>" +
            "</div>" +
            "<div class=\"mb-4 md:mb-0\">" +
            "<button class=\"text-red-600 hover:text-red-800 flex items-center\" onclick=\"alert('Order cancellation not implemented')\">" +
            "<i class=\"fas fa-times-circle mr-1\"></i> Cancel Order" +
            "</button>" +
            "</div>" +
            "</div>" +

            "<div class=\"grid grid-cols-1 md:grid-cols-2 gap-6 mb-6\">" +
            "<div class=\"bg-gray-50 p-4 rounded-lg\">" +
            "<h3 class=\"font-semibold text-gray-700 mb-2\">Customer Information</h3>" +
            "<p class=\"mb-1\"><span class=\"text-gray-500\">Name:</span> " + escapeHtml(order.customerName) + "</p>" +
            "<p class=\"mb-1\"><span class=\"text-gray-500\">Email:</span> " + escapeHtml(order.customerEmail) + "</p>" +
            "<p><span class=\"text-gray-500\">Address:</span> " + escapeHtml(order.address) + "</p>" +
            "</div>" +
            "<div class=\"bg-gray-50 p-4 rounded-lg\">" +
            "<h3 class=\"font-semibold text-gray-700 mb-2\">Shipping Information</h3>" +
            "<p class=\"mb-1\"><span class=\"text-gray-500\">Status:</span> " + order.status + "</p>" +
            "<p class=\"mb-1\"><span class=\"text-gray-500\">Estimated Delivery:</span> " + getRandomDeliveryDate() + "</p>" +
            "<p><span class=\"text-gray-500\">Tracking Number:</span> " + getRandomTrackingNumber() + "</p>" +
            "</div>" +
            "</div>" +

            "<h3 class=\"font-semibold text-gray-700 mb-3 border-b pb-2\">Order Items</h3>" +
            "<div class=\"space-y-4 mb-6\">" +
            order.products.map(function(product) {
                return (
                    "<div class=\"flex items-center justify-between border-b pb-3\">" +
                    "<div class=\"flex items-center\">" +
                    "<div class=\"w-12 h-12 bg-gray-100 rounded-md flex items-center justify-center mr-4\">" +
                    "<i class=\"fas " + getCategoryIcon(product.category) + " text-green-600\"></i>" +
                    "</div>" +
                    "<div>" +
                    "<p class=\"font-medium\">" + escapeHtml(product.name) + "</p>" +
                    "<p class=\"text-sm text-gray-500\">" + escapeHtml(product.category) + "</p>" +
                    "</div>" +
                    "</div>" +
                    "<div class=\"text-right\">" +
                    "<p class=\"font-semibold\">$" + getRandomPrice() + "</p>" +
                    "<p class=\"text-sm text-gray-500\">Qty: " + (product.quantity || 1) + "</p>" +
                    "</div>" +
                    "</div>"
                );
            }).join('') +
            "</div>" +

            "<div class=\"bg-gray-50 p-4 rounded-lg\">" +
            "<h3 class=\"font-semibold text-gray-700 mb-3\">Order Summary</h3>" +
            "<div class=\"flex justify-between mb-2\">" +
            "<span class=\"text-gray-600\">Subtotal</span>" +
            "<span>$" + getRandomTotal() + "</span>" +
            "</div>" +
            "<div class=\"flex justify-between mb-2\">" +
            "<span class=\"text-gray-600\">Shipping</span>" +
            "<span>$" + getRandomShipping() + "</span>" +
            "</div>" +
            "<div class=\"flex justify-between mb-2\">" +
            "<span class=\"text-gray-600\">Tax</span>" +
            "<span>$" + getRandomTax() + "</span>" +
            "</div>" +
            "<div class=\"flex justify-between font-bold border-t pt-2 mt-2\">" +
            "<span>Total</span>" +
            "<span>$" + getRandomGrandTotal() + "</span>" +
            "</div>" +
            "</div>" +

            "<div class=\"mt-6 text-center\">" +
            "<button class=\"bg-green-600 hover:bg-green-700 text-white py-2 px-6 rounded-lg transition mr-4\">" +
            "<i class=\"fas fa-print mr-1\"></i> Print Order" +
            "</button>" +
            "<button class=\"bg-gray-200 hover:bg-gray-300 text-gray-700 py-2 px-6 rounded-lg transition\">" +
            "<i class=\"fas fa-headset mr-1\"></i> Contact Support" +
            "</button>" +
            "</div>";


        orderModal.classList.remove("hidden");
    }

    // Close Modal
    function closeModal() {
        orderModal.classList.add("hidden");
    }

    // Update Pagination
    function updatePagination() {
        const totalPages = Math.ceil(filteredOrders.length / ITEMS_PER_PAGE);

        // Update pagination buttons state
        prevPageBtn.disabled = currentPage <= 1;
        nextPageBtn.disabled = currentPage >= totalPages;

        // Generate pagination numbers
        paginationNumbersEl.innerHTML = "";

        // Calculate range to show
        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, startPage + 4);

        // Adjust range if at the end
        if (endPage - startPage < 4) {
            startPage = Math.max(1, endPage - 4);
        }

        for (let i = startPage; i <= endPage; i++) {
            const pageBtn = document.createElement("button");
            pageBtn.className = "px-3 py-1 border-t border-b border-gray-300 " +
                (i === currentPage
                    ? "bg-green-100 text-green-700 font-medium"
                    : "bg-white text-gray-500 hover:bg-gray-50");

            pageBtn.textContent = i;
            pageBtn.addEventListener("click", () => changePage(i));
            paginationNumbersEl.appendChild(pageBtn);
        }
    }

    // Change Page
    function changePage(page) {
        const totalPages = Math.ceil(filteredOrders.length / ITEMS_PER_PAGE);

        if (page < 1 || page > totalPages) {
            return;
        }

        currentPage = page;
        renderOrders();
        updatePagination();

        // Scroll to top of orders list
        ordersListEl.scrollIntoView({ behavior: "smooth" });
    }

    // Helper Functions
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

    function getCategoryIcon(category) {
        switch(category.toLowerCase()) {
            case "fruits": return "fa-apple-alt";
            case "vegetables": return "fa-carrot";
            case "dairy": return "fa-cheese";
            case "meat": return "fa-drumstick-bite";
            case "bakery": return "fa-bread-slice";
            case "beverages": return "fa-coffee";
            default: return "fa-box";
        }
    }

    // Random data generators for UI demonstration
    function getRandomOrderDate() {
        const months = ["January", "February", "March", "April", "May"];
        const day = Math.floor(Math.random() * 28) + 1;
        const month = months[Math.floor(Math.random() * months.length)];
        return month + " " + day + ", 2025";
    }

    function getRandomDeliveryDate() {
        const months = ["May", "June"];
        const day = Math.floor(Math.random() * 28) + 1;
        const month = months[Math.floor(Math.random() * months.length)];
        return month + " " + day + ", 2025";
    }

    function getRandomTrackingNumber() {
        return "SHP" + Math.floor(1000000000 + Math.random() * 9000000000);
    }


    function getRandomPrice() {
        return (Math.random() * 20 + 5).toFixed(2);
    }

    function getRandomTotal() {
        return (Math.random() * 50 + 20).toFixed(2);
    }

    function getRandomShipping() {
        return (Math.random() * 10 + 5).toFixed(2);
    }

    function getRandomTax() {
        return (Math.random() * 5 + 1).toFixed(2);
    }

    function getRandomGrandTotal() {
        return (Math.random() * 100 + 30).toFixed(2);
    }
</script>

</body>
</html>