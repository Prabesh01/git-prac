package controller;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dao.DeviceDAO;
import dao.LikesDAO;
import dao.BlogsPostDAO;
import dao.CommentsDAO;
import model.User;
import model.Device;
import model.BlogsPost;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AdminDashboardServlet.class.getName());
    
    private UserDAO userDAO;
    private DeviceDAO deviceDAO;
    private BlogsPostDAO blogsPostDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
        deviceDAO = new DeviceDAO();
        blogsPostDAO = new BlogsPostDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if ("blogs".equals(action)) {
                handleBlogsAction(request, response);
                return;
            } else if ("write-blog".equals(action)) {
                request.getRequestDispatcher("/Pages/WriteBlogs.jsp").forward(request, response);
                return;
            }
            
            // Get total counts
            List<User> allUsers = userDAO.getAllUsers();
            int totalUsers = allUsers.size();
            
            List<Device> allDevices = deviceDAO.getAllDevices();
            int totalDevices = allDevices.size();
            
            List<BlogsPost> allPosts = blogsPostDAO.getAllPosts();
            int totalPosts = allPosts.size();
            
            // Get recent users (limit to 4)
            List<User> recentUsers = allUsers.subList(0, Math.min(4, allUsers.size()));
            
            // Set attributes for JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalDevices", totalDevices);
            request.setAttribute("totalPosts", totalPosts);
            request.setAttribute("recentUsers", recentUsers);
            
            // Forward to the dashboard JSP
            request.getRequestDispatcher("/Pages/AdminDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in AdminDashboardServlet", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
        }
    }
    
    private void handleBlogsAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all blog posts with their engagement metrics
            List<BlogsPost> allPosts = blogsPostDAO.getAllPosts();
            
            // Create CommentsDAO and LikesDAO instances
            CommentsDAO commentsDAO = new CommentsDAO();
            LikesDAO likesDAO = new LikesDAO();
            
            // For each post, get the comment and like counts
            for (BlogsPost post : allPosts) {
                int commentCount = commentsDAO.getCommentCount(post.getPostId());
                int likeCount = likesDAO.getLikeCount(post.getPostId());
                
                // Set these counts as request attributes with unique keys for each post
                request.setAttribute("commentCount_" + post.getPostId(), commentCount);
                request.setAttribute("likeCount_" + post.getPostId(), likeCount);
            }
            
            // Set the posts list as a request attribute
            request.setAttribute("blogPosts", allPosts);
            
            // Forward to the admin blogs JSP
            request.getRequestDispatcher("/Pages/AdminBlogs.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error handling blogs action", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
