<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Statistics by Revenue</title>
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
        .container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1000px;
        }
        h1 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 25px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
            text-align: center;
        }
        .date-filter {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 30px;
            gap: 15px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
        .date-filter label {
            font-weight: bold;
            color: #555;
        }
        .date-filter input[type="date"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            width: 150px;
        }
        .date-filter button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .date-filter button:hover {
            background-color: #218838;
        }
        .table-container {
            margin-top: 20px;
            overflow-x: auto;
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        table tr:hover {
            background-color: #e9ecef;
            cursor: pointer;
        }
        .selected-row {
            background-color: #e0f7fa !important;
            border: 2px solid #00bcd4;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .action-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .action-buttons .next-button {
            background-color: #007bff;
            color: white;
        }
        .action-buttons .next-button:hover {
            background-color: #0056b3;
        }
        .action-buttons .next-button:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        .action-buttons .return-button {
            background-color: #6c757d;
            color: white;
        }
        .action-buttons .return-button:hover {
            background-color: #5a6268;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .total-revenue-summary {
            margin-top: 10px;
            text-align: right;
        }
        .total-revenue-summary h3 {
            margin: 0;
            color: #333;
            font-size: 1.1em;
            font-weight: normal;
        }
        .revenue-column {
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Item Statistics by Revenue</h1>

        <form action="/JSP_Servlet_Demo/exportstat" method="get" class="date-filter">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value="${param.startDate}" required>
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value="${param.endDate}" required>
            <button type="submit">View</button>
        </form>

        <c:if test="${not empty exportStats}">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Number</th>
                            <th>Item Code</th>
                            <th>Item Name</th>
                            <th>Quantity Sold</th>
                            <th class="revenue-column">Revenue (VND)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="stat" items="${exportStats}" varStatus="loop">
                            <tr data-item-id="${stat.id}" data-item-name="${stat.name}" data-total-quantity="${stat.totalQuantity}" data-total-revenue="${stat.totalRevenue}">
                                <td>${loop.index + 1}</td>
                                <td>${stat.id}</td>
                                <td>${stat.name}</td>
                                <td>${stat.totalQuantity}</td>
                                <td class="revenue-column"><fmt:formatNumber value="${stat.totalRevenue}" pattern="#,##0" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Total Revenue Summary -->
            <div class="total-revenue-summary">
                <c:set var="totalRevenue" value="0" />
                <c:forEach var="stat" items="${exportStats}">
                    <c:set var="totalRevenue" value="${totalRevenue + stat.totalRevenue}" />
                </c:forEach>
                <h3>Total Revenue: <fmt:formatNumber value="${totalRevenue}" pattern="#,##0" /> VND</h3>
            </div>
        </c:if>
        <c:if test="${empty exportStats and not empty param.startDate}">
            <p class="message error">No item statistics available for the selected period.</p>
        </c:if>

        <div class="action-buttons">
            <button type="button" class="return-button" onclick="location.href='/JSP_Servlet_Demo/view/ManagementStaff/StatView.jsp'">Return</button>
            <button type="button" class="next-button" id="nextButton" disabled>Next</button>
        </div>
    </div>

    <script>
        let selectedItemId = null;
        let selectedItemName = null;
        let selectedQuantity = null;
        let selectedRevenue = null;

        document.addEventListener('DOMContentLoaded', function() {
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            
            // If no dates are set, set default dates (last 30 days)
            if (!startDateInput.value) {
                const today = new Date();
                const thirtyDaysAgo = new Date(today);
                thirtyDaysAgo.setDate(today.getDate() - 30);
                
                startDateInput.value = thirtyDaysAgo.toISOString().split('T')[0];
                endDateInput.value = today.toISOString().split('T')[0];
            }
        });

        document.querySelectorAll('table tbody tr').forEach(row => {
            row.addEventListener('click', function() {
                // Remove 'selected-row' from all rows
                document.querySelectorAll('table tbody tr').forEach(r => {
                    r.classList.remove('selected-row');
                });

                // Add 'selected-row' to the clicked row
                this.classList.add('selected-row');
                selectedItemId = this.dataset.itemId;
                selectedItemName = this.dataset.itemName;
                
                // Get quantity and revenue from data attributes (more reliable than parsing text)
                selectedQuantity = this.dataset.totalQuantity;
                selectedRevenue = parseFloat(this.dataset.totalRevenue);
                
                // Additional validation
                if (isNaN(selectedRevenue)) {
                    selectedRevenue = 0;
                }
                
                document.getElementById('nextButton').disabled = false;
            });
        });

        document.getElementById('nextButton').addEventListener('click', function() {
            if (selectedItemId) {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                
                const itemIdNum = parseInt(selectedItemId);
                const quantityNum = parseInt(selectedQuantity);
                const revenueNum = parseFloat(selectedRevenue);
                
                // Validate parsed values
                if (isNaN(itemIdNum) || isNaN(quantityNum) || isNaN(revenueNum)) {
                    alert("Error: Invalid numeric values detected. Please try again.");
                    return;
                }
                
                const exportStat = {
                    itemId: itemIdNum,
                    itemName: selectedItemName,
                    totalQuantity: quantityNum,
                    totalRevenue: revenueNum
                };
                
                
                window.location.href = '/JSP_Servlet_Demo/invoice?exportStat=' + encodeURIComponent(JSON.stringify(exportStat)) + 
                    '&startDate=' + startDate + 
                    '&endDate=' + endDate;
            } else {
                alert('Please select an item first.');
            }
        });
    </script>
</body>
</html>
