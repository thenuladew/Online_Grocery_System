<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">


<div class="max-w-7xl mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-8 text-center text-green-700">Admin Dashboard</h1>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Orders -->
        <a href="/orders" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-blue-100 text-blue-600 rounded-full">
                    <i class="fas fa-shopping-cart fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Orders</h2>
                    <p class="text-sm text-gray-500">Manage customer orders</p>
                </div>
            </div>
        </a>

        <!-- Staff -->
        <a href="/staff" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-purple-100 text-purple-600 rounded-full">
                    <i class="fas fa-user-tie fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Staff</h2>
                    <p class="text-sm text-gray-500">Manage staff members</p>
                </div>
            </div>
        </a>

        <!-- Products -->
        <a href="/products" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-green-100 text-green-600 rounded-full">
                    <i class="fas fa-box-open fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Products</h2>
                    <p class="text-sm text-gray-500">Manage product inventory</p>
                </div>
            </div>
        </a>

        <!-- Customers -->
        <a href="/customers" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-yellow-100 text-yellow-600 rounded-full">
                    <i class="fas fa-users fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Customers</h2>
                    <p class="text-sm text-gray-500">View and manage users</p>
                </div>
            </div>
        </a>

        <!-- Feedbacks -->
        <a href="/feedbacks" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-red-100 text-red-600 rounded-full">
                    <i class="fas fa-comment-dots fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Feedbacks</h2>
                    <p class="text-sm text-gray-500">See customer reviews</p>
                </div>
            </div>
        </a>

        <!-- Suppliers -->
        <a href="/supplier" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-indigo-100 text-indigo-600 rounded-full">
                    <i class="fas fa-truck fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg font-semibold text-gray-800">Suppliers</h2>
                    <p class="text-sm text-gray-500">Manage suppliers</p>
                </div>
            </div>
        </a>
    </div>
</div>

</body>
</html>