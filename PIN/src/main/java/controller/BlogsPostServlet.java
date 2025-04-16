package controller;

import dao.BlogsPostDAO;
import dao.CommentsDAO;
import dao.LikesDAO;
import model.BlogsPost;
import model.Comments;
import java.util.List;
import java.io.File;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@WebServlet("/blogs")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
                 maxFileSize = 1024 * 1024 * 5,      // 5 MB
                 maxRequestSize = 1024 * 1024 * 5)   // 5 MB
public class BlogsPostServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final int POSTS_PER_PAGE = 6; // Number of posts per page
    private BlogsPostDAO blogsPostDAO;
    private CommentsDAO commentsDAO;
    private LikesDAO likesDAO;

    @Override
    public void init() throws ServletException {
        blogsPostDAO = new BlogsPostDAO();
        commentsDAO = new CommentsDAO();
        likesDAO = new LikesDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        // Check if user is logged in
        Object userObj = request.getSession().getAttribute("user");
        if (userObj == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please login to perform this action");
            return;
        }
        model.User user = (model.User) userObj;

        switch (action) {
            case "like":
                handleLikeAction(request, response, user);
                break;
            case "comment":
                handleCommentAction(request, response, user);
                break;
            case "create":
                handleCreatePost(request, response, user);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleLikeAction(HttpServletRequest request, HttpServletResponse response, model.User user)
            throws ServletException, IOException {
        int postId;
        try {
            postId = Integer.parseInt(request.getParameter("postId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }

        boolean hasLiked = likesDAO.hasUserLikedPost(postId, user.getUserId());
        if (hasLiked) {
            likesDAO.removeLike(postId, user.getUserId());
        } else {
            likesDAO.addLike(postId, user.getUserId());
        }

        response.sendRedirect(request.getContextPath() + "/blogs?action=view&id=" + postId);
    }

    private void handleCommentAction(HttpServletRequest request, HttpServletResponse response, model.User user)
            throws ServletException, IOException {
        int postId;
        try {
            postId = Integer.parseInt(request.getParameter("postId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }

        String content = request.getParameter("comment");
        if (content == null || content.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Comment content is required");
            return;
        }

        commentsDAO.addComment(postId, user.getUserId(), content.trim());
        response.sendRedirect(request.getContextPath() + "/blogs?action=view&id=" + postId);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewPost(request, response);
                break;
            case "list":
            default:
                listPosts(request, response);
                break;
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get pagination parameters
        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Calculate offset and limit
        List<BlogsPost> allPosts = blogsPostDAO.getAllPosts(POSTS_PER_PAGE); // Assuming DAO supports limit
        int totalPosts = blogsPostDAO.getAllPosts(-1).size(); // Get total count without limit
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        // Set attributes for JSP
        request.setAttribute("posts", allPosts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward to JSP
        request.getRequestDispatcher("/Pages/BlogPosts.jsp").forward(request, response);
    }

    private void handleCreatePost(HttpServletRequest request, HttpServletResponse response, model.User user)
            throws ServletException, IOException {
        try {
            // Get form fields
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            Part imagePart = request.getPart("image");
            
            // Validate input
            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title and content are required");
                return;
            }
            
            String imageUrl = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                // Create uploads directory if it doesn't exist
                String uploadPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                // Generate unique filename
                String fileName = UUID.randomUUID().toString() + getFileExtension(imagePart);
                String filePath = uploadPath + File.separator + fileName;
                
                // Save file
                imagePart.write(filePath);
                imageUrl = "uploads/" + fileName;
            }
            
            // Create blog post
            BlogsPost post = new BlogsPost();
            post.setUserId(user.getUserId());
            post.setTitle(title.trim());
            post.setContent(content.trim());
            post.setImageUrl(imageUrl);
            
            BlogsPost createdPost = blogsPostDAO.createPost(post);
            if (createdPost != null) {
                response.sendRedirect(request.getContextPath() + "/blogs?action=view&id=" + createdPost.getPostId());
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create post");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error creating post: " + e.getMessage());
        }
    }
    
    private String getFileExtension(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                int dotIndex = fileName.lastIndexOf('.');
                return dotIndex > 0 ? fileName.substring(dotIndex) : "";
            }
        }
        return "";
    }
    
    private void viewPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId;
        try {
            postId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid post ID");
            return;
        }

        BlogsPost post = blogsPostDAO.getPostById(postId);
        if (post == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
            return;
        }

        // Get comments for the post
        List<Comments> comments = commentsDAO.getCommentsByPostId(postId);
        int commentCount = commentsDAO.getCommentCount(postId);
        int likeCount = likesDAO.getLikeCount(postId);

        // Set attributes for JSP
        request.setAttribute("post", post);
        request.setAttribute("comments", comments);
        request.setAttribute("commentCount", commentCount);
        request.setAttribute("likeCount", likeCount);

        // Check if user has liked the post (if user is logged in)
        Object userObj = request.getSession().getAttribute("user");
        if (userObj != null) {
            model.User user = (model.User) userObj;
            boolean hasLiked = likesDAO.hasUserLikedPost(postId, user.getUserId());
            request.setAttribute("hasLiked", hasLiked);
        }

        request.getRequestDispatcher("/Pages/BlogPostDetails.jsp").forward(request, response);
    }
}