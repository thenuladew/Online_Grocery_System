<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Customers</title>
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

    <!-- Search Bar -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-green-700">All Customers</h1>

        <input type="text" id="searchInput"
               placeholder="Search by Name or Email"
               class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 w-1/3">
    </div>

    <!-- Loading State -->
    <div id="loading" class="text-center text-green-600 font-semibold mb-4">
        Loading customers...
    </div>

    <!-- Customer Table -->
    <div class="overflow-x-auto">
        <table id="customersTable" class="min-w-full bg-white shadow-md rounded-lg hidden">
            <thead class="bg-green-100 text-green-800">
            <tr>
                <th class="py-3 px-4 text-left">Name</th>
                <th class="py-3 px-4 text-left">Email</th>
                <th class="py-3 px-4 text-left">Contact</th>
                <th class="py-3 px-4 text-left">Address</th>
            </tr>
            </thead>
            <tbody id="customersBody">
            <!-- Rows will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const customersTable = document.getElementById("customersTable");
    const customersBody = document.getElementById("customersBody");
    const searchInput = document.getElementById("searchInput");

    // Load customers on page load
    window.onload = function () {
        fetchCustomers();
    };

    // Function to fetch customers
    function fetchCustomers() {
        fetch("/api/customers")
            .then(function (response) {
                return response.json();
            })
            .then(function (customers) {
                renderCustomers(customers);
            })
            .catch(function (error) {
                console.error("Error fetching customers:", error);
                loadingDiv.textContent = "Failed to load customers.";
            });
    }

    // Render customers into table
    function renderCustomers(customers) {
        customersBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        customersTable.classList.remove("hidden");

        const searchText = searchInput.value.toLowerCase().trim();

        let filtered = customers.filter(function (customer) {
            return (
                customer.name.toLowerCase().includes(searchText) ||
                customer.email.toLowerCase().includes(searchText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='4' class='py-4 px-6 text-center text-gray-500'>No customers found.</td>";
            customersBody.appendChild(row);
            return;
        }

        filtered.forEach(function (customer) {
            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(customer.name) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(customer.email) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(customer.contactNumber) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(customer.address) + "</td>";

            customersBody.appendChild(row);
        });
    }

    // Escape HTML to prevent XSS
    function escapeHtml(text) {
        return text.replace(/[&<>"']/g, function(m) {
            return ({
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;'
            })[m];
        });
    }

    // Handle search input with debounce
    let searchTimeout;
    searchInput.addEventListener("input", function () {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function() {
            fetchCustomers();
        }, 300); // 300ms delay
    });
</script>

</body>
</html>