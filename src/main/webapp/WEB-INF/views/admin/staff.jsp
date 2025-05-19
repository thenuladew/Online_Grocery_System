<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Staff</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>
<body class="bg-gray-100 min-h-screen">



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
        <h1 class="text-3xl font-bold text-green-700">All Staff</h1>

        <input type="text" id="searchInput" placeholder="Search by Name or NIC"
               class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 w-1/3">

        <a href="/create-staff"
                class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded transition duration-200">
           Create Staff Member
        </a>
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
        Loading staff...
    </div>

    <!-- Staff Table -->
    <div class="overflow-x-auto">
        <table id="staffTable" class="min-w-full bg-white shadow-md rounded-lg hidden">
            <thead class="bg-green-100 text-green-800">
            <tr>
                <th class="py-3 px-4 text-left">Name</th>
                <th class="py-3 px-4 text-left">NIC Number</th>
                <th class="py-3 px-4 text-left">Joined Date</th>
                <th class="py-3 px-4 text-left">Salary</th>
                <th class="py-3 px-4 text-left">Contact</th>
                <th class="py-3 px-4 text-left">Actions</th>
            </tr>
            </thead>
            <tbody id="staffBody">
            <!-- Rows will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    const loadingDiv = document.getElementById("loading");
    const staffTable = document.getElementById("staffTable");
    const staffBody = document.getElementById("staffBody");
    const searchInput = document.getElementById("searchInput");

    // Load staff on page load
    window.onload = function () {
        fetch("/api/staff")
            .then(function (response) {
                return response.json();
            })
            .then(function (staffList) {
                renderStaff(staffList);
            })
            .catch(function (error) {
                console.error("Error fetching staff:", error);
                loadingDiv.textContent = "Failed to load staff.";
            });
    };

    // Render staff into table
    function renderStaff(staffList, filterText) {
        staffBody.innerHTML = "";
        loadingDiv.classList.add("hidden");
        staffTable.classList.remove("hidden");

        if (!filterText) filterText = "";

        filterText = filterText.toLowerCase();

        let filtered = staffList.filter(function (staff) {
            return (
                staff.name.toLowerCase().includes(filterText) ||
                staff.nicNumber.toLowerCase().includes(filterText)
            );
        });

        if (filtered.length === 0) {
            var row = document.createElement("tr");
            row.innerHTML =
                "<td colspan='6' class='py-4 px-6 text-center text-gray-500'>No staff found.</td>";
            staffBody.appendChild(row);
            return;
        }

        filtered.forEach(function (staff) {
            var row = document.createElement("tr");

            row.innerHTML =
                "<td class='py-3 px-4 border-b'>" + escapeHtml(staff.name) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(staff.nicNumber) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(staff.joinedDate) + "</td>" +
                "<td class='py-3 px-4 border-b'>$" + parseFloat(staff.salary).toFixed(2) + "</td>" +
                "<td class='py-3 px-4 border-b'>" + escapeHtml(staff.contactNumber) + "</td>" +
                "<td class='py-3 px-4 border-b'>" +
                "<div class='flex space-x-2'>" +
                "<button onclick=\"editStaff('" + escapeHtml(staff.id) + "')\" " +
                "class='text-blue-600 hover:text-blue-900'>" +
                "<i class='fas fa-edit'></i> Edit" +
                "</button>" +
                "<button onclick=\"deleteStaff('" + escapeHtml(staff.id) + "', '" + escapeHtml(staff.name) + "')\" " +
                "class='text-red-600 hover:text-red-900 ml-4'>" +
                "<i class='fas fa-trash'></i> Delete" +
                "</button>" +
                "</div>" +
                "</td>";

            staffBody.appendChild(row);
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
        fetch("/api/staff")
            .then(function (response) {
                return response.json();
            })
            .then(function (staffList) {
                renderStaff(staffList, searchInput.value);
            });
    });

    // Navigate to edit page
    function editStaff(id) {
        window.location.href = "/edit-staff/" + encodeURIComponent(id);
    }

    // Confirm and delete staff
    function deleteStaff(id, name) {
        if (confirm("Are you sure you want to delete staff " + name + "?")) {
            fetch("/api/staff/" + encodeURIComponent(id), {
                method: "DELETE"
            })
                .then(function (response) {
                    if (response.ok) {
                        alert("Staff deleted successfully.");
                        window.location.reload();
                    } else {
                        alert("Failed to delete staff.");
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
        doc.text("Staff List", 40, 40);

        // Add generation date
        doc.setFontSize(12);
        doc.text("Generated on: " + new Date().toLocaleString(), 40, 60);

        // Fetch and add staff
        fetch("/api/staff")
            .then(function (response) {
                return response.json();
            })
            .then(function (staffList) {
                let y = 90;
                staffList.forEach(function (staff) {
                    let line = staff.name + " | " + staff.nicNumber + " | " + staff.contactNumber;
                    doc.text(line, 40, y);
                    y += 20;
                });

                // Save the PDF
                doc.save("staff.pdf");
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