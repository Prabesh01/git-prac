<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/login.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />

    <!-- Login Section -->
    <section class="login-section">
        <div class="container">
            <div class="auth-container">
                <div class="auth-card">
                    <div class="auth-header">
                        <h2>Login to Your Account</h2>
                    </div>
                    
                    <!-- Social Login -->
                    
                    <div class="divider">
                        <span>-</span>
                    </div>
                    
                    <!-- Login Form -->
                    <form class="auth-form" action="${pageContext.request.contextPath}/user" method="post">
                        <input type="hidden" name="action" value="login">
                        <c:if test="${not empty error}">
                            <div class="error-message">
                                ${error}
                            </div>
                        </c:if>
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-envelope"></i>
                                </span>
                                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="password-label">
                                <label for="password">Password</label>
                                <a href="#" class="forgot-password">Forgot Password?</a>
                            </div>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                                <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        
                        <div class="form-group remember-me">
                            <label class="checkbox-container">
                                <input type="checkbox" id="remember" name="remember">
                                <span class="checkmark"></span>
                                Remember me
                            </label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </form>
                    
                    <div class="auth-footer">
                        <p>Don't have an account? <a href="${pageContext.request.contextPath}/Pages/Signup.jsp">Sign Up</a></p>
                    </div>
                </div>
                
                <!-- Auth Info -->
                <div class="auth-info">
                    <div class="auth-info-content">
                        <h3>Join the PIN Community</h3>
                        <p>Get access to exclusive features when you log in:</p>
                        <ul class="feature-list">
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Find your favorite devices for easy comparison</span>
                            </li>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Receive price drop alerts for devices you're interested in</span>
                            </li>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Views reviews and share your experiences with the community</span>
                            </li>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Participate in discussions and help others make informed decisions</span>
                            </li>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Get personalized device recommendations based on your preferences</span>
                            </li>
                        </ul>
                        <div class="auth-cta">
                            <p>New to PIN?</p>
                            <a href="${pageContext.request.contextPath}/Pages/Signup.jsp" class="btn btn-outline">Create an Account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Footer -->
    <jsp:include page="Footer.jsp" />
</body>
</html>