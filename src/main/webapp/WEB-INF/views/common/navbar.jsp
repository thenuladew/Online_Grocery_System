 <%@ page contentType="text/html;charset=UTF-8" %>
<nav class="bg-white border-gray-200 px-4 py-4 shadow-md">
        <div class="flex justify-between items-center max-w-6xl mx-auto">
            <!-- Title -->
            <div class="text-xl font-bold text-green-700">
                UrbanCart
            </div>
    
    
            <!-- Nav Buttons -->
            <div class="flex items-center space-x-6">
                
                <!-- Conditional Login / Profile -->
                <script>
                    // Get userId from localStorage
                    const userId = localStorage.getItem("userId");
                    console.log("user Id" +userId)
                    // Create container reference
                    const navButtons = document.currentScript.parentElement;
    
                    if (userId) {
                        // Show Profile and My Orders
                        navButtons.innerHTML += `

                            <a href="/cart" class="text-gray-700 hover:text-green-600 transition duration-200">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                                </svg>
                            </a>

                            <a href="/my-orders"
                               class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-200 mr-2">
                                My Orders
                            </a>
                            <a href="/profile"
                               class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition duration-200">
                                Profile
                            </a>
                        `;
                    } else {
                        // Show Login
                        navButtons.innerHTML += `
                            <a href="/login"
                               class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-200">
                                Login
                            </a>
                        `;
                    }
                </script>
            </div>
        </div>
</nav>