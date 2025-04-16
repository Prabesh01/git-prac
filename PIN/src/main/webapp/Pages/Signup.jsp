<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="../Css/common.css">
    <link rel="stylesheet" href="../Css/signup.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />

    <!-- Signup Section -->
    <section class="signup-section">
        <div class="container">
            <div class="auth-container">
                <!-- Auth Info -->
                <div class="auth-info">
                    <div class="auth-info-content">
                        <h3>Join the PIN Community</h3>
                        <p>Create an account to access exclusive features:</p>
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
                            <p>Already have an account?</p>
                            <a href="${pageContext.request.contextPath}/Pages/login.jsp" class="btn btn-outline">Login</a>
                        </div>
                    </div>
                </div>
                
                <div class="auth-card">
                    <div class="auth-header">
                        <h2>Create Your Account</h2>
                    </div>
                    
                    <div class="divider">
                        <span>-</span>
                    </div>
                    
                    <!-- Signup Form -->
                    <form class="auth-form" action="${pageContext.request.contextPath}/user" method="post">
                        <input type="hidden" name="action" value="register">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="first-name">First Name</label>
                                <div class="input-group">
                                    <span class="input-icon">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <input type="text" id="first-name" name="fname" placeholder="First name" value="janak" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="last-name">Last Name</label>
                                <div class="input-group">
                                    <span class="input-icon">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <input type="text" id="last-name" name="lname" placeholder="Last name" value="Devkota" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-envelope"></i>
                                </span>
                                <input type="email" id="email" name="email" placeholder="Enter your email" value="rev@gmail.com" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="username">Username</label>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-at"></i>
                                </span>
                                <input type="text" id="username" name="username" placeholder="Choose a username"value="revDev" required>
                            </div>
                            <div class="input-hint">Username must be between 3-20 characters and can only contain letters, numbers, and underscores.</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" id="password" name="password" placeholder="Create a password" value="Rev20214321@@##$$" required>
                                <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="password-strength">
                                <div class="strength-meter">
                                    <div class="strength-segment"></div>
                                    <div class="strength-segment"></div>
                                    <div class="strength-segment"></div>
                                    <div class="strength-segment"></div>
                                </div>
                                <div class="strength-text">Password strength: <span>Weak</span></div>
                            </div>
                        
                        <div class="form-group">
                            <label for="confirm-password">Confirm Password</label>
                            <div class="input-group">
                                <span class="input-icon">
                                    <i class="fas fa-lock"></i>
                                </span>
                                <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password" value="Rev20214321@@##$$" required>
                                <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Create Account</button>
                    </form>
                    
                    <div class="auth-footer">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/Pages/login.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Footer -->
    <jsp:include page="Footer.jsp" />
</body>
</html>