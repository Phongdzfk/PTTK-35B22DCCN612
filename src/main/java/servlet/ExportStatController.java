package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import dao.ExportStatDAO;
import model.ExportStat;

public class ExportStatController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get date parameters from ItemStatView.jsp
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Call ExportStatDAO to get statistics
        ExportStatDAO exportStatDAO = new ExportStatDAO();
        List<ExportStat> exportStats = null;
        
        if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
            exportStats = exportStatDAO.getExportStatByDate(startDate, endDate);
        } else {
        }

        // Return result to ItemStatView.jsp
        request.setAttribute("exportStats", exportStats);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        
        RequestDispatcher rd = request.getRequestDispatcher("view/ManagementStaff/ItemStatView.jsp");
        rd.forward(request, response);
    }
}
