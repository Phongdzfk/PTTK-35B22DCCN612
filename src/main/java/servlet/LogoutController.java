package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Redirect to home page
        response.sendRedirect("view/Customer/HomePageView.jsp");
    }
}
