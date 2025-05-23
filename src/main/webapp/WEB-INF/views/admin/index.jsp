<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">

<jsp:include page="../common/navbarAdmin.jsp"/>
<div class="max-w-7xl mx-auto px-4 py-8">

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Orders -->
        <a href="/orders" class="block p-6 bg-white rounded-lg shadow-md hover:shadow-xl transition transform hover:-translate-y-1 duration-300">
            <div class="flex items-center space-x-4">
                <div class="p-3 bg-blue-100 text-blue-600 rounded-full">
                    <i class="fas fa-shopping-cart fa-lg"></i>
                </div>
                <div>
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Orders</h2>
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
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Staff</h2>
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
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Products</h2>
                    <p class="text-sm text-gray-500 font-['Abel']">Manage product inventory</p>
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
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Customers</h2>
                    <p class="text-sm text-gray-500 font-['Abel']">View and manage users</p>
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
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Feedbacks</h2>
                    <p class="text-sm text-gray-500 font-['Abel']">See customer reviews</p>
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
                    <h2 class="text-lg text-gray-800 font-['Koulen'] uppercase">Suppliers</h2>
                    <p class="text-sm text-gray-500">Manage suppliers</p>
                </div>
            </div>
        </a>
    </div>
</div>

<div class="fixed bottom-8 right-8 z-50">
    <a href="/login" class="bg-green-600 hover:bg-green-700 text-white py-3 px-8 rounded-md font-['Koulen'] text-lg transition duration-200 shadow-lg">
        Logout
    </a>
</div>

</body>
</html>