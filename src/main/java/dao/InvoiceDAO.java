package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Customer;
import model.Invoice;
import model.DeliveryStaff;
import model.InvoiceItem;
import model.SaleStaff;
import model.Item;

public class InvoiceDAO extends DAO {

    public List<Invoice> getInvoiceListOfItem(int itemId, String startDate, String endDate) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT " +
                    "inv.id, " +
                    "inv.date, " +
                    "inv.status, " +
                    "inv.tblCustomerid, " +
                    "inv.tblSaleStaffid, " +
                    "inv.tblDeliveryStaffid, " +
                    "item.name, "+
                    "item.description, "+
                    "ii.quantity, " +
                    "ii.unitPrice " +
                    "FROM tblInvoice inv " +
                    "JOIN tblInvoiceItem ii ON inv.id = ii.tblInvoiceid " +
                    "JOIN tblItem item ON ii.tblItemid = item.id " +
                    "WHERE ii.tblItemid = ? " +
                    "AND inv.status = 'completed' " +
                    "AND (? IS NULL OR inv.date >= ?) " +
                    "AND (? IS NULL OR inv.date <= ?) " +
                    "ORDER BY inv.date DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            ps.setString(2, startDate);
            ps.setString(3, startDate);
            ps.setString(4, endDate);
            ps.setString(5, endDate);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Invoice invoice = new Invoice();
                Customer customer = new Customer();
                SaleStaff salestaff = new SaleStaff();
                DeliveryStaff deliverystaff = new DeliveryStaff();
                InvoiceItem tii = new InvoiceItem();
                Item item = new Item();
                ArrayList<InvoiceItem> ii = new ArrayList<>();
                
                invoice.setId(rs.getInt("id"));
                invoice.setDateIssued(rs.getDate("date"));
                invoice.setStatus(rs.getString("status"));
                customer.setId(rs.getInt("tblCustomerid"));
                invoice.setC(customer);
                salestaff.setId(rs.getInt("tblSaleStaffid"));
                invoice.setSs(salestaff);
                deliverystaff.setId(rs.getInt("tblDeliveryStaffid"));
                invoice.setDs(deliverystaff);
                
                // Set item information
                item.setId(itemId);
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                tii.setI(item);
                tii.setQuantity(rs.getInt("quantity"));
                tii.setUnitPrice(rs.getDouble("unitPrice"));
                tii.setTotalPrice(rs.getInt("quantity") * rs.getDouble("unitPrice"));
                
                ii.add(tii);
                invoice.setIi(ii);
                invoices.add(invoice);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return invoices;
    }
}
