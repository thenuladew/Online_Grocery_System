<%@ page contentType="text/html;charset=UTF-8" %>
<header class="header">  
    <style>
      body {
        margin: 0;
        font-family: 'Abel', sans-serif;
        background-color: #f0f0f0;
        color: #333;
        min-height: 100vh;
      }

      /* Header */
      .header {
        background-color: #00AC47;
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        box-sizing: border-box;
        padding: 4px;  /* Increased top and bottom padding */
        box-shadow: none;
      }

      /* Logo on the Left */
      .logo-container {
        display: flex;
        align-items: center;
        margin-left: 18px;
      }

      .logo {
        width: 200px;
        height: auto;
        max-height: 64px;  /* Added maximum height for logo */
      }

      /* Search Bar in the Middle */
      .search-bar {
        flex: 1;
        margin: 0 24px;
        max-width: 500px; /* Adjust search bar width as needed */
      }

      .search-input {
        width: 100%;
        padding: 8px 16px;
        border: none;
        border-radius: 16px;
        font-family: 'Abel', sans-serif;
        font-size: 16px;
        outline: none;
      }

      /* Buttons on the Right */
      .header-buttons {
        display: flex;
        gap: 16px;
        align-items: center;
        margin-right: 24px; /* Move buttons slightly to the middle */
      }

      /* Profile Button */
      .profile-button {
        background-color: #ffffff;
        border: none;
        border-radius: 16px; /* Changed to rectangle with 16px corner radius */
        padding: 8px 16px; /* Adjusted padding for rectangular shape */
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px; /* Space between icon and text */
      }

      .profile-icon {
        width: 20px;
        height: 20px;
      }

      /* Cart Button */
      .cart-button {
        background-color: #FFFFFF;
        border: none;
        border-radius: 16px; /* Changed to rectangle with 16px corner radius */
        padding: 8px 16px; /* Adjusted padding for rectangular shape */
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px; /* Space between icon and text */
      }

      .cart-icon {
        width: 20px;
        height: 20px;
      }

      /* Dropdown Menu */
      .profile-dropdown {
        position: relative;
        display: inline-block;
        margin-right: 10px;
      }

      .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        background-color: #2B2B2B; /* Default dropdown background color */
        min-width: 160px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1;
        border-radius: 16px; /* Added corner radius */
        overflow: hidden; /* Ensures the radius is applied to child elements */
      }

      .dropdown-content a {
        color: #ffffff; /* White text for better contrast */
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        font-family: 'Koulen', sans-serif; /* Koulen font for dropdown */
        font-size: 16px;
      }

      .dropdown-content a:hover {
        background-color: #00AC47; /* Hover background color */
      }

      .profile-dropdown:hover .dropdown-content {
        display: block;
      }

      /* Footer */
      .footer {
        text-align: right;
        padding: 16px;
        background-color: #ffffff;
        margin-top: 24px;
      }

      .footer-text {
        font-size: 14px;
        color: #666;
      }

      .main-content {
        flex: 1;
      }
    </style>

    

      <!-- Logo on the Left -->
      <a href="/">  
        <div class="logo-container">
          <img src="./images/UrbanCart_Admin_long.png" alt="Logo" class="logo">
        </div>
      </a>

      <!-- Buttons on the Right -->
      <div class="header-buttons">
        
        <script>
                // Get userId from localStorage
                const userId = localStorage.getItem("userId");
                console.log("user Id" +userId)
                // Create container reference
                const navButtons = document.currentScript.parentElement;

                if (userId) {
                        // Show Profile and My Orders
                        navButtons.innerHTML += `

                          <!-- View Cart Button -->
                          <a href="/cart">
                            <button class="cart-button">
                              <img src="./images/cart.png" alt="View Cart" class="cart-icon">
                            </button>
                          </a> 

                          <!-- Profile Button with Dropdown -->
                          <div class="profile-dropdown">
                              <button class="profile-button">
                                <img src="./images/user.png" alt="Profile" class="profile-icon">
                              </button>
                            <div class="dropdown-content">
                              <a href="/profile">VIEW PROFILE</a>
                              <a href="/my-orders">ORDER HISTORY</a>
                            </div>
                          </div>
                        `;
                } else {
                    // Show Login
                    navButtons.innerHTML += `
                        <a href="/login"
                           class="px-5 py-2 bg-[#3d3d3d] text-white rounded-md hover:bg-[#2b2b2b] transition duration-200">
                            Login
                        </a>
                    `;
                }
            </script>
        
        
      </div>
</header>
   
