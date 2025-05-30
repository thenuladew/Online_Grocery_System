<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Supplier</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-2xl bg-white rounded-lg shadow-md p-6">
    <h1 class="text-2xl text-green-700 mb-6 font-['Koulen']">Edit Supplier</h1>

    <form id="supplierForm" class="space-y-4">
        <input type="hidden" id="id">

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Name</label>
            <input type="text" id="name" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid name.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Contact Number</label>
            <input type="text" id="contactNumber" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="contactError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid contact number.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Address</label>
            <input type="text" id="address" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="addressError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid address.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Company Name</label>
            <input type="text" id="companyName" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="companyError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid company name.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Business Registration Number</label>
            <input type="text" id="businessRegistrationNumber" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="brnError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid BRN (e.g., BRN123456).</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Added By Staff Member</label>
            <select id="staffId" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
                <option value="">Select a staff member</option>
                <!-- Staff members will be loaded here dynamically -->
            </select>
            <p id="staffError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Please select a staff member.</p>
        </div>

        <button type="submit"
                class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200 font-['Koulen']">
            Save Changes
        </button>
    </form>
</div>

<script>
    const pathSegments = window.location.pathname.split('/');
    const supplierId = pathSegments[pathSegments.length - 1];

    if (!supplierId) {
        alert("Supplier ID not provided.");
        window.location.href = "/admin";
    }

    // Load staff members when the page loads
    function loadStaff() {
        return fetch("/api/staff")
            .then(response => response.json())
            .then(staff => {
                const staffSelect = document.getElementById("staffId");
                staff.forEach(member => {
                    const option = document.createElement("option");
                    option.value = member.id;
                    option.textContent = member.name;
                    staffSelect.appendChild(option);
                });
            });
    }

    // Load existing supplier data
    window.onload = function() {
        // First load staff members
        loadStaff()
            .then(() => {
                // Then load supplier data
                return fetch("/api/suppliers/" + supplierId);
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById("id").value = data.id;
                document.getElementById("name").value = data.name;
                document.getElementById("contactNumber").value = data.contactNumber;
                document.getElementById("address").value = data.address;
                document.getElementById("companyName").value = data.companyName;
                document.getElementById("businessRegistrationNumber").value = data.businessRegistrationNumber;
                document.getElementById("staffId").value = data.staffId;
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Failed to load data. Please try again.");
            });
    };

    document.getElementById("supplierForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const name = document.getElementById("name").value.trim();
        const contactNumber = document.getElementById("contactNumber").value.trim();
        const address = document.getElementById("address").value.trim();
        const companyName = document.getElementById("companyName").value.trim();
        const businessRegistrationNumber = document.getElementById("businessRegistrationNumber").value.trim();
        const staffId = document.getElementById("staffId").value;

        let isValid = true;

        // Reset errors
        document.querySelectorAll(".hidden").forEach(function (el) {
            el.classList.add("hidden");
        });

        const nameRegex = /^[a-zA-Z\s]{3,}$/;
        if (!nameRegex.test(name)) {
            document.getElementById("nameError").classList.remove("hidden");
            isValid = false;
        }

        const contactRegex = /^\+?[0-9]{10,15}$/;
        if (!contactRegex.test(contactNumber)) {
            document.getElementById("contactError").classList.remove("hidden");
            isValid = false;
        }

        if (address.length < 3) {
            document.getElementById("addressError").classList.remove("hidden");
            isValid = false;
        }

        if (companyName.length < 2) {
            document.getElementById("companyError").classList.remove("hidden");
            isValid = false;
        }

        const brnRegex = /^BRN[0-9]{6,}$/;
        if (!brnRegex.test(businessRegistrationNumber)) {
            document.getElementById("brnError").classList.remove("hidden");
            isValid = false;
        }

        if (!staffId) {
            document.getElementById("staffError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) return;

        const supplierData = {
            id: supplierId,
            name: name,
            contactNumber: contactNumber,
            address: address,
            companyName: companyName,
            businessRegistrationNumber: businessRegistrationNumber,
            staffId: staffId
        };

        fetch("/api/suppliers/" + supplierId, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(supplierData)
        })
            .then(function(response) {
                if (response.ok) {
                    alert("Supplier updated successfully!");
                    window.location.href = "/supplier";
                } else {
                    alert("Failed to update supplier.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
                alert("An error occurred while saving.");
            });
    });
</script>

</body>
</html>
