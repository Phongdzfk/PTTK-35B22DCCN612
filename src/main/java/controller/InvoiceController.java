package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Invoice;
import model.ExportStat;
import dao.InvoiceDAO;

public class InvoiceController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters from ItemStatView.jsp
        String exportStatJson = request.getParameter("exportStat");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        
        if (exportStatJson != null && !exportStatJson.isEmpty()) {
            try {
                
                exportStatJson = exportStatJson.replaceAll("[{}\"]", "");
                String[] pairs = exportStatJson.split(",");
                
                ExportStat exportStat = new ExportStat();
                
                for (String pair : pairs) {
                    String[] keyValue = pair.split(":");
                    if (keyValue.length == 2) {
                        String key = keyValue[0].trim();
                        String value = keyValue[1].trim();
                        
                        try {
                            switch (key) {
                                case "itemId":
                                    exportStat.setId(Integer.parseInt(value));
                                    break;
                                case "itemName":
                                    exportStat.setName(value);
                                    break;
                                case "totalQuantity":
                                    exportStat.setTotalQuantity(Integer.parseInt(value));
                                    break;
                                case "totalRevenue":
                                    exportStat.setTotalRevenue(Double.parseDouble(value));
                                    break;
                            }
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                        }
                    }
                }
                int itemId = exportStat.getId();
                
                InvoiceDAO invoiceDAO = new InvoiceDAO();
                
                List<Invoice> invoices = invoiceDAO.getInvoiceListOfItem(itemId, startDate, endDate);
                
                // Return result to InvoiceView.jsp
                request.setAttribute("invoices", invoices);
                request.setAttribute("exportStat", exportStat);
                request.setAttribute("startDate", startDate);
                request.setAttribute("endDate", endDate);
                
            } catch (Exception e) {
                request.setAttribute("error", "Invalid item ID");
            }
        } else {
            request.setAttribute("error", "Item ID is required");
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("view/ManagementStaff/InvoiceView.jsp");
        rd.forward(request, response);
    }
    
}
