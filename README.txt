================================================================================
                    JSP SERVLET DEMO - PROJECT STRUCTURE
================================================================================

PROJECT OVERVIEW
----------------
This is a Java web application built using JSP (JavaServer Pages) and Servlets
following the MVC (Model-View-Controller) architecture pattern. The application
appears to be an E-commerce/Inventory Management System with support for
customers, staff members, invoices, and statistics.

TECHNOLOGY STACK
----------------
- Java (JSP & Servlets)
- MySQL Database
- JSTL (JSP Standard Tag Library)
- JBCrypt (for password hashing)
- MySQL Connector/J (JDBC driver)

PROJECT STRUCTURE
-----------------

JSP_Servlet_Demo/
│
├── src/
│   └── main/
│       ├── java/                          # Java source code
│       │   ├── dao/                        # Data Access Object layer
│       │   │   ├── DAO.java               # Base DAO class with database connection
│       │   │   ├── CustomerDAO.java       # Customer data operations
│       │   │   ├── ExportStatDAO.java     # Export statistics data operations
│       │   │   ├── InvoiceDAO.java        # Invoice data operations
│       │   │   ├── StaffDAO.java          # Staff data operations
│       │   │   └── UserDAO.java           # User data operations
│       │   │
│       │   ├── model/                      # Model classes (Entity/POJO)
│       │   │   ├── User.java              # Base user entity
│       │   │   ├── Customer.java          # Customer entity (extends User)
│       │   │   ├── Staff.java             # Staff entity (extends User)
│       │   │   ├── SaleStaff.java         # Sales staff entity (extends Staff)
│       │   │   ├── DeliveryStaff.java     # Delivery staff entity (extends Staff)
│       │   │   ├── Invoice.java           # Invoice entity
│       │   │   ├── InvoiceItem.java       # Invoice item entity
│       │   │   ├── Item.java              # Item/Product entity
│       │   │   └── ExportStat.java        # Export statistics entity
│       │   │
│       │   └── controller/                    # Controller layer (Servlets)
│       │       ├── LoginController.java    # Handles user login
│       │       ├── LogoutController.java   # Handles user logout
│       │       ├── CustomerController.java  # Handles customer registration
│       │       ├── InvoiceController.java   # Handles invoice operations
│       │       └── ExportStatController.java # Handles export statistics
│       │
│       ├── resources/                       # Configuration and resources
│       │   ├── db.properties               # Database configuration
│       │   ├── database_schema.sql         # Database schema SQL script
│       │   └── bg.jpg                      # Background image resource
│       │
│       └── webapp/                          # Web application root
│           ├── index.jsp                    # Application entry point
│           ├── images/                      # Static images
│           │   └── bg.jpg                  # Background image
│           │
│           ├── view/                        # JSP view pages
│           │   ├── Customer/                # Customer views
│           │   │   ├── HomePageView.jsp     # Customer home page
│           │   │   ├── login.jsp            # Login page
│           │   │   └── RegisFormView.jsp    # Registration form
│           │   │
│           │   └── ManagementStaff/         # Management staff views
│           │       ├── ManagementStaffHomeView.jsp # Management home page
│           │       ├── InvoiceView.jsp      # Invoice management view
│           │       ├── ItemStatView.jsp     # Item statistics view
│           │       └── StatView.jsp         # Statistics view
│           │
│           └── WEB-INF/                     # Web application configuration
│               ├── web.xml                  # Servlet deployment descriptor
│               └── lib/                     # External JAR libraries
│                   ├── jbcrypt-0.4.jar      # Password hashing library
│                   ├── jstl-1.2.jar         # JSP Standard Tag Library
│                   └── mysql-connector-j-8.0.31.jar # MySQL JDBC driver
│
└── build/                                   # Compiled classes (generated)
    └── classes/                             # Compiled Java bytecode

ARCHITECTURE PATTERN
--------------------
The project follows MVC (Model-View-Controller) architecture:

1. MODEL (dao/ & model/):
   - model/: Contains entity classes representing database tables
   - dao/: Contains Data Access Objects for database operations

2. VIEW (webapp/view/):
   - JSP files for user interface presentation
   - Organized by user role (Customer, ManagementStaff)

3. CONTROLLER (controller/):
   - Servlets handle HTTP requests, process business logic,
     interact with DAOs, and forward to appropriate views

KEY FEATURES
------------
1. Statistic Management:
   - Manage statistics as manager

2. Customer Registration:
   - Form validation (password confirmation, unique username/email)
   - Password visibility toggle
   - Membership number auto-generation (format: CM00001, CM00002, etc.)

3. Database Operations:
   - Transaction support for data integrity
   - Prepared statements for SQL injection prevention
   - Connection pooling through base DAO class

DATABASE STRUCTURE
------------------
The application uses MySQL database named "web_demo" with the following
main tables:
- tblUser: Base user information
- tblCustomer: Customer-specific data with membership numbers
- tblStaff: Staff information with roles
- tblSaleStaff: Sales staff details
- tblDeliveryStaff: Delivery staff details
- tblItem: Product/Item catalog
- tblInvoice: Invoice records
- tblInvoiceItem: Invoice line items
- tblSupplier: Supplier information
- tblImportBill: Import bill records
- tblImportBillItem: Import bill line items

See src/main/resources/database_schema.sql for complete schema.

SERVLET MAPPINGS
----------------
Configured in WEB-INF/web.xml:
- /login          -> LoginController
- /logout         -> LogoutController
- /customer       -> CustomerController (registration)
- /invoice        -> InvoiceController
- /exportstat     -> ExportStatController

DEPENDENCIES
------------
Required JAR files (in WEB-INF/lib/):
- mysql-connector-j-8.0.31.jar: MySQL database connectivity
- jstl-1.2.jar: JSP Standard Tag Library for JSP enhancements

SETUP INSTRUCTIONS
------------------
1. Database Setup:
   - Create MySQL database
   - Run database_schema.sql script to create tables
   - Update database connection in DAO.java or db.properties

2. Build & Deploy:
   - Compile Java source files
   - Deploy to servlet container (Tomcat, etc.)
   - Ensure all JAR dependencies are in WEB-INF/lib/

3. Configuration:
   - Update database credentials in DAO.java
   - Configure servlet mappings in web.xml if needed

NOTES
-----
- The project uses a standard Maven-like directory structure
- Password fields include show/hide toggle functionality
- Form validation includes client-side and server-side checks
- Transaction management ensures data consistency

================================================================================
                            END OF DOCUMENTATION
================================================================================

