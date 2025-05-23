<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body class="bg-gray-100 min-h-screen">

    <jsp:include page="../common/navbarAdmin.jsp"/>

<div class="max-w-7xl mx-auto px-4 py-8">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/admin" class="font-bold text-black-700 flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-700" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Back to Dashboard</span>
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
                <th class="py-3 px-4 text-left">Supplier</th>
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
    let suppliers = [];

    // Load suppliers
    fetch("/api/suppliers")
        .then(response => response.json())
        .then(data => {
            suppliers = data;
        })
        .catch(error => {
            console.error("Error loading suppliers:", error);
        });

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

    // Get supplier name by ID
    function getSupplierName(supplierId) {
        const supplier = suppliers.find(s => s.id === supplierId);
        return supplier ? supplier.companyName : "Unknown Supplier";
    }

    // Render products into table
    function renderProducts(products, filterText) {
        productsBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        productsTable.classList.remove("hidden");

        if (!filterText) filterText = "";

        filterText = filterText.toLowerCase();

        const filtered = products.filter(function (product) {
            return (
                product.name.toLowerCase().includes(filterText) ||
                product.category.toLowerCase().includes(filterText) ||
                getSupplierName(product.supplierId).toLowerCase().includes(filterText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='7' class='py-4 px-6 text-center text-gray-500'>No products found.</td>";
            productsBody.appendChild(row);
            return;
        }

        filtered.forEach(function (product) {
            var row = document.createElement("tr");

            // Create stock status HTML
            const stockHtml = product.inStockQuantity === 0 
                ? "<span class='text-red-600 font-semibold'>Out of Stock</span>"
                : product.inStockQuantity;

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.name) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.description) + "</td>" +
                "<td class='py-3 px-4 border-b'>LKR " + parseFloat(product.price).toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(product.category) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + stockHtml + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(getSupplierName(product.supplierId)) + "</td>" +
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

    // Add this function at the top of your script section
    function addLogoToPDF(doc) {
        // Load the logo image
        const logo = new Image();
        logo.src = '/resources/images/UrbanCart.png';
        
        // Wait for the image to load
        return new Promise((resolve) => {
            logo.onload = function() {
                // Calculate center position
                const pageWidth = doc.internal.pageSize.getWidth();
                const logoWidth = 50; // Adjust size as needed
                const logoHeight = 50; // Adjust size as needed
                const x = (pageWidth - logoWidth) / 2;
                
                // Add the logo
                doc.addImage(logo, 'PNG', x, 20, logoWidth, logoHeight);
                resolve();
            };
        });
    }

    // Modify the generatePDF function
    function generatePDF() {
        var { jsPDF } = window.jspdf;
        var doc = new jsPDF("p", "pt", "a4");

        // Add title
        doc.setFontSize(18);
        doc.text("Product List", 40, 40);

        // Add generation date
        doc.setFontSize(12);
        doc.text("Generated on: " + new Date().toLocaleString(), 40, 60);

        // Fetch and add products
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

                // Save the PDF
                doc.save("products.pdf");
            })
            .catch(function (error) {
                console.error("Error generating PDF:", error);
                alert("Error generating PDF. Please try again.");
            });
    }
</script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</body>
</html>