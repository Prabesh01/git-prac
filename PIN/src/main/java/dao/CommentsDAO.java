package dao;

import model.Comments;
import database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentsDAO {
    private Connection connection;

    public CommentsDAO() {
        try {
            connection = DatabaseConnection.getConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public boolean addComment(int postId, int userId, String content) {
        String sql = "INSERT INTO Comments (post_id, user_id, content) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            stmt.setInt(2, userId);
            stmt.setString(3, content);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteComment(int commentId) {
        String sql = "UPDATE Comments SET is_deleted = true WHERE comment_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Comments getCommentById(int commentId) {
        String sql = "SELECT * FROM Comments WHERE comment_id = ? AND is_deleted = false";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToComment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Comments> getCommentsByPostId(int postId) {
        List<Comments> commentsList = new ArrayList<>();
        String sql = "SELECT * FROM Comments WHERE post_id = ? AND is_deleted = false ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                commentsList.add(mapResultSetToComment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentsList;
    }

    public List<Comments> getCommentsByUserId(int userId) {
        List<Comments> commentsList = new ArrayList<>();
        String sql = "SELECT * FROM Comments WHERE user_id = ? AND is_deleted = false ORDER BY created_at DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                commentsList.add(mapResultSetToComment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentsList;
    }

    public int getCommentCount(int postId) {
        String sql = "SELECT COUNT(*) FROM Comments WHERE post_id = ? AND is_deleted = false";
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

    private Comments mapResultSetToComment(ResultSet rs) throws SQLException {
        Comments comment = new Comments();
        comment.setCommentId(rs.getInt("comment_id"));
        comment.setPostId(rs.getInt("post_id"));
        comment.setUserId(rs.getInt("user_id"));
        comment.setContent(rs.getString("content"));
        comment.setCreatedAt(rs.getTimestamp("created_at"));
        comment.setDeleted(rs.getBoolean("is_deleted"));
        return comment;
    }
}
