package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Staff;

public class StaffDAO extends DAO {

    public Staff login(String username, String password) {
        Staff staff = null;
        String sql = "SELECT u.id, u.username, u.password, u.fullname, u.phonenumber, u.emailaddress, u.address, " +
                    "s.role " +
                    "FROM tblUser u " +
                    "JOIN tblStaff s ON u.id = s.tblUserid " +
                    "WHERE u.username = ? AND u.password = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                staff = new Staff();
                staff.setId(rs.getInt("id"));
                staff.setUsername(rs.getString("username"));
                staff.setPassword(rs.getString("password"));
                staff.setFullname(rs.getString("fullname"));
                staff.setPhonenumber(rs.getString("phonenumber"));
                staff.setEmailaddress(rs.getString("emailaddress"));
                staff.setAddress(rs.getString("address"));
                staff.setRole(rs.getString("role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return staff;
    }
}
