<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Staff</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">

<div class="w-full max-w-2xl bg-white rounded-lg shadow-md p-6">
    <h1 class="text-2xl text-green-700 mb-6 font-['Koulen']">Edit Staff</h1>

    <form id="staffForm" class="space-y-4">
        <input type="hidden" id="id">

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Name</label>
            <input type="text" id="name" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid name.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">NIC Number</label>
            <input type="text" id="nicNumber" required
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="nicError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid NIC (e.g., 941234567V).</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Join Date</label>
            <input type="date" id="joinedDate"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="dateError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid date.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Salary</label>
            <input type="number" id="salary" step="0.01" min="0"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="salaryError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid salary.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Address</label>
            <input type="text" id="address"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="addressError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid address.</p>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 font-['Abel']">Contact Number</label>
            <input type="text" id="contactNumber"
                   class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-green-500 focus:border-green-500 font-['Abel']">
            <p id="contactError" class="text-red-500 text-xs mt-1 hidden font-['Abel']">Enter a valid contact number.</p>
        </div>

        <button type="submit"
                class="w-full bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded-md transition duration-200 font-['Koulen']">
            Save Changes
        </button>
    </form>
</div>

<script>
    const pathSegments = window.location.pathname.split('/');
    const staffId = pathSegments[pathSegments.length - 1];

    if (!staffId) {
        alert("Staff ID not provided.");
        window.location.href = "/admin";
    }

    // Load existing staff data
    fetch("/api/staff/" + staffId)
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            document.getElementById("id").value = data.id;
            document.getElementById("name").value = data.name;
            document.getElementById("nicNumber").value = data.nicNumber;
            document.getElementById("joinedDate").value = data.joinedDate;
            document.getElementById("salary").value = data.salary;
            document.getElementById("address").value = data.address;
            document.getElementById("contactNumber").value = data.contactNumber;
        })
        .catch(function (error) {
            console.error("Error fetching staff:", error);
            alert("Could not load staff data.");
        });

    document.getElementById("staffForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const name = document.getElementById("name").value.trim();
        const nicNumber = document.getElementById("nicNumber").value.trim();
        const joinedDate = document.getElementById("joinedDate").value;
        const salary = parseFloat(document.getElementById("salary").value);
        const address = document.getElementById("address").value.trim();
        const contactNumber = document.getElementById("contactNumber").value.trim();

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

        const nicRegex = /^[0-9]{9}[vVxX]$/;
        if (!nicRegex.test(nicNumber)) {
            document.getElementById("nicError").classList.remove("hidden");
            isValid = false;
        }

        if (joinedDate && isNaN(new Date(joinedDate).getTime())) {
            document.getElementById("dateError").classList.remove("hidden");
            isValid = false;
        }

        if (isNaN(salary) || salary < 0) {
            document.getElementById("salaryError").classList.remove("hidden");
            isValid = false;
        }

        if (address.length > 0 && address.length < 3) {
            document.getElementById("addressError").classList.remove("hidden");
            isValid = false;
        }

        const contactRegex = /^\+?[0-9]{10,15}$/;
        if (contactNumber.length > 0 && !contactRegex.test(contactNumber)) {
            document.getElementById("contactError").classList.remove("hidden");
            isValid = false;
        }

        if (!isValid) return;

        const staffData = {
            id: staffId,
            name: name,
            nicNumber: nicNumber,
            joinedDate: joinedDate || null,
            salary: salary || 0.0,
            address: address || null,
            contactNumber: contactNumber || null
        };

        fetch("/api/staff/" + staffId, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(staffData)
        })
            .then(function(response) {
                if (response.ok) {
                    alert("Staff updated successfully!");
                    window.location.href = "/staff";
                } else {
                    alert("Failed to update staff.");
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
                alert("An error occurred while saving.");
            });
    });
</script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</body>
</html>