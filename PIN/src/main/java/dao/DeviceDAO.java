package dao;

import model.Device;
import org.json.JSONObject;
import database.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeviceDAO {
    private static final Logger LOGGER = Logger.getLogger(DeviceDAO.class.getName());

    public Device createDevice(Device device) {
        String sql = "INSERT INTO Devices (type, name, brand, price, release_date, about, provider, specs) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, device.getType());
            pstmt.setString(2, device.getName());
            pstmt.setString(3, device.getBrand());
            pstmt.setBigDecimal(4, device.getPrice());
            pstmt.setDate(5, device.getReleaseDate());
            pstmt.setString(6, device.getAbout());
            pstmt.setString(7, device.getProvider());
            pstmt.setString(8, device.getSpecs().toString());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating device failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    device.setDeviceId(generatedKeys.getInt(1));
                    return device;
                } else {
                    throw new SQLException("Creating device failed, no ID obtained.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating device", e);
            return null;
        }
    }

    public Device getDeviceById(int deviceId) {
        String sql = "SELECT * FROM Devices WHERE device_id = ? AND is_deleted = FALSE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, deviceId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDevice(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving device", e);
        }
        return null;
    }

    public List<Device> getAllDevices() {
        return getAllDevices(-1);
    }

    public List<Device> getAllDevices(int limit) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM Devices WHERE is_deleted = FALSE ORDER BY created_at DESC";
        if (limit > 0) {
            sql += " LIMIT ?";
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            if (limit > 0) {
                pstmt.setInt(1, limit);
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    devices.add(mapResultSetToDevice(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving devices", e);
        }
        return devices;
    }

    public List<Device> getFilteredDevices(String[] categories, String[] brands, BigDecimal minPrice,
                                          BigDecimal maxPrice, String sortBy, int page, int pageSize) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Devices WHERE is_deleted = FALSE");
        List<Object> params = new ArrayList<>();

        // Apply category filter
        if (categories != null && categories.length > 0) {
            sql.append(" AND type IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append(i == 0 ? "?" : ", ?");
                params.add(categories[i]);
            }
            sql.append(")");
        }

        // Apply brand filter
        if (brands != null && brands.length > 0) {
            sql.append(" AND brand IN (");
            for (int i = 0; i < brands.length; i++) {
                sql.append(i == 0 ? "?" : ", ?");
                params.add(brands[i]);
            }
            sql.append(")");
        }

        // Apply price range filter
        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        // Apply sorting
        if (sortBy != null) {
            switch (sortBy) {
                case "price-low":
                    sql.append(" ORDER BY price ASC");
                    break;
                case "price-high":
                    sql.append(" ORDER BY price DESC");
                    break;
                case "newest":
                default:
                    sql.append(" ORDER BY created_at DESC");
                    break;
            }
        } else {
            sql.append(" ORDER BY created_at DESC");
        }

        // Apply pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        List<Device> devices = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    devices.add(mapResultSetToDevice(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving filtered devices", e);
        }
        return devices;
    }

    public int getTotalDeviceCount(String[] categories, String[] brands, BigDecimal minPrice, BigDecimal maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Devices WHERE is_deleted = FALSE");
        List<Object> params = new ArrayList<>();

        if (categories != null && categories.length > 0) {
            sql.append(" AND type IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append(i == 0 ? "?" : ", ?");
                params.add(categories[i]);
            }
            sql.append(")");
        }

        if (brands != null && brands.length > 0) {
            sql.append(" AND brand IN (");
            for (int i = 0; i < brands.length; i++) {
                sql.append(i == 0 ? "?" : ", ?");
                params.add(brands[i]);
            }
            sql.append(")");
        }

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error counting devices", e);
        }
        return 0;
    }

    public boolean updateDevice(Device device) {
        String sql = "UPDATE Devices SET type = ?, name = ?, brand = ?, price = ?, release_date = ?, " +
                     "about = ?, provider = ?, specs = ? WHERE device_id = ? AND is_deleted = FALSE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, device.getType());
            pstmt.setString(2, device.getName());
            pstmt.setString(3, device.getBrand());
            pstmt.setBigDecimal(4, device.getPrice());
            pstmt.setDate(5, device.getReleaseDate());
            pstmt.setString(6, device.getAbout());
            pstmt.setString(7, device.getProvider());
            pstmt.setString(8, device.getSpecs().toString());
            pstmt.setInt(9, device.getDeviceId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating device", e);
            return false;
        }
    }

    public boolean deleteDevice(int deviceId) {
        String sql = "UPDATE Devices SET is_deleted = TRUE WHERE device_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, deviceId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting device", e);
            return false;
        }
    }

    private Device mapResultSetToDevice(ResultSet rs) throws SQLException {
        Device device = new Device();
        device.setDeviceId(rs.getInt("device_id"));
        device.setType(rs.getString("type"));
        device.setName(rs.getString("name"));
        device.setBrand(rs.getString("brand"));
        device.setPrice(rs.getBigDecimal("price"));
        device.setReleaseDate(rs.getDate("release_date"));
        device.setAbout(rs.getString("about"));
        device.setProvider(rs.getString("provider"));
        device.setCreatedAt(rs.getTimestamp("created_at"));
        device.setDeleted(rs.getBoolean("is_deleted"));
        device.setSpecs(new JSONObject(rs.getString("specs")));
        return device;
    }
}