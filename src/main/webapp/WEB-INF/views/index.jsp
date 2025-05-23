<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Koulen&family=Abel&display=swap" rel="stylesheet">
</head>
<body class="bg-gray-100">

<style>
    .header {
        position: sticky;
        top: 0;
        z-index: 100;
    }
</style>

<div id="mainContent">

<div class="header">
    <jsp:include page="common/navbarDash.jsp"/>
</div>


<div class="max-w-6xl mx-auto px-4 py-8">
    <!-- White Box Container -->
    <div class="bg-white rounded-2xl shadow-md p-8 mb-8">
        <h1 class="text-3xl text-[#2B2B2B]-700 mb-4 font-['Koulen']">Products</h1>

        <div class="flex justify-end space-x-4 mb-6">
            <!-- Category Dropdown -->
            <div class="relative">
                <button id="categoryDropdownButton" 
                        class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition flex items-center font-['Koulen']">
                    Select Category
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                    </svg>
                </button>
                <div id="categoryDropdown" class="hidden absolute z-10 mt-1 w-48 bg-white rounded-md shadow-lg">
                    <div class="py-1">
                        <a href="#" onclick="filterByCategory('all')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">All Categories</a>
                        <a href="#" onclick="filterByCategory('Meat & Fish')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Meat & Fish</a>
                        <a href="#" onclick="filterByCategory('Grains & Bread')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Grains & Bread</a>
                        <a href="#" onclick="filterByCategory('Fruits')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Fruits</a>
                        <a href="#" onclick="filterByCategory('Vegetables')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Vegetables</a>
                        <a href="#" onclick="filterByCategory('Dairy & Eggs')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Dairy & Eggs</a>
                        <a href="#" onclick="filterByCategory('Condiments')" class="block px-4 py-2 text-gray-800 hover:bg-green-100">Condiments</a>
                    </div>
                </div>
            </div>

            <!-- Sorting Dropdown -->
            <div class="relative">
                <button id="sortDropdownButton" 
                class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition flex items-center font-['Koulen']">
                    Sort Products
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                    </svg>
                </button>
                <div id="sortDropdown" class="hidden absolute z-10 mt-1 w-48 bg-white rounded-md shadow-lg">
                    <div class="py-1">
                        <a href="#" onclick="sortProducts('price')" class="block px-4 py-2 text-gray-800 hover:bg-blue-100">By Price (Low to High)</a>
                        <a href="#" onclick="sortProducts('price-desc')" class="block px-4 py-2 text-gray-800 hover:bg-blue-100">By Price (High to Low)</a>
                        <a href="#" onclick="sortProducts('name')" class="block px-4 py-2 text-gray-800 hover:bg-blue-100">By Name (A-Z)</a>
                        <a href="#" onclick="sortProducts('name-desc')" class="block px-4 py-2 text-gray-800 hover:bg-blue-100">By Name (Z-A)</a>
                        <a href="#" onclick="resetSort()" class="block px-4 py-2 text-gray-800 hover:bg-blue-100">Reset</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Loading Spinner -->
        <div id="loading" class="text-center text-green-600 font-semibold">
            Loading products...
        </div>

        <!-- Product Grid -->
        <div id="productGrid" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6 hidden">
        </div>

        <!-- No Results Message -->
        <div id="noResults" class="text-center text-gray-500 py-8 hidden">
            No products match your search criteria.
        </div>
    </div>

    <jsp:include page="feedbacks.jsp"/>
</div>
</div>

<script>
    const productGrid = document.getElementById("productGrid");
    const loadingDiv = document.getElementById("loading");
    const noResultsDiv = document.getElementById("noResults");
    const searchInput = document.getElementById("searchInput");
    let allProducts = []; // Store all products for filtering

    // Fetch products from API
    fetch("/api/products")
        .then(function (response) {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.status);
            }
            return response.json();
        })
        .then(function (products) {
            console.log("Products received:", products); // Debug log
            allProducts = products; // Store all products
            loadingDiv.classList.add("hidden");
            productGrid.classList.remove("hidden");
            renderProducts(products);
            
            // Add event listener for search input
            if (searchInput) {
                searchInput.addEventListener("input", function() {
                    filterProducts(this.value.toLowerCase());
                });
            }
        })
        .catch(function (error) {
            console.error("Error fetching products:", error);
            loadingDiv.textContent = "Failed to load products. Please try again later.";
            loadingDiv.classList.remove("text-green-600");
            loadingDiv.classList.add("text-red-600");
        });

    function renderProducts(products) {
        console.log("Rendering products:", products); // Debug log
        productGrid.innerHTML = ""; // Clear previous content
        
        if (!products || products.length === 0) {
            noResultsDiv.classList.remove("hidden");
            productGrid.classList.add("hidden");
            return;
        } else {
            noResultsDiv.classList.add("hidden");
            productGrid.classList.remove("hidden");
        }

        products.forEach(function (product) {
            var productCard = document.createElement("div");
            productCard.className = "bg-white rounded-lg shadow-md overflow-hidden transition transform hover:scale-105 duration-300";

            // Create stock status HTML
            const stockStatus = product.inStockQuantity === 0 
                ? "<span class='text-red-600 font-semibold'>Out of Stock</span>"
                : "<span class='text-green-600'>In Stock: " + product.inStockQuantity + "</span>";

            productCard.innerHTML =
                "<img src=\"" + product.imageUrl + "\" alt=\"" + product.name + "\" class=\"w-full h-48 object-cover\">" +
                "<div class=\"p-4\">" +
                "<h2 class=\"text-xl font-semibold text-gray-800 mb-2\">" + product.name + "</h2>" +
                "<p class=\"text-sm text-gray-600 mb-2\">" + product.description + "</p>" +
                "<p class=\"text-sm text-gray-500 mb-1\">Category: " + (product.category || "General") + "</p>" +
                "<p class=\"font-bold text-green-600 mb-1 text-lg\">LKR " + product.price.toLocaleString('en-US', {minimumFractionDigits: 2}) + "</p>" +
                "<p class=\"text-sm mb-4\">" + stockStatus + "</p>";

            // Add to Cart Button - disabled if out of stock
            const buttonDisabled = product.inStockQuantity === 0;
            const buttonClass = buttonDisabled 
                ? "mt-2 w-full bg-gray-400 text-white py-2 px-4 rounded cursor-not-allowed font-['Koulen'] text-lg"
                : "mt-2 w-full bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700 transition duration-200 font-['Koulen'] text-lg";

            productCard.innerHTML +=
                "<button " + (buttonDisabled ? "disabled" : "") + " " +
                "onclick=\"" + (buttonDisabled ? "" : "addToCart('" + product.id + "', '" + product.name + "', " + product.price + ")") + "\" " +
                "class=\"" + buttonClass + "\">" +
                (buttonDisabled ? "Out of Stock" : "Add to Cart") +
                "</button>";

            productCard.innerHTML += "</div>";

            productGrid.appendChild(productCard);
        });
    }

    function filterProducts(searchTerm) {
        if (!searchTerm) {
            renderProducts(allProducts);
            return;
        }

        const filteredProducts = allProducts.filter(product => {
            const nameMatch = product.name.toLowerCase().includes(searchTerm);
            const categoryMatch = (product.category || "").toLowerCase().includes(searchTerm);
            return nameMatch || categoryMatch;
        });

        renderProducts(filteredProducts);
    }

    function addToCart(productId, productName, productPrice) {
        const userId = localStorage.getItem("userId");

        if (!userId) {
            alert("You need to login first.");
            window.location.href = "/login";
            return;
        }

        let cart = JSON.parse(localStorage.getItem("cart")) || [];

        const existingItem = cart.find(item => item.id === productId);

        if (existingItem) {
            existingItem.quantity = parseInt(existingItem.quantity) + 1;
        } else {
            cart.push({
                id: productId,
                name: productName,
                price: productPrice,
                category: "OrderedItem",
                quantity: 1
            });
        }

        localStorage.setItem("cart", JSON.stringify(cart));
        alert(productName + " added to cart!");
    }

    // Toggle category dropdown visibility
    document.getElementById('categoryDropdownButton').addEventListener('click', function(e) {
        e.stopPropagation();
        document.getElementById('categoryDropdown').classList.toggle('hidden');
    });

    // Toggle sort dropdown visibility
    document.getElementById('sortDropdownButton').addEventListener('click', function(e) {
        e.stopPropagation();
        document.getElementById('sortDropdown').classList.toggle('hidden');
    });

    // Close dropdowns when clicking outside
    document.addEventListener('click', function() {
        document.getElementById('sortDropdown').classList.add('hidden');
        document.getElementById('categoryDropdown').classList.add('hidden');
    });

    // Filter products by category
    function filterByCategory(category) {
        if (category === 'all') {
            renderProducts(allProducts);
            return;
        }

        const filteredProducts = allProducts.filter(product => 
            product.category === category
        );

        renderProducts(filteredProducts);
    }

    // Reset sort and show all products
    function resetSort() {
        renderProducts(allProducts);
    }

    function mergeSort(arr, key) {
        if (arr.length <= 1) return arr;
        const mid = Math.floor(arr.length / 2);
        const left = mergeSort(arr.slice(0, mid), key);
        const right = mergeSort(arr.slice(mid), key);
        return merge(left, right, key);
    }

    function merge(left, right, key) {
        const result = [];
        let i = 0, j = 0;
        
        const [actualKey, isDescending] = key.includes('-desc') 
            ? [key.replace('-desc', ''), true] 
            : [key, false];

        while (i < left.length && j < right.length) {
            let condition;
            
            if (actualKey === 'price') {
                condition = left[i][actualKey] < right[j][actualKey];
            } else {
                condition = (left[i][actualKey] || "").toLowerCase() < (right[j][actualKey] || "").toLowerCase();
            }
            
            // Flip condition for descending order
            if (isDescending) condition = !condition;
            
            condition ? result.push(left[i++]) : result.push(right[j++]);
        }
        
        return result.concat(left.slice(i)).concat(right.slice(j));
    }

    function sortProducts(key) {
        const sortedProducts = mergeSort([...allProducts], key);
        renderProducts(sortedProducts);
    }
</script>

</body>
</html>