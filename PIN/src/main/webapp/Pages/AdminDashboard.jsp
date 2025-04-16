<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/admin-dashboard.css">
</head>
<body class="admin-body">
    <!-- Admin Header -->
   <jsp:include page="adminHeader.jsp" />

    <!-- Admin Layout -->
    <div class="admin-layout">
        <!-- Admin Sidebar -->
    <jsp:include page="adminSidebar.jsp" />

        <!-- Admin Content -->
        <main class="admin-content">
            <div class="admin-content-header">
                <h2>Dashboard</h2>
                <div class="admin-breadcrumb">
                    <a href="admin-dashboard.html">Admin</a>
                    <span class="admin-breadcrumb-separator">/</span>
                    <span>Dashboard</span>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="admin-stats">
                <div class="admin-stat-card">
                    <div class="admin-stat-icon users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="admin-stat-info">
                        <h3>Total Users</h3>
                        <div class="admin-stat-value">${totalUsers}</div>
                        <div class="admin-stat-change">
                            <i class="fas fa-users"></i> Total Registered Users
                        </div>
                    </div>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-icon devices">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <div class="admin-stat-info">
                        <h3>Total Devices</h3>
                        <div class="admin-stat-value">${totalDevices}</div>
                        <div class="admin-stat-change">
                            <i class="fas fa-mobile-alt"></i> Total Listed Devices
                        </div>
                    </div>
                </div>
                <div class="admin-stat-card">
                    <div class="admin-stat-icon posts">
                        <i class="fas fa-newspaper"></i>
                    </div>
                    <div class="admin-stat-info">
                        <h3>Blog Posts</h3>
                        <div class="admin-stat-value">${totalPosts}</div>
                        <div class="admin-stat-change">
                            <i class="fas fa-newspaper"></i> Total Blog Posts
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions and Recent Users -->
            <div class="admin-bottom-grid">
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h3>Quick Actions</h3>
                    </div>
                    <div class="admin-quick-actions">
                        <a href="${pageContext.request.contextPath}/admin/devices" class="admin-quick-action">
                            <i class="fas fa-plus"></i>
                            <span>Add Device</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard?action=write-blog" class="admin-quick-action">
                            <i class="fas fa-edit"></i>
                            <span>Write Blog</span>
                        </a>
                        <a href="#" class="admin-quick-action">
                            <i class="fas fa-user-plus"></i>
                            <span>Add User</span>
                        </a>
                    </div>
                </div>
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h3>Recent Users</h3>
                        <div class="admin-card-actions">
                            <button class="admin-card-action-btn" aria-label="Refresh">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                            <button class="admin-card-action-btn" aria-label="More options">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                        </div>
                    </div>
                    <div class="admin-user-list">
                        <c:forEach items="${recentUsers}" var="user">
                            <div class="admin-user-item">
                                <div class="admin-user-item-avatar">
                                    <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="User avatar">
                                </div>
                                <div class="admin-user-item-info">
                                    <div class="admin-user-item-name">${user.username}</div>
                                    <div class="admin-user-item-email">${user.email}</div>
                                </div>
                                <div class="admin-user-item-status ${user.active ? 'active' : 'inactive'}">
                                    ${user.active ? 'Active' : 'Inactive'}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="admin-card-footer">
                        <a href="#" class="admin-link">View All Users</a>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Sidebar toggle
        document.querySelector('.sidebar-toggle').addEventListener('click', function() {
            document.querySelector('.admin-sidebar').classList.toggle('collapsed');
            document.querySelector('.admin-content').classList.toggle('expanded');
        });
        
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
</body>
</html>