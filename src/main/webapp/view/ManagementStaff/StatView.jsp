<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statistical Reports</title>
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
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 900px;
        }
        h1 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
            text-align: left;
        }
        h1::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 80%;
            height: 2px;
            background-color: #4a90e2;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 30px 0;
        }
        .stat-button {
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
            background: linear-gradient(to bottom, #8a2be2, #6a5acd);
            min-height: 120px;
        }
        .stat-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .stat-button i {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .stat-button span {
            font-size: 0.8em;
            font-weight: normal;
            margin-top: 5px;
            opacity: 0.9;
        }
        .return-button {
            background-color: #6c757d;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            align-self: flex-start;
        }
        .return-button:hover {
            background-color: #5a6268;
        }
        .icon-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .grid-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2px;
        }
        .grid-square {
            background-color: white;
            border-radius: 1px;
        }
        .import-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            background: white;
            border-radius: 4px;
            position: relative;
        }
        .import-icon::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 6px solid transparent;
            border-right: 6px solid transparent;
            border-top: 8px solid white;
        }
        .customer-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            position: relative;
        }
        .customer-icon::before,
        .customer-icon::after {
            content: '';
            position: absolute;
            width: 12px;
            height: 12px;
            background: white;
            border-radius: 50%;
        }
        .customer-icon::before {
            top: 8px;
            left: 4px;
        }
        .customer-icon::after {
            top: 8px;
            right: 4px;
        }
        .supplier-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            background: white;
            border-radius: 2px;
            position: relative;
        }
        .supplier-icon::before {
            content: '';
            position: absolute;
            top: 8px;
            left: 6px;
            width: 28px;
            height: 20px;
            background: white;
            border-radius: 1px;
        }
        .supplier-icon::after {
            content: '';
            position: absolute;
            top: 12px;
            left: 8px;
            width: 24px;
            height: 2px;
            background: #8a2be2;
            border-radius: 1px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <h1>Statistical Reports</h1>

        <div class="stats-grid">
            <a href="ItemStatView.jsp" class="stat-button">
                <div class="icon-container">
                    <div class="grid-icon">
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                        <div class="grid-square"></div>
                    </div>
                </div>
                View Item Stats
                <span>Product statistics</span>
            </a>
            
            <a href="#" class="stat-button">
                <div class="icon-container">
                    <div class="import-icon"></div>
                </div>
                View Import Stats
                <span>Import statistics</span>
            </a>
            
            <a href="#" class="stat-button">
                <div class="icon-container">
                    <div class="customer-icon"></div>
                </div>
                View Customer Stats
                <span>Customer statistics</span>
            </a>
            
            <a href="#" class="stat-button">
                <div class="icon-container">
                    <div class="supplier-icon"></div>
                </div>
                View Supplier Stats
                <span>Supplier statistics</span>
            </a>
        </div>

        <button class="return-button" onclick="location.href='/JSP_Servlet_Demo/view/ManagementStaff/ManagementStaffHomeView.jsp'">Return</button>
    </div>
</body>
</html>
