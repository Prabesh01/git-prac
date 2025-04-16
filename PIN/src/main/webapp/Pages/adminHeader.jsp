<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Admin Header -->
<header class="admin-header">
    <div class="admin-header-left">
        <button class="sidebar-toggle" aria-label="Toggle sidebar">
            <i class="fas fa-bars"></i>
        </button>
        <div class="admin-logo">
            <h1><span class="highlight">PIN</span> Admin</h1>
        </div>
    </div>
    <div class="admin-header-right">
        <div class="admin-search">
            <input type="text" placeholder="Search...">
            <button type="button" aria-label="Search">
                <i class="fas fa-search"></i>
            </button>
        </div>
        <div class="admin-notifications">
            <button class="notification-btn" aria-label="Notifications">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">5</span>
            </button>
        </div>
        <div class="admin-user">
            <div class="admin-user-info">
                <span class="admin-user-name">Admin User</span>
                <span class="admin-user-role">Administrator</span>
            </div>
            <div class="admin-user-avatar">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Admin avatar">
            </div>
            <div class="admin-dropdown">
                <button class="admin-dropdown-toggle" aria-label="User menu">
                    <i class="fas fa-chevron-down"></i>
                </button>
                <div class="admin-dropdown-menu">
                    <a href="#" class="admin-dropdown-item">
                        <i class="fas fa-user"></i> Profile
                    </a>
                    <a href="#" class="admin-dropdown-item">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                    <div class="admin-dropdown-divider"></div>
                    <a href="login.html" class="admin-dropdown-item">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    // Admin dropdown toggle
    document.querySelector('.admin-dropdown-toggle').addEventListener('click', function(e) {
        e.stopPropagation();
        document.querySelector('.admin-dropdown-menu').classList.toggle('show');
    });
    
    // Close dropdown when clicking outside
    document.addEventListener('click', function() {
        document.querySelector('.admin-dropdown-menu').classList.remove('show');
    });
</script>