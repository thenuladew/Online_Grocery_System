<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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

    <!-- Create Product Button -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold text-green-700">All Products</h1>

        <a href="/create-product"
           class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200">
            + Add New Product
        </a>
    </div>

    <!-- Search Bar -->
    <div class="mb-6">
        <input type="text" id="searchInput"
               placeholder="Search by Name or Category"
               class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500">
    </div>

    <!-- Export Button -->
    <div class="mb-4 text-right">
        <button onclick="generatePDF()"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded transition duration-200">
            Generate PDF
        </button>
    </div>

    <!-- Loading State -->
    <div id="loading" class="text-center text-green-600 font-semibold mb-4">
        Loading products...
    </div>

    <!-- Products Table -->
    <div class="overflow-x-auto">
        <table id="productsTable" class="min-w-full bg-white shadow-md rounded-lg hidden">
            <thead class="bg-green-100 text-green-800">
            <tr>
                <th class="py-3 px-4 text-left">Name</th>
                <th class="py-3 px-4 text-left">Description</th>
                <th class="py-3 px-4 text-left">Price</th>
                <th class="py-3 px-4 text-left">Category</th>
                <th class="py-3 px-4 text-left">Stock</th>
                <th class="py-3 px-4 text-left">Actions</th>
            </tr>
            </thead>
            <tbody id="productsBody">
            <!-- Rows will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const productsTable = document.getElementById("productsTable");
    const productsBody = document.getElementById("productsBody");
    const searchInput = document.getElementById("searchInput");

    // Load products on page load
    window.onload = function () {
        fetch("/api/products")
            .then(function (response) {
                return response.json();
            })
            .then(function (products) {
                renderProducts(products);
            })
            .catch(function (error) {
                console.error("Error fetching products:", error);
                loadingDiv.textContent = "Failed to load products.";
            });
    };

    // Render products into table
    function renderProducts(products, filterText) {
        productsBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        productsTable.classList.remove("hidden");

        if (!filterText) filterText = "";

        filterText = filterText.toLowerCase();

        let filtered = products.filter(function (product) {
            return (
                product.name.toLowerCase().includes(filterText) ||
                product.category.toLowerCase().includes(filterText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='6' class='py-4 px-6 text-center text-gray-500'>No products found.</td>";
            productsBody.appendChild(row);
            return;
        }

        filtered.forEach(function (product) {
            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.name) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.description) + "</td>" +
                "<td class='py-3 px-4 border-b'>$" + parseFloat(product.price).toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.category) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + product.inStockQuantity + "</td>" +
                "<td class='py-3 px-4 border-b'>" +
                "<div class='flex space-x-2'>" +
                "<button onclick=\"editProduct('" + escapeHtml(product.id) + "')\" " +
                "class='text-blue-600 hover:text-blue-900'>" +
                "<i class='fas fa-edit'></i> Edit" +
                "</button>" +
                "<button onclick=\"deleteProduct('" + escapeHtml(product.id) + "', '" + escapeHtml(product.name) + "')\" " +
                "class='text-red-600 hover:text-red-900 ml-4'>" +
                "<i class='fas fa-trash'></i> Delete" +
                "</button>" +
                "</div>" +
                "</td>";

            productsBody.appendChild(row);
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
        fetch("/api/products")
            .then(function (response) {
                return response.json();
            })
            .then(function (products) {
                renderProducts(products, searchInput.value);
            });
    });

    // Navigate to edit page
    function editProduct(id) {
        window.location.href = "/edit-product/" + encodeURIComponent(id);
    }

    // Confirm and delete product
    function deleteProduct(id, name) {
        if (confirm("Are you sure you want to delete product " + name + "?")) {
            fetch("/api/products/" + encodeURIComponent(id), {
                method: "DELETE"
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("Product deleted successfully.");
                        window.location.reload();
                    } else {
                        alert("Failed to delete product.");
                    }
                })
                .catch(function (error) {
                    console.error("Error:", error);
                    alert("An error occurred while deleting.");
                });
        }
    }

    // Generate PDF of product list
    function generatePDF() {
        var { jsPDF } = window.jspdf;
        var doc = new jsPDF("p", "pt", "a4");

        doc.setFontSize(18);
        doc.text("Product List", 40, 40);

        doc.setFontSize(12);
        doc.text("Generated on: " + new Date().toLocaleString(), 40, 60);

        fetch("/api/products")
            .then(function (response) {
                return response.json();
            })
            .then(function (products) {
                let y = 90;
                products.forEach(function (product) {
                    let line = product.name + " | $" + product.price.toFixed(2) + " | Stock: " + product.inStockQuantity;
                    doc.text(line, 40, y);
                    y += 20;
                });

                doc.save("products.pdf");
            });
    }
</script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</body>
</html>