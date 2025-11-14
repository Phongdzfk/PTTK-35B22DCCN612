<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Our Store</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('/JSP_Servlet_Demo/images/bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 40px 60px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 700px;
        }
        h1 {
            color: #333;
            font-size: 2.5em;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }
        h1::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 60%;
            height: 2px;
            background-color: #6a5acd;
        }
        .search-section {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            margin-bottom: 40px;
        }
        .search-input {
            width: 70%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
            margin-right: 10px;
        }
        .search-button {
            padding: 12px 25px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .search-button:hover {
            background-color: #218838;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
            gap: 20px;
            margin-top: 30px;
        }
        .action-button {
            flex: 1;
            padding: 30px 20px;
            border-radius: 10px;
            color: white;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .action-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .login-button {
            background: linear-gradient(to right, #6a5acd, #8a2be2);
        }
        .register-button {
            background: linear-gradient(to right, #4169e1, #6a5acd);
        }
        .action-button i {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .action-button span {
            font-size: 0.9em;
            font-weight: normal;
            margin-top: 5px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <% if (request.getParameter("success") != null) { %>
            <div class="message success">
                <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <h1>Welcome to Our Store</h1>

        <div class="search-section">
            <input type="text" class="search-input" placeholder="Search for products...">
            <button class="search-button">Search</button>
        </div>

        <div class="action-buttons">
            <a href="login.jsp" class="action-button login-button">
                <i class="fas fa-user"></i>
                Login
                <span>Access your account</span>
            </a>
            <a href="RegisFormView.jsp" class="action-button register-button">
                <i class="fas fa-user-plus"></i>
                Register
                <span>Become a member</span>
            </a>
        </div>
    </div>
</body>
</html>
