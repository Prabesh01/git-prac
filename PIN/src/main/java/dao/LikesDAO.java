package dao;

import model.Likes;
import database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LikesDAO {
    private Connection connection;

    public LikesDAO() {
        try {
            connection = DatabaseConnection.getConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public boolean addLike(int postId, int userId) {
        // First check if a like already exists but is marked as deleted
        String checkSql = "SELECT COUNT(*) FROM Likes WHERE post_id = ? AND user_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, postId);
            checkStmt.setInt(2, userId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Like exists, update it to not deleted
                String updateSql = "UPDATE Likes SET is_deleted = false WHERE post_id = ? AND user_id = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, postId);
                    updateStmt.setInt(2, userId);
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                // Like doesn't exist, insert new one
                String insertSql = "INSERT INTO Likes (post_id, user_id) VALUES (?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, postId);
                    insertStmt.setInt(2, userId);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeLike(int postId, int userId) {
        String sql = "UPDATE Likes SET is_deleted = true WHERE post_id = ? AND user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasUserLikedPost(int postId, int userId) {
        String sql = "SELECT COUNT(*) FROM Likes WHERE post_id = ? AND user_id = ? AND is_deleted = false";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getLikeCount(int postId) {
        String sql = "SELECT COUNT(*) FROM Likes WHERE post_id = ? AND is_deleted = false";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Likes> getLikesByPostId(int postId) {
        List<Likes> likesList = new ArrayList<>();
        String sql = "SELECT * FROM Likes WHERE post_id = ? AND is_deleted = false";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Likes like = new Likes();
                like.setLikeId(rs.getInt("like_id"));
                like.setPostId(rs.getInt("post_id"));
                like.setUserId(rs.getInt("user_id"));
                like.setCreatedAt(rs.getTimestamp("created_at"));
                like.setDeleted(rs.getBoolean("is_deleted"));
                likesList.add(like);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return likesList;
    }
}
