package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class UserDAO extends DAO {

    public boolean register(User user) {
        boolean result = false;
        String sql = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmailaddress());
            ps.setString(3, user.getPassword());

            int rows = ps.executeUpdate();
            result = (rows > 0);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email=? AND password=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("name"));
                user.setEmailaddress(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
