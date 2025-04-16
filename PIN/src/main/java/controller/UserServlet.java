package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;
import utils.EncryptDecrypt;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UserServlet.class.getName());
    
    private UserDAO userDAO;
    private EncryptDecrypt encryptDecrypt;
    
    public void init() {
        userDAO = new UserDAO();
        encryptDecrypt = new EncryptDecrypt();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "login-form";
        }

        switch (action) {
            case "login-form":
                // Check if user is already logged in
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("user") != null) {
                    response.sendRedirect(request.getContextPath() + "/Pages/home.jsp");
                    return;
                }
                request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
                break;
            case "register-form":
                request.getRequestDispatcher("/Pages/register.jsp").forward(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        try {
            switch (action) {
                case "login":
                    handleLogin(request, response);
                    break;
                case "register":
                    handleRegister(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing request", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        LOGGER.info("Processing login request for email: " + email);
        
        try {
            // Validate input
            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                LOGGER.warning("Login failed: Empty email or password");
                request.setAttribute("error", "Please enter both email and password");
                request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
                return;
            }
            
            User user = userDAO.getUserByEmail(email);
            if (user == null) {
                LOGGER.warning("Login failed: User not found for email: " + email);
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
                return;
            }
            
            String encryptedPassword = encryptDecrypt.encrypt(password);
            if (!user.getPasswordHash().equals(encryptedPassword)) {
                LOGGER.warning("Login failed: Invalid password for user: " + user.getUsername());
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
                return;
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
            }
            
            LOGGER.info("User logged in successfully: " + user.getUsername());
            response.sendRedirect(request.getContextPath() + "/Pages/home.jsp");
            
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database error during login", e);
            request.setAttribute("error", "An error occurred. Please try again later.");
            request.getRequestDispatcher("/Pages/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LOGGER.info("Starting user registration process");

        try {
            String username = request.getParameter("username");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            LOGGER.info("Received registration request for username: " + username);

            if (username == null || username.trim().isEmpty() ||
                fname == null || fname.trim().isEmpty() ||
                lname == null || lname.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                
                LOGGER.warning("Registration failed: Missing required fields");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required");
                return;
            }

            if (userDAO.getUserByUsername(username) != null) {
                LOGGER.warning("Registration failed: Username '" + username + "' already exists");
                response.sendError(HttpServletResponse.SC_CONFLICT, "Username already exists");
                return;
            }

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setFname(fname);
            newUser.setLname(lname);
            newUser.setEmail(email);
            String encryptedPassword = encryptDecrypt.encrypt(password);
            if (encryptedPassword == null) {
                LOGGER.severe("Failed to encrypt password");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Password encryption failed");
                return;
            }
            newUser.setPasswordHash(encryptedPassword);
            newUser.setRole("USER");

            User createdUser = userDAO.createUser(newUser);
            
            if (createdUser != null && createdUser.getUserId() > 0) {
                LOGGER.info("User successfully created with ID: " + createdUser.getUserId());
                request.getSession().setAttribute("message", "Registration successful! Please login.");
                response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
            } else {
                LOGGER.severe("Failed to create user in database");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create user");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during registration", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        try {
            User currentUser = (User) session.getAttribute("user");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (fname != null && !fname.trim().isEmpty()) {
                currentUser.setFname(fname);
            }
            if (lname != null && !lname.trim().isEmpty()) {
                currentUser.setLname(lname);
            }
            if (email != null && !email.trim().isEmpty()) {
                currentUser.setEmail(email);
            }
            if (password != null && !password.trim().isEmpty()) {
                String encryptedPassword = encryptDecrypt.encrypt(password);
                currentUser.setPasswordHash(encryptedPassword);
            }

            User updatedUser = userDAO.updateUser(currentUser);
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("User updated successfully");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update user");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating user", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        try {
            User currentUser = (User) session.getAttribute("user");
            boolean deleted = userDAO.deleteUser(currentUser.getUserId());
            
            if (deleted) {
                session.invalidate();
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("User deleted successfully");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete user");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting user", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/Pages/login.jsp");
    }
}