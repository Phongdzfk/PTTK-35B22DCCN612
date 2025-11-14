<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Management Dashboard</title>
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
            max-width: 800px;
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
            background-color: #4a90e2;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
            gap: 30px;
            margin-top: 40px;
        }
        .action-button {
            flex: 1;
            padding: 40px 20px;
            border-radius: 10px;
            color: white;
            text-decoration: none;
            font-size: 1.3em;
            font-weight: bold;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            background: linear-gradient(to right, #6a5acd, #4a90e2);
        }
        .action-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .action-button i {
            font-size: 3em;
            margin-bottom: 15px;
        }
        .action-button span {
            font-size: 0.8em;
            font-weight: normal;
            margin-top: 8px;
            opacity: 0.9;
        }
        .icon-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .chart-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            display: flex;
            align-items: end;
            justify-content: space-between;
        }
        .bar {
            width: 8px;
            background: linear-gradient(to top, #28a745, #20c997);
            border-radius: 2px;
        }
        .bar:nth-child(1) { height: 20px; }
        .bar:nth-child(2) { height: 30px; }
        .bar:nth-child(3) { height: 25px; }
        .box-icon {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            background: #8B4513;
            border-radius: 4px;
            position: relative;
        }
        .box-icon::after {
            content: '';
            position: absolute;
            top: -5px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-bottom: 8px solid #8B4513;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <h1>Management Dashboard</h1>
        
        <div style="text-align: right; margin-bottom: 20px;">
            <form action="../../logout" method="post" style="display: inline;">
                <button type="submit" style="padding: 8px 15px; background-color: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer;">
                    Logout
                </button>
            </form>
        </div>

        <div class="action-buttons">
            <a href="StatView.jsp" class="action-button">
                <div class="icon-container">
                    <div class="chart-icon">
                        <div class="bar"></div>
                        <div class="bar"></div>
                        <div class="bar"></div>
                    </div>
                </div>
                View Statistical Reports
                <span>Access all statistics</span>
            </a>
            <a href="#" class="action-button">
                <div class="icon-container">
                    <div class="box-icon"></div>
                </div>
                Import Items
                <span>Add new inventory</span>
            </a>
        </div>
    </div>
</body>
</html>
