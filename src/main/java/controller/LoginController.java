package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.CustomerDAO;
import dao.StaffDAO;
import model.Customer;
import model.Staff;

public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Try to login as Staff first
        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.login(username, password);
        
        if (staff != null) {
            // Staff login successful
            HttpSession session = request.getSession();
            session.setAttribute("user", staff);
            session.setAttribute("userType", "staff");
            session.setAttribute("role", staff.getRole());
            
            // Redirect based on role
            if ("management".equals(staff.getRole())) {
                response.sendRedirect("view/ManagementStaff/ManagementStaffHomeView.jsp");
            } else {
                response.sendRedirect("view/Customer/HomePageView.jsp");
            }
            return;
        }

        // Login failed
        request.setAttribute("error", "Invalid username or password!");
        RequestDispatcher rd = request.getRequestDispatcher("view/Customer/login.jsp");
        rd.forward(request, response);
    }
}
