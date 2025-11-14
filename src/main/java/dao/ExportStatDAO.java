package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ExportStat;

public class ExportStatDAO extends DAO {

    public List<ExportStat> getExportStatByDate(String startDate, String endDate) {
        List<ExportStat> exportStats = new ArrayList<>();
        String sql = "SELECT " +
                    "i.id as itemId, " +
                    "i.name as itemName, " +
                    "i.description as itemDescription, " +
                    "i.unitPrice as unitPrice, "+
                    "COALESCE(SUM(CASE WHEN (? IS NULL OR inv.date >= ?) AND (? IS NULL OR inv.date <= ?) THEN ii.quantity ELSE 0 END), 0) as totalQuantitySold, " +
                    "COALESCE(SUM(CASE WHEN (? IS NULL OR inv.date >= ?) AND (? IS NULL OR inv.date <= ?) THEN ii.quantity * ii.unitPrice ELSE 0 END), 0) as totalRevenue, " +
                    "COUNT(DISTINCT CASE WHEN (? IS NULL OR inv.date >= ?) AND (? IS NULL OR inv.date <= ?) THEN ii.tblInvoiceid ELSE NULL END) as totalInvoices, " +
                    "COALESCE(AVG(CASE WHEN (? IS NULL OR inv.date >= ?) AND (? IS NULL OR inv.date <= ?) THEN ii.unitPrice ELSE NULL END), 0) as averagePrice " +
                    "FROM tblItem i " +
                    "LEFT JOIN tblInvoiceItem ii ON i.id = ii.tblItemid " +
                    "LEFT JOIN tblInvoice inv ON ii.tblInvoiceid = inv.id " +
                    "AND inv.status = 'completed' " +
                    "GROUP BY i.id, i.name, i.description " +
                    "ORDER BY totalRevenue DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            
            ps.setString(1, startDate);
            ps.setString(2, startDate);
            ps.setString(3, endDate);
            ps.setString(4, endDate);
            
            ps.setString(5, startDate);
            ps.setString(6, startDate);
            ps.setString(7, endDate);
            ps.setString(8, endDate);
            
            ps.setString(9, startDate);
            ps.setString(10, startDate);
            ps.setString(11, endDate);
            ps.setString(12, endDate);
            
            ps.setString(13, startDate);
            ps.setString(14, startDate);
            ps.setString(15, endDate);
            ps.setString(16, endDate);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ExportStat exportStat = new ExportStat();
                exportStat.setId(rs.getInt("itemId"));
                exportStat.setName(rs.getString("itemName"));
                exportStat.setDescription(rs.getString("itemDescription"));
                exportStat.setUnitPrice(rs.getDouble("unitPrice"));
                exportStat.setTotalQuantity(rs.getInt("totalQuantitySold"));
                exportStat.setTotalRevenue(rs.getDouble("totalRevenue"));
                exportStats.add(exportStat);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return exportStats;
    }
}
