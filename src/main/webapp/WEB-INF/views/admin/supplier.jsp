<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Suppliers</title>
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

    <!-- Search Bar -->
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl text-green-700 font-['Koulen']">All Suppliers</h1>

        <input type="text" id="searchInput" placeholder="Search by Name or Company"
               class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 w-1/3 font-['Abel']">

        <a href="/create-supplier"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded transition duration-200 font-['Koulen']">
      Add Supplier
        </a>
    </div>

    <!-- Export Button -->
    <div class="mb-4 text-right">
        <button onclick="generatePDF()"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded transition duration-200 font-['Koulen']">
            Generate PDF
        </button>
    </div>

    <!-- Loading State -->
    <div id="loading" class="text-center text-green-600 mb-4 font-['Abel']">
        Loading suppliers...
    </div>

    <!-- Supplier Table -->
    <div class="overflow-x-auto">
        <table id="suppliersTable" class="min-w-full bg-white shadow-md rounded-lg hidden">
            <thead class="bg-green-100 text-green-800">
            <tr>
                <th class="py-3 px-4 text-left font-['Abel']">Name</th>
                <th class="py-3 px-4 text-left font-['Abel']">Contact Number</th>
                <th class="py-3 px-4 text-left font-['Abel']">Address</th>
                <th class="py-3 px-4 text-left font-['Abel']">Company</th>
                <th class="py-3 px-4 text-left font-['Abel']">BRN</th>
                <th class="py-3 px-4 text-left font-['Abel']">Added By</th>
                <th class="py-3 px-4 text-left font-['Abel']">Actions</th>
            </tr>
            </thead>
            <tbody id="suppliersBody" class="font-['Abel']">
            <!-- Rows will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const suppliersTable = document.getElementById("suppliersTable");
    const suppliersBody = document.getElementById("suppliersBody");
    const searchInput = document.getElementById("searchInput");
    let staffMap = new Map(); // To store staff member details

    // Load staff members
    function loadStaff() {
        return fetch("/api/staff")
            .then(response => response.json())
            .then(staff => {
                staff.forEach(member => {
                    staffMap.set(member.id, member.name);
                });
            });
    }

    // Load suppliers on page load
    window.onload = function () {
        // First load staff members
        loadStaff()
            .then(() => {
                // Then load suppliers
                return fetch("/api/suppliers");
            })
            .then(response => response.json())
            .then(suppliers => {
                renderSuppliers(suppliers);
            })
            .catch(error => {
                console.error("Error:", error);
                loadingDiv.textContent = "Failed to load data.";
            });
    };

    // Render suppliers into table
    function renderSuppliers(suppliers, filterText) {
        suppliersBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        suppliersTable.classList.remove("hidden");

        if (!filterText) filterText = "";

        filterText = filterText.toLowerCase();

        let filtered = suppliers.filter(function (supplier) {
            return (
                supplier.name.toLowerCase().includes(filterText) ||
                supplier.companyName.toLowerCase().includes(filterText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='7' class='py-4 px-6 text-center text-gray-500'>No suppliers found.</td>";
            suppliersBody.appendChild(row);
            return;
        }

        filtered.forEach(function (supplier) {
            var row = document.createElement("tr");
            const staffName = staffMap.get(supplier.staffId) || "Unknown";

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(supplier.name) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(supplier.contactNumber) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(supplier.address) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(supplier.companyName) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(supplier.businessRegistrationNumber) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(staffName) + "</td>" +
                "<td class='py-3 px-4 border-b'>" +
                "<div class='flex space-x-2'>" +
                "<button onclick=\"editSupplier('" + escapeHtml(supplier.id) + "')\" " +
                "class='text-blue-600 hover:text-blue-900'>" +
                "<i class='fas fa-edit'></i> Edit" +
                "</button>" +
                "<button onclick=\"deleteSupplier('" + escapeHtml(supplier.id) + "', '" + escapeHtml(supplier.name) + "')\" " +
                "class='text-red-600 hover:text-red-900 ml-4'>" +
                "<i class='fas fa-trash'></i> Delete" +
                "</button>" +
                "</div>" +
                "</td>";

            suppliersBody.appendChild(row);
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
        fetch("/api/suppliers")
            .then(function (response) {
                return response.json();
            })
            .then(function (suppliers) {
                renderSuppliers(suppliers, searchInput.value);
            });
    });

    // Navigate to edit page
    function editSupplier(id) {
        window.location.href = "/edit-supplier/" + encodeURIComponent(id);
    }

    // Confirm and delete supplier
    function deleteSupplier(id, name) {
        if (confirm("Are you sure you want to delete supplier " + name + "?")) {
            fetch("/api/suppliers/" + encodeURIComponent(id), {
                method: "DELETE"
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("Supplier deleted successfully.");
                        window.location.reload();
                    } else {
                        alert("Failed to delete supplier.");
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
        doc.text("Supplier List", 40, 40);

        // Add generation date
        doc.setFontSize(12);
        doc.text("Generated on: " + new Date().toLocaleString(), 40, 60);

        // Fetch and add suppliers
        fetch("/api/suppliers")
            .then(function (response) {
                return response.json();
            })
            .then(function (suppliers) {
                let y = 90;
                suppliers.forEach(function (supplier) {
                    let line = supplier.name + " | " + supplier.companyName + " | " + supplier.contactNumber;
                    doc.text(line, 40, y);
                    y += 20;
                });

                // Save the PDF
                doc.save("suppliers.pdf");
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