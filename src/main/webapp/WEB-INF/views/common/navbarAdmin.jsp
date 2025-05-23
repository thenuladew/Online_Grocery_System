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

      .admin-text {
        margin-right: 18px;
      }

      .admin-text a {
        color: white;
        text-decoration: none;
      }
    </style>

    

      <!-- Logo on the Left -->
      <a href="/admin">  
        <div class="logo-container">
          <img src="./images/UrbanCart_Admin_long.png" alt="Logo" class="logo">
        </div>
      </a>

      <!-- Buttons on the Right -->
      <div class="admin-text">
        <a href="/admin" class="text-xl text-white align-middle mb-6 font-['Koulen']">Admin Dashboard</a>
      </div>
</header>
   
