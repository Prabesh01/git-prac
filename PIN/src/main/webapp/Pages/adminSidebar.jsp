<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Admin Sidebar -->
<aside class="admin-sidebar">
    <nav class="admin-nav">
        <ul class="admin-nav-list">
            <li class="admin-nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="admin-nav-item ${param.activePage == 'devices' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/devices" class="admin-nav-link">
                    <i class="fas fa-mobile-alt"></i>
                    <span>Devices</span>
                </a>
            </li>
            <li class="admin-nav-item ${param.activePage == 'blogs' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard?action=blogs" class="admin-nav-link">
                    <i class="fas fa-newspaper"></i>
                    <span>Blog Posts</span>
                </a>
            </li>
            <li class="admin-nav-item ${param.activePage == 'users' ? 'active' : ''}">
                <a href="#" class="admin-nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="admin-sidebar-footer">
        <a href="${pageContext.request.contextPath}/home" class="admin-nav-link">
            <i class="fas fa-external-link-alt"></i>
            <span>View Website</span>
        </a>
    </div>
</aside>

<script>
    // Sidebar toggle
    document.querySelector('.sidebar-toggle').addEventListener('click', function() {
        document.querySelector('.admin-sidebar').classList.toggle('collapsed');
        document.querySelector('.admin-content').classList.toggle('expanded');
    });
</script>