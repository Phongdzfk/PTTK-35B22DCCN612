package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Customer;

public class CustomerDAO extends DAO {

    public boolean saveRegisterInfo(Customer customer) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement userStmt = null;
        PreparedStatement customerStmt = null;
        PreparedStatement membershipStmt = null;
        ResultSet checkRs = null;
        ResultSet membershipRs = null;
        
        try {
            conn = getConnection();      
            beginTransaction(conn);
            
            // Generate membership number
            String membershipNumber = "CM00001";
            String membershipSql = "SELECT MAX(membershipNumber) FROM tblCustomer WHERE membershipNumber LIKE 'CM%'";
            membershipStmt = conn.prepareStatement(membershipSql);
            membershipRs = membershipStmt.executeQuery();
            if (membershipRs.next()) {
                String maxMembershipNumber = membershipRs.getString(1);
                if (maxMembershipNumber != null && maxMembershipNumber.startsWith("CM")) {
                    String numericPart = maxMembershipNumber.substring(2);
                    try {
                        int nextNumber = Integer.parseInt(numericPart) + 1;
                        membershipNumber = "CM" + String.format("%05d", nextNumber);
                    } catch (NumberFormatException e) {
                        membershipNumber = "CM00001";
                    }
                }
            }
            customer.setMembershipNumber(membershipNumber);
            
            // Insert into tblUser
            String userSql = "INSERT INTO tblUser (username, password, fullname, phonenumber, emailaddress, address) VALUES (?, ?, ?, ?, ?, ?)";
            userStmt = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, customer.getUsername());
            userStmt.setString(2, customer.getPassword());
            userStmt.setString(3, customer.getFullname());
            userStmt.setString(4, customer.getPhonenumber());
            userStmt.setString(5, customer.getEmailaddress());
            userStmt.setString(6, customer.getAddress());
            
            int userRows = userStmt.executeUpdate();
            if (userRows > 0) {
                // Get the generated user ID
                try (ResultSet generatedKeys = userStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int userId = generatedKeys.getInt(1);
                        
                        // Insert into tblCustomer
                        String customerSql = "INSERT INTO tblCustomer (tblUserid, membershipNumber) VALUES (?, ?)";
                        customerStmt = conn.prepareStatement(customerSql);
                        customerStmt.setInt(1, userId);
                        customerStmt.setString(2, membershipNumber);
                        
                        int customerRows = customerStmt.executeUpdate();
                        if (customerRows > 0) {
                            commitTransaction(conn);
                            result = true;
                        } else {
                            rollbackTransaction(conn);
                        }
                    }
                }
            } else {
                rollbackTransaction(conn);
            }
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    rollbackTransaction(conn);
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (checkRs != null) checkRs.close();
                if (membershipRs != null) membershipRs.close();
                if (checkStmt != null) checkStmt.close();
                if (userStmt != null) userStmt.close();
                if (customerStmt != null) customerStmt.close();
                if (membershipStmt != null) membershipStmt.close();
                closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return result;
    }
}
