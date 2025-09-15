package com.ecommerce.dao;

import com.ecommerce.bean.Admin;
import com.ecommerce.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {
    
    // Using the same placeholder hashing logic for consistency.
    // In a real app, this would be a shared, secure utility.
    private String hashPassword(String password) {
        return "hashed_" + password;
    }
    
    public Admin validateAdmin(String email, String password) {
        Admin admin = null;
        String sql = "SELECT * FROM admins WHERE email = ? AND password_hash = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, hashPassword(password));
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
}