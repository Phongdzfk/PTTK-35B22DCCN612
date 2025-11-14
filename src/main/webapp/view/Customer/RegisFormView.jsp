<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('/JSP_Servlet_Demo/images/bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
        }
        .registration-container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4a90e2;
            text-align: left;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"] {
            width: calc(100% - 20px);
            padding: 12px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        .password-container input {
            width: calc(100% - 40px);
            padding-right: 40px;
        }
        .password-toggle svg {
            width: 20px;
            height: 20px;
            display: block;
        }
        .password-toggle {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 13px;
            color: #666;
            padding: 5px;
        }
        .password-toggle:hover {
            color: #4a90e2;
        }
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus,
        .form-group input[type="email"]:focus {
            border-color: #4a90e2;
            outline: none;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.3);
        }
        .form-group .required-star {
            color: red;
            margin-left: 4px;
        }
        .button-container {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            margin-top: 30px;
        }
        .button-container button {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .button-container .confirm-button {
            background-color: #4a90e2;
            color: white;
        }
        .button-container .confirm-button:hover {
            background-color: #357ABD;
            box-shadow: 0 4px 8px rgba(74, 144, 226, 0.3);
        }
        .button-container .return-button {
            background-color: #6c757d;
            color: white;
        }
        .button-container .return-button:hover {
            background-color: #5a6268;
            box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .field-error {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <h1>Customer Registration</h1>
        
        <!-- Display success/error messages -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="message success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <%
            String usernameError = (String) request.getAttribute("usernameError");
            if (usernameError != null && !usernameError.trim().isEmpty()) {
        %>
            <div class="message error">
                <%= usernameError %>
            </div>
        <%
            }
        %>
        
        <form action="/JSP_Servlet_Demo/customer" method="post">
            <div class="form-group">
                <label for="username">Username <span class="required-star">*</span></label>
                <input type="text" id="username" name="username" placeholder="Enter username" value="${requestScope.username}" required>
            </div>
            <div class="form-group">
                <label for="password">Password <span class="required-star">*</span></label>
                <div class="password-container">
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                    <button type="button" class="password-toggle" onclick="togglePassword('password', 'passwordToggle1')" id="passwordToggle1" aria-label="Toggle password visibility">
                        <svg id="passwordToggle1Icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path id="passwordToggle1IconPath1" d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"></path>
                            <circle id="passwordToggle1IconCircle" cx="12" cy="12" r="3"></circle>
                            <path id="passwordToggle1IconSlash" d="M1 1l22 22" style="display:none;"></path>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password <span class="required-star">*</span></label>
                <div class="password-container">
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                    <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', 'passwordToggle2')" id="passwordToggle2" aria-label="Toggle confirm password visibility">
                        <svg id="passwordToggle2Icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path id="passwordToggle2IconPath1" d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"></path>
                            <circle id="passwordToggle2IconCircle" cx="12" cy="12" r="3"></circle>
                            <path id="passwordToggle2IconSlash" d="M1 1l22 22" style="display:none;"></path>
                        </svg>
                    </button>
                </div>
                <c:if test="${not empty requestScope.passwordError}">
                    <span class="field-error">${requestScope.passwordError}</span>
                </c:if>
            </div>
            <div class="form-group">
                <label for="fullname">Full Name <span class="required-star">*</span></label>
                <input type="text" id="fullname" name="fullname" placeholder="Enter full name" value="${requestScope.fullname}" required>
            </div>
            <div class="form-group">
                <label for="phonenumber">Phone Number <span class="required-star">*</span></label>
                <input type="text" id="phonenumber" name="phonenumber" placeholder="Enter phone number" value="${requestScope.phonenumber}" required>
                <c:if test="${not empty requestScope.phoneError}">
                    <span class="field-error">${requestScope.phoneError}</span>
                </c:if>
            </div>
            <div class="form-group">
                <label for="emailaddress">Email Address <span class="required-star">*</span></label>
                <input type="email" id="emailaddress" name="emailaddress" placeholder="Enter email address" value="${requestScope.emailaddress}" required>
                <c:if test="${not empty requestScope.emailError}">
                    <span class="field-error">${requestScope.emailError}</span>
                </c:if>
            </div>
            <div class="form-group">
                <label for="address">Address <span class="required-star">*</span></label>
                <input type="text" id="address" name="address" placeholder="Enter address" value="${requestScope.address}" required>
            </div>
            <div class="button-container">
                <button type="submit" class="confirm-button">Confirm Registration</button>
                <button type="button" class="return-button" onclick="location.href='/JSP_Servlet_Demo/view/Customer/HomePageView.jsp'">Return</button>
            </div>
        </form>
    </div>

    <script>
        function togglePassword(inputId, buttonId) {
            const input = document.getElementById(inputId);
            const button = document.getElementById(buttonId);
            const icon = document.getElementById(buttonId + 'Icon');
            const slash = document.getElementById(buttonId + 'IconSlash');
            
            if (input.type === 'password') {
                input.type = 'text';
                if (slash) slash.style.display = 'block';
            } else {
                input.type = 'password';
                if (slash) slash.style.display = 'none';
            }
        }

        // Prevent numbers in name field
        function preventNumbersInName(input) {
            input.value = input.value.replace(/[0-9]/g, '');
        }

        // Prevent letters in phone field
        function preventLettersInPhone(input) {
            input.value = input.value.replace(/[a-zA-Z]/g, '');
        }


        // Add event listeners when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const nameInput = document.getElementById('fullname');
            const phoneInput = document.getElementById('phonenumber');
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');

            // Prevent numbers in name field
            if (nameInput) {
                nameInput.addEventListener('input', function() {
                    preventNumbersInName(this);
                });
            }

            // Prevent letters in phone field
            if (phoneInput) {
                phoneInput.addEventListener('input', function() {
                    preventLettersInPhone(this);
                });
            }

        });
    </script>
</body>
</html>
