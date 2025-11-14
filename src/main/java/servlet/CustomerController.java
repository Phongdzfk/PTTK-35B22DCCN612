package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.CustomerDAO;
import model.Customer;

public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters from registration form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullname = request.getParameter("fullname");
        String phonenumber = request.getParameter("phonenumber");
        String emailaddress = request.getParameter("emailaddress");
        String address = request.getParameter("address");

        CustomerDAO customerDAO = new CustomerDAO();
        
        // Validate password
        String passwordError = "";
        
        if (!password.equals(confirmPassword)) {
            passwordError = "Passwords do not match";
        }
        if (!passwordError.isEmpty()) {
            request.setAttribute("passwordError", passwordError);
            request.setAttribute("username", username);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phonenumber", phonenumber);
            request.setAttribute("emailaddress", emailaddress);
            request.setAttribute("address", address);
            RequestDispatcher rd = request.getRequestDispatcher("view/Customer/RegisFormView.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Create Customer object
        Customer customer = new Customer();
        customer.setUsername(username);
        customer.setPassword(password);
        customer.setFullname(fullname);
        customer.setPhonenumber(phonenumber);
        customer.setEmailaddress(emailaddress);
        customer.setAddress(address);

        boolean result = customerDAO.saveRegisterInfo(customer);

        // Return result to RegisFormView.jsp
        if (result) {
            String successMessage = "Registration successful! Your membership number is: " + customer.getMembershipNumber();
            response.sendRedirect("view/Customer/HomePageView.jsp?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));
        } else {
            request.setAttribute("usernameError", "Your username or email already exists, please try again with a different username or email.");
            request.setAttribute("username", username);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phonenumber", phonenumber);
            request.setAttribute("emailaddress", emailaddress);
            request.setAttribute("address", address);
            RequestDispatcher rd = request.getRequestDispatcher("view/Customer/RegisFormView.jsp");
            rd.forward(request, response);
        }
    }
}
