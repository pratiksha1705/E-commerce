package com.ecommerce.dao;

import com.ecommerce.bean.User;
import com.ecommerce.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class UserDao {

    /**
     * This is a placeholder for a real password hashing function.
     * In a production application, you MUST use a strong hashing library like jBCrypt.
     * @param password The plain-text password.
     * @return A hashed version of the password.
     */
    private String hashPassword(String password) {
        // IMPORTANT: This is NOT secure. Replace with a real hashing algorithm.
        // Example with jBCrypt: return BCrypt.hashpw(password, BCrypt.gensalt());
        return "hashed_" + password;
    }

    /**
     * Registers a new user in the database.
     * @param user The User object containing registration details.
     * @return true if registration is successful, false otherwise.
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password_hash, phone) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            // Hash the password before storing it
            stmt.setString(3, hashPassword(user.getPassword_hash()));
            stmt.setString(4, user.getPhone());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            // This can happen if the email is already in use (UNIQUE constraint)
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validates a user's credentials against the database.
     * @param email The user's email.
     * @param password The user's plain-text password.
     * @return A User object if credentials are valid, otherwise null.
     */
    public User validateUser(String email, String password) {
        User user = null;
        // Using PreparedStatement prevents SQL Injection 
        String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            // Hash the input password to compare with the stored hash
            stmt.setString(2, hashPassword(password));

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    
    // Add this new method inside your UserDao.java class
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT id, name, email, phone FROM users ORDER BY name";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    
    // Add this method to UserDao.java
    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}