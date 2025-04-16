package dao;

import model.DeviceImage;
import database.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeviceImageDAO {
    private static final Logger LOGGER = Logger.getLogger(DeviceImageDAO.class.getName());

    public DeviceImage createDeviceImage(DeviceImage deviceImage) {
        String sql = "INSERT INTO DeviceImages (device_id, image_url) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, deviceImage.getDeviceId());
            pstmt.setString(2, deviceImage.getImageUrl());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating device image failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    deviceImage.setImageId(generatedKeys.getInt(1));
                    return deviceImage;
                } else {
                    throw new SQLException("Creating device image failed, no ID obtained.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating device image", e);
            return null;
        }
    }

    public DeviceImage getDeviceImageById(int imageId) {
        String sql = "SELECT * FROM DeviceImages WHERE image_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, imageId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDeviceImage(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving device image", e);
        }
        return null;
    }

    public List<DeviceImage> getImagesByDeviceId(int deviceId) {
        List<DeviceImage> images = new ArrayList<>();
        String sql = "SELECT * FROM DeviceImages WHERE device_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, deviceId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    images.add(mapResultSetToDeviceImage(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving device images", e);
        }
        return images;
    }

    public boolean updateDeviceImage(DeviceImage deviceImage) {
        String sql = "UPDATE DeviceImages SET device_id = ?, image_url = ? WHERE image_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, deviceImage.getDeviceId());
            pstmt.setString(2, deviceImage.getImageUrl());
            pstmt.setInt(3, deviceImage.getImageId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating device image", e);
            return false;
        }
    }

    public boolean deleteDeviceImage(int imageId) {
        String sql = "DELETE FROM DeviceImages WHERE image_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, imageId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting device image", e);
            return false;
        }
    }

    public boolean deleteAllDeviceImages(int deviceId) {
        String sql = "DELETE FROM DeviceImages WHERE device_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, deviceId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting device images", e);
            return false;
        }
    }

    private DeviceImage mapResultSetToDeviceImage(ResultSet rs) throws SQLException {
        DeviceImage deviceImage = new DeviceImage();
        deviceImage.setImageId(rs.getInt("image_id"));
        deviceImage.setDeviceId(rs.getInt("device_id"));
        deviceImage.setImageUrl(rs.getString("image_url"));
        deviceImage.setCreatedAt(rs.getTimestamp("created_at"));
        return deviceImage;
    }
}