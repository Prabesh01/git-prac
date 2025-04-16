package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

import database.DatabaseConnection;
import model.User;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    
    public User createUser(User user) throws SQLException, ClassNotFoundException {
        LOGGER.info("Attempting to create new user: " + user.getUsername());
        String sql = "INSERT INTO Users (username, fname, lname, email, password_hash, role, active) VALUES (?, ?, ?, ?, ?, ?, true)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getFname());
            pstmt.setString(3, user.getLname());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPasswordHash());
            pstmt.setString(6, user.getRole());
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.info("Database insert operation completed. Affected rows: " + affectedRows);
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setUserId(rs.getInt(1));
                        LOGGER.info("User created successfully with ID: " + user.getUserId());
                    } else {
                        LOGGER.warning("Failed to retrieve generated user ID");
                    }
                }
            } else {
                LOGGER.warning("No rows affected when creating user");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user in database", e);
            throw e;
        }
        return user;
    }
    
    public User getUserById(int userId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Users WHERE user_id = ? AND is_deleted = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }
    
    public User getUserByUsername(String username) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Users WHERE username = ? AND is_deleted = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }
    
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE is_deleted = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        }
        return users;
    }
    
    public User updateUser(User user) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Users SET username = ?, fname = ?, lname = ?, email = ?, password_hash = ?, role = ?, active = ? WHERE user_id = ? AND is_deleted = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getFname());
            pstmt.setString(3, user.getLname());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPasswordHash());
            pstmt.setString(6, user.getRole());
            pstmt.setInt(7, user.getUserId());
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                return getUserById(user.getUserId());
            }
            return null;
        }
    }
    
    public boolean deleteUser(int userId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Users SET is_deleted = true WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM Users WHERE email = ? AND is_deleted = false";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }
    
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setFname(rs.getString("fname"));
        user.setLname(rs.getString("lname"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRole(rs.getString("role"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setDeleted(rs.getBoolean("is_deleted"));
        user.setActive(rs.getBoolean("active"));
        return user;
    }
}
