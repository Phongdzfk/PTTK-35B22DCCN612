<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice Details - ${param.itemName}</title>
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
            max-width: 900px;
        }
        h1 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 25px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
            text-align: center;
        }
        h2 {
            color: #007bff;
            font-size: 1.5em;
            margin-top: 30px;
            margin-bottom: 15px;
        }
        .item-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px 20px;
            margin-bottom: 30px;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }
        .item-info-grid div {
            display: contents;
        }
        .item-info-grid label {
            font-weight: bold;
            color: #555;
            text-align: left;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        .item-info-grid span {
            text-align: right;
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        .item-info-grid div:last-of-type label,
        .item-info-grid div:last-of-type span {
            border-bottom: none;
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
        }
        .return-button {
            display: block;
            width: fit-content;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }
        .return-button:hover {
            background-color: #5a6268;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
        .message.info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        .revenue-column {
            text-align: right;
        }
        .period-info {
            text-align: center;
            font-size: 1.2em;
            font-weight: bold;
            color: #010a13;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <c:if test="${not empty invoices}">
            <c:set var="firstInvoiceItem" value="${invoices[0].ii[0]}" />
            <h1>Invoice Details - ${exportStat.name}</h1>
            <h2 class = "period-info">Period: ${startDate} to ${endDate}</h2>

            <h2>Item Information</h2>
            <div class="item-info-grid">
                <div>
                    <label>Code:</label>
                    <span>${exportStat.id}</span>
                </div>
                <div>
                    <label>Name:</label>
                    <span>${exportStat.name}</span>
                </div>
                <div>
                    <label>Description:</label>
                    <span>${firstInvoiceItem.i.description}</span>
                </div>
                <div>
                    <label>Quantity Sold:</label>
                    <span>${exportStat.totalQuantity}</span>
                </div>
                <div>
                    <label>Total Revenue:</label>
                    <span><fmt:formatNumber value="${exportStat.totalRevenue}" pattern="#,##0" /> VND</span>
                </div>
            </div>
        </c:if>

        <h2>Invoice List</h2>
        <c:if test="${not empty invoices}">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Invoice ID</th>
                            <th>Sale Staff ID</th>
                            <th>Customer ID</th>
                            <th>Date Issued</th>
                            <th>Quantity</th>
                            <th class = "revenue-column">Unit Price (VND)</th>
                            <th class = "revenue-column">Total Price (VND)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="invoice" items="${invoices}">
                            <c:forEach var="invoiceItem" items="${invoice.ii}">
                                <tr>
                                    <td>${invoice.id}</td>
                                    <td>${invoice.ss.id}</td>
                                    <td>${invoice.c.id}</td>
                                    <td><fmt:formatDate value="${invoice.dateIssued}" pattern="dd/MM/yyyy" /></td>
                                    <td>${invoiceItem.quantity}</td>
                                    <td class = "revenue-column"><fmt:formatNumber value="${invoiceItem.unitPrice}" pattern="#,##0" /></td>
                                    <td class = "revenue-column"><fmt:formatNumber value="${invoiceItem.totalPrice}" pattern="#,##0" /></td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty invoices}">
            <p class="message info">No invoice items found for this item.</p>
        </c:if>

        <a href="javascript:history.back()" class="return-button">Return</a>
    </div>
</body>
</html>
