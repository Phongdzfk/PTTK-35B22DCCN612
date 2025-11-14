-- Database Schema for E-commerce/Inventory Management System
-- Based on the provided ERD

-- Create database
CREATE DATABASE IF NOT EXISTS web_demo;
USE web_demo;

-- Drop existing tables if they exist (in correct order due to foreign keys)
DROP TABLE IF EXISTS tblInvoiceItem;
DROP TABLE IF EXISTS tblInvoice;
DROP TABLE IF EXISTS tblImportBillItem;
DROP TABLE IF EXISTS tblImportBill;
DROP TABLE IF EXISTS tblItem;
DROP TABLE IF EXISTS tblSupplier;
DROP TABLE IF EXISTS tblManagementStaff;
DROP TABLE IF EXISTS tblDeliveryStaff;
DROP TABLE IF EXISTS tblSaleStaff;
DROP TABLE IF EXISTS tblStaff;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblUser;

-- 1. tblUser - Base user table
CREATE TABLE tblUser (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(25) NOT NULL,
    fullname VARCHAR(50) NOT NULL,
    phonenumber VARCHAR(15) NOT NULL,
    emailaddress VARCHAR(25) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- 2. tblCustomer - Customer specific information
CREATE TABLE tblCustomer (
    tblUserid INT(10) PRIMARY KEY,
    membershipNumber VARCHAR(15),
    FOREIGN KEY (tblUserid) REFERENCES tblUser(id) ON DELETE CASCADE
);

-- 3. tblStaff - Staff specific information
CREATE TABLE tblStaff (
    tblUserid INT(10) PRIMARY KEY,
    role VARCHAR(10) NOT NULL,
    FOREIGN KEY (tblUserid) REFERENCES tblUser(id) ON DELETE CASCADE
);

-- 4. tblSaleStaff - Sales staff specific information
CREATE TABLE tblSaleStaff (
    tblUserid INT(10) PRIMARY KEY,
    FOREIGN KEY (tblUserid) REFERENCES tblStaff(tblUserid) ON DELETE CASCADE
);

-- 5. tblDeliveryStaff - Delivery staff specific information
CREATE TABLE tblDeliveryStaff (
    tblUserid INT(10) PRIMARY KEY,
    FOREIGN KEY (tblUserid) REFERENCES tblStaff(tblUserid) ON DELETE CASCADE
);

-- 6. tblManagementStaff - Management staff specific information
CREATE TABLE tblManagementStaff (
    tblUserid INT(10) PRIMARY KEY,
    FOREIGN KEY (tblUserid) REFERENCES tblStaff(tblUserid) ON DELETE CASCADE
);

-- 7. tblSupplier - Supplier information
CREATE TABLE tblSupplier (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    brandName VARCHAR(50) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL,
    emailAddress VARCHAR(25) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- 8. tblItem - Item/Product information
CREATE TABLE tblItem (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    stockQuantity INT(10) DEFAULT 0,
    unitPrice DOUBLE NOT NULL
);

-- 9. tblImportBill - Import bills from suppliers
CREATE TABLE tblImportBill (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    date DATE NOT NULL,
    tblSupplierid INT(10),
    tblManagementStaffid INT(10),
    FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id),
    FOREIGN KEY (tblManagementStaffid) REFERENCES tblManagementStaff(tblUserid)
);

-- 10. tblImportBillItem - Items in import bills
CREATE TABLE tblImportBillItem (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    quantity INT(10) NOT NULL,
    unitPrice DOUBLE NOT NULL,
    tblImportBillid INT(10),
    tblItemid INT(10),
    FOREIGN KEY (tblImportBillid) REFERENCES tblImportBill(id),
    FOREIGN KEY (tblItemid) REFERENCES tblItem(id)
);

-- 11. tblInvoice - Customer invoices
CREATE TABLE tblInvoice (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    date DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    tblCustomerid INT(10),
    tblSaleStaffid INT(10),
    tblDeliveryStaffid INT(10),
    FOREIGN KEY (tblCustomerid) REFERENCES tblCustomer(tblUserid),
    FOREIGN KEY (tblSaleStaffid) REFERENCES tblSaleStaff(tblUserid),
    FOREIGN KEY (tblDeliveryStaffid) REFERENCES tblDeliveryStaff(tblUserid)
);

-- 12. tblInvoiceItem - Items in customer invoices
CREATE TABLE tblInvoiceItem (
    id INT(10) PRIMARY KEY AUTO_INCREMENT,
    quantity INT(10) NOT NULL,
    unitPrice DOUBLE NOT NULL,
    tblInvoiceid INT(10),
    tblItemid INT(10),
    FOREIGN KEY (tblInvoiceid) REFERENCES tblInvoice(id),
    FOREIGN KEY (tblItemid) REFERENCES tblItem(id)
);

-- Insert sample data for testing
-- Sample users
INSERT INTO tblUser (username, password, fullname, phonenumber, emailaddress, address) VALUES
('manager1', 'manager123', 'phong1', '0987654321', 'manager@company.com', '456 Ha Noi'),
('sales1', 'sales123', 'phong2', '0555666777', 'sales@company.com', '789 Ha Noi'),
('delivery1', 'delivery123', 'phong3', '0333444555', 'delivery@company.com', '321 Ha Noi'),
('customer1', 'customer123', 'phong4', '0111222333', 'customer@email.com', '654 Ha Noi'),
('sales2', 'sales234', 'phong5', '0555666888', 'sales2@company.com', '7891 Ha Noi'),
('delivery2', 'delivery234', 'phong6', '0333444666', 'delivery2@company.com', '3211 Ha Noi'),
('customer2', 'customer234', 'phong7', '0111222444', 'customer2@email.com', '6541 Ha Noi'),
('customer3', 'customer345', 'phong8', '0858262492', 'customer3@email.com', '6312 Ha Noi');

INSERT INTO tblCustomer (tblUserid, membershipNumber) VALUES
(4, 'CM00001'),
(7, 'CM00002'),
(8, 'CM00003');

-- Sample staff
INSERT INTO tblStaff (tblUserid, role) VALUES
(1, 'management'),
(2, 'sales'),
(3, 'delivery'),
(5, 'sales'),
(6, 'delivery');

-- Sample specific staff types
INSERT INTO tblManagementStaff (tblUserid) VALUES (1);
INSERT INTO tblSaleStaff (tblUserid) VALUES (2),(5);
INSERT INTO tblDeliveryStaff (tblUserid) VALUES (3),(6);

-- Sample items
INSERT INTO tblItem (name, description, stockQuantity, unitPrice) VALUES
('Laptop', 'Advance gaming laptop', 100, 10000000),
('Washing machine', 'Made in Japan', 80, 20000000),
('Printer', 'Massive printer', 50, 25000000),
('Wireless mouse', 'No delay', 30, 500000),
('Router Wifi', '50 meter area', 200, 400000),
('Smartphone', 'Latest iPhone model', 50, 15000000),
('Tablet', 'iPad Pro 12.9 inch', 30, 12000000),
('Headphones', 'Wireless noise-cancelling', 80, 3000000),
('Keyboard', 'Mechanical gaming keyboard', 60, 2000000),
('Monitor', '4K Ultra HD 27 inch', 40, 8000000),
('Camera', 'DSLR Professional', 25, 18000000),
('Speaker', 'Bluetooth portable speaker', 70, 1500000),
('Charger', 'Fast charging cable', 200, 200000),
('Case', 'Protective phone case', 150, 300000),
('Stand', 'Adjustable laptop stand', 45, 800000),
('Smartwatch', 'Đồng hồ thông minh chống nước', 120, 5000000),
('External Hard Drive', 'Ổ cứng di động 1TB', 90, 2500000),
('Power Bank', 'Sạc dự phòng dung lượng 20000mAh', 200, 700000),
('Projector', 'Máy chiếu mini cho văn phòng', 40, 8500000),
('Drone', 'Flycam quay phim 4K', 25, 12000000),
('Gaming Chair', 'Ghế gaming công thái học', 60, 3500000),
('SSD 1TB', 'Ổ cứng SSD tốc độ cao 1TB', 100, 2800000),
('Graphic Card RTX 4070', 'Card đồ họa cao cấp RTX 4070', 30, 20000000),
('Microphone', 'Micro thu âm chuyên nghiệp', 70, 1800000),
('Webcam', 'Camera Full HD 1080p', 100, 1200000),
('Air Purifier', 'Máy lọc không khí gia đình', 45, 7000000),
('Electric Fan', 'Quạt điện thông minh kết nối Wi-Fi', 80, 1500000),
('Coffee Maker', 'Máy pha cà phê tự động', 50, 5000000),
('Vacuum Cleaner', 'Máy hút bụi không dây', 55, 4000000),
('Smart Light', 'Bóng đèn thông minh điều khiển bằng app', 200, 500000);

-- Sample invoices
INSERT INTO tblInvoice (date, status, tblCustomerid, tblSaleStaffid, tblDeliveryStaffid) VALUES
('2025-01-15', 'completed', 4, 2, 3),
('2025-01-16', 'completed', 7, 2, 3),
('2025-01-17', 'completed', 4, 2, 3),
('2025-01-18', 'completed', 7, 2, 3),
('2025-01-19', 'completed', 4, 5, 6),
('2025-01-20', 'completed', 8, 5, 6),
('2025-01-21', 'completed', 4, 5, 6),
('2025-01-22', 'completed', 7, 5, 6),
('2025-01-23', 'completed', 4, 2, 3),
('2025-01-24', 'completed', 7, 2, 6),
('2025-01-25', 'completed', 8, 2, 3),
('2025-01-26', 'completed', 7, 2, 6),
('2025-01-27', 'completed', 4, 5, 3),
('2025-01-28', 'completed', 7, 5, 6),
('2025-01-29', 'completed', 4, 5, 3),
('2025-01-30', 'completed', 7, 5, 6),
('2025-01-31', 'completed', 8, 2, 3),
('2025-02-01', 'completed', 7, 5, 6),
('2025-02-02', 'completed', 8, 2, 3),
('2025-02-03', 'completed', 8, 2, 3),
('2025-01-24', 'pending', 7, 5, 6),
('2025-01-19', 'pending', 7, 5, 6),
('2025-02-05', 'completed', 4, 2, 3),
('2025-02-06', 'completed', 7, 5, 6),
('2025-02-07', 'completed', 8, 2, 6),
('2025-02-08', 'completed', 4, 5, 3),
('2025-02-09', 'completed', 7, 2, 3),
('2025-02-10', 'completed', 8, 2, 6),
('2025-02-11', 'pending', 4, 2, 3),
('2025-02-12', 'completed', 7, 5, 6),
('2025-02-13', 'completed', 8, 2, 3),
('2025-02-14', 'completed', 4, 2, 3),
('2025-02-15', 'completed', 7, 5, 6),
('2025-02-16', 'pending', 8, 2, 6),
('2025-02-17', 'completed', 4, 2, 3),
('2025-02-18', 'completed', 7, 5, 6),
('2025-02-19', 'completed', 8, 5, 6),
('2025-02-20', 'completed', 4, 5, 6),
('2025-02-21', 'completed', 7, 2, 3),
('2025-02-22', 'completed', 8, 2, 3),
('2025-02-23', 'pending', 4, 5, 6),
('2025-02-24', 'completed', 7, 2, 3),
('2025-03-01', 'completed', 4, 2, 3),
('2025-03-02', 'completed', 7, 5, 6),
('2025-03-03', 'completed', 8, 2, 6),
('2025-03-04', 'completed', 4, 5, 6),
('2025-03-05', 'completed', 7, 2, 3),
('2025-03-06', 'completed', 8, 5, 6),
('2025-03-07', 'completed', 4, 2, 3),
('2025-03-08', 'completed', 7, 5, 6),
('2025-03-09', 'completed', 8, 2, 3),
('2025-03-10', 'completed', 4, 5, 6),
('2025-03-11', 'completed', 7, 2, 3),
('2025-03-12', 'completed', 8, 5, 6),
('2025-03-13', 'completed', 4, 5, 6),
('2025-03-14', 'completed', 7, 2, 3),
('2025-03-15', 'completed', 8, 2, 6),
('2025-03-16', 'pending', 4, 2, 3),
('2025-03-17', 'completed', 7, 5, 6),
('2025-03-18', 'completed', 8, 5, 6),
('2025-03-19', 'completed', 4, 2, 3),
('2025-03-20', 'completed', 7, 2, 3);


-- Sample invoice items
INSERT INTO tblInvoiceItem (quantity, unitPrice, tblInvoiceid, tblItemid) VALUES
-- Invoice 1 (2024-01-15) - Laptop + Washing machine
(2, 10000000, 1, 1),
(1, 18000000, 1, 2),
-- Invoice 2 (2024-01-16) - Printer + Mouse
(1, 22000000, 2, 3),
(3, 520000, 2, 4),
-- Invoice 3 (2024-01-17) - Router + Smartphone
(2, 410000, 3, 5),
(1, 15000000, 3, 6),
-- Invoice 4 (2024-01-18) - Tablet + Headphones
(1, 13000000, 4, 7),
(2, 3100000, 4, 8),
-- Invoice 5 (2024-01-19) - Keyboard + Monitor
(1, 2000000, 5, 9),
(1, 7900000, 5, 10),
-- Invoice 6 (2024-01-20) - Camera + Speaker
(1, 18000000, 6, 11),
(2, 1500000, 6, 12),
-- Invoice 7 (2024-01-21) - Multiple items
(5, 210000, 7, 13),
(3, 320000, 7, 14),
(1, 830000, 7, 15),
-- Invoice 8 (2024-01-22) - Laptop again
(1, 11000000, 8, 1),
(2, 500000, 8, 4),
-- Invoice 9 (2024-01-23) - Washing machine + Router
(1, 19000000, 9, 2),
(4, 390000, 9, 5),
-- Invoice 10 (2024-01-24) - Smartphone + Accessories
(1, 15001000, 10, 6),
(2, 201000, 10, 13),
(3, 330000, 10, 14),
-- Invoice 11 (2024-01-25) - Tablet + Case
(1, 12000000, 11, 7),
(2, 300000, 11, 14),
-- Invoice 12 (2024-01-26) - Headphones + Stand
(1, 3200000, 12, 8),
(5, 810000, 12, 15),
-- Invoice 13 (2024-01-27) - Keyboard + Mouse
(1, 2000000, 13, 9),
(2, 500000, 13, 4),
-- Invoice 14 (2024-01-28) - Monitor + Charger
(1, 8100000, 14, 10),
(3, 250000, 14, 13),
-- Invoice 15 (2024-01-29) - Camera + Speaker
(1, 18500000, 15, 11),
(1, 1600000, 15, 12),
-- Invoice 16 (2024-01-30) - Multiple small items
(5, 300000, 16, 13),
(3, 350000, 16, 14),
(2, 450000, 16, 5),
-- Invoice 17 (2024-01-31) - Laptop + Accessories
(1, 11000000, 17, 1),
(4, 240000, 17, 13),
(1, 270000, 17, 14),
-- Invoice 18 (2024-02-01) - Washing machine + Router
(1, 21000000, 18, 2),
(10, 290000, 18, 5),
-- Invoice 19 (2024-02-02) - Printer + Mouse
(1, 24000000, 19, 3),
(2, 550000, 19, 4),
-- Invoice 20 (2024-02-03) - Smartphone + Case
(1, 15500000, 20, 6),
(5, 300000, 20, 14),
-- Invoice 21 (2024-02-04) - Pending orders
(7, 12000000, 21, 7),
(1, 3200000, 21, 8),
-- Invoice 22 (2024-02-05) - Pending orders
(4, 2000000, 22, 9),
(1, 8400000, 22, 10),
-- Invoice 23
(2, 5200000, 23, 16), -- Smartwatch
(2, 2400000, 23, 17), -- External Hard Drive
(1, 690000, 23, 18),  -- Power Bank

-- Invoice 24
(6, 8500000, 24, 19), -- Projector
(1, 12100000, 24, 20), -- Drone

-- Invoice 25
(2, 3500000, 25, 21), -- Gaming Chair
(1, 2800000, 25, 22), -- SSD 1TB

-- Invoice 26
(1, 20000000, 26, 23), -- RTX 4070
(3, 1800000, 26, 24),  -- Microphone

-- Invoice 27
(2, 1200000, 27, 25),  -- Webcam
(1, 7100000, 27, 26),  -- Air Purifier

-- Invoice 28
(3, 1600000, 28, 27),  -- Electric Fan
(1, 5000000, 28, 28),  -- Coffee Maker

-- Invoice 29
(1, 3900000, 29, 29),  -- Vacuum Cleaner
(4, 520000, 29, 30),   -- Smart Light

-- Invoice 30
(2, 4900000, 30, 16),  -- Smartwatch
(1, 12000000, 30, 20), -- Drone

-- Invoice 31
(1, 2500000, 31, 17),  -- External Hard Drive
(2, 700000, 31, 18),   -- Power Bank
(1, 8500000, 31, 19),  -- Projector

-- Invoice 32
(1, 3500000, 32, 21),  -- Gaming Chair
(2, 2800000, 32, 22),  -- SSD
(3, 1800000, 32, 24),  -- Microphone

-- Invoice 33
(1, 1200000, 33, 25),
(2, 7200000, 33, 26),

-- Invoice 34
(1, 5100000, 34, 28),
(5, 4000000, 34, 29),

-- Invoice 35
(2, 500000, 35, 30),
(1, 18000000, 35, 11), -- Camera

-- Invoice 36
(1, 20000000, 36, 23),
(5, 2800000, 36, 22),

-- Invoice 37
(3, 1500000, 37, 27),
(1, 8500000, 37, 19),

-- Invoice 38
(1, 4000000, 38, 29),
(8, 5000000, 38, 16),

-- Invoice 39
(1, 1800000, 39, 24),
(2, 500000, 39, 30),

-- Invoice 40
(1, 2500000, 40, 17),
(3, 12000000, 40, 20),

-- Invoice 41
(1, 8500000, 41, 19),
(2, 3500000, 41, 21),
(2, 2800000, 41, 22),

-- Invoice 42
(1, 18000000, 42, 11),
(1, 1300000, 42, 25),
(3, 1400000, 42, 27),
-- Invoice 43: Laptop + Router
(1, 9800000, 43, 1),
(2, 450000, 43, 5),

-- Invoice 44: Washing Machine + Mouse
(1, 20500000, 44, 2),
(1, 480000, 44, 4),

-- Invoice 45: Printer + Keyboard
(1, 25500000, 45, 3),
(4, 1900000, 45, 9),

-- Invoice 46: Smartphone + Case
(2, 14800000, 46, 6),
(1, 280000, 46, 14),

-- Invoice 47: Monitor + Charger + Router
(1, 7900000, 47, 10),
(2, 210000, 47, 13),
(1, 420000, 47, 5),

-- Invoice 48: Tablet + Headphones
(1, 11800000, 48, 7),
(1, 3100000, 48, 8),

-- Invoice 49: Camera + Mouse + Keyboard
(1, 18200000, 49, 11),
(3, 550000, 49, 4),
(1, 2100000, 49, 9),

-- Invoice 50: Washing Machine + SmartPhone
(1, 19900000, 50, 2),
(5, 15200000, 50, 6),

-- Invoice 51: Laptop + Router + Mouse
(1, 10200000, 51, 1),
(2, 390000, 51, 5),
(3, 480000, 51, 4),

-- Invoice 52: Keyboard + Case
(2, 2050000, 52, 9),
(3, 320000, 52, 14),

-- Invoice 53: Monitor + Speaker
(1, 8100000, 53, 10),
(2, 1550000, 53, 12),

-- Invoice 54: Router + Charger
(2, 390000, 54, 5),
(3, 210000, 54, 13),

-- Invoice 55: Headphones + Tablet
(1, 2950000, 55, 8),
(1, 12100000, 55, 7),

-- Invoice 56: Camera + Laptop
(1, 17800000, 56, 11),
(3, 9700000, 56, 1),

-- Invoice 57: Washing Machine + Monitor
(1, 20500000, 57, 2),
(2, 8100000, 57, 10),

-- Invoice 58: Printer + Keyboard + Mouse
(1, 24800000, 58, 3),
(1, 2200000, 58, 9),
(2, 490000, 58, 4),

-- Invoice 59: Case + Stand + Router
(2, 310000, 59, 14),
(1, 830000, 59, 15),
(1, 420000, 59, 5),

-- Invoice 60: Smartphone + Speaker + Mouse
(1, 14900000, 60, 6),
(1, 1600000, 60, 12),
(3, 530000, 60, 4),

-- Invoice 61: Charger + Tablet
(2, 190000, 61, 13),
(1, 12200000, 61, 7),

-- Invoice 62: Monitor + Keyboard + Mouse + Router
(4, 8200000, 62, 10),
(1, 2300000, 62, 9),
(2, 510000, 62, 4),
(1, 410000, 62, 5);


