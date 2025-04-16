package dao;

import model.BlogsPost;
import database.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;

public class BlogsPostDAO {
    private static final Logger LOGGER = Logger.getLogger(BlogsPostDAO.class.getName());

    public BlogsPost createPost(BlogsPost post) {
        String sql = "INSERT INTO Posts (user_id, title, content, imageUrl) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, post.getUserId());
            pstmt.setString(2, post.getTitle());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getImageUrl());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating post failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    post.setPostId(generatedKeys.getInt(1));
                    return post;
                } else {
                    throw new SQLException("Creating post failed, no ID obtained.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error creating post", e);
            return null;
        }
    }

    public BlogsPost getPostById(int postId) {
        String sql = "SELECT * FROM Posts WHERE post_id = ? AND is_deleted = FALSE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BlogsPost post = mapResultSetToPost(rs);
                    // Convert Markdown to HTML
                    Parser parser = Parser.builder().build();
                    HtmlRenderer renderer = HtmlRenderer.builder().build();
                    Node document = parser.parse(post.getContent());
                    String htmlContent = renderer.render(document);
                    post.setContent(htmlContent);
                    return post;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving post", e);
        }
        return null;
    }
    
    
    public List<BlogsPost> getAllPosts() {
        return getAllPosts(-1);
    }
    public List<BlogsPost> getAllPosts(int limit) {
        List<BlogsPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE is_deleted = FALSE ORDER BY created_at DESC";
        
        // Only add the LIMIT clause if limit is greater than 0
        if (limit > 0) {
            sql += " LIMIT ?";
        }
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Set the limit parameter if applicable
            if (limit > 0) {
                pstmt.setInt(1, limit); // Set the limit value
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error retrieving posts", e);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database connection error", e);
        }
        
        return posts;
    }

    public List<BlogsPost> getPostsByUserId(int userId) {
        List<BlogsPost> posts = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE user_id = ? AND is_deleted = FALSE ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving user posts", e);
        }
        return posts;
    }

    public boolean updatePost(BlogsPost post) {
        String sql = "UPDATE Posts SET title = ?, content = ?, imageUrl = ? WHERE post_id = ? AND is_deleted = FALSE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getImageUrl());
            pstmt.setInt(4, post.getPostId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error updating post", e);
            return false;
        }
    }

    public boolean deletePost(int postId) {
        String sql = "UPDATE Posts SET is_deleted = TRUE WHERE post_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error deleting post", e);
            return false;
        }
    }

    private BlogsPost mapResultSetToPost(ResultSet rs) throws SQLException {
        BlogsPost post = new BlogsPost();
        post.setPostId(rs.getInt("post_id"));
        post.setUserId(rs.getInt("user_id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        post.setDeleted(rs.getBoolean("is_deleted"));
        post.setImageUrl(rs.getString("imageUrl"));
        return post;
    }
}
