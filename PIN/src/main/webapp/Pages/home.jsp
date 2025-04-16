<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PIN - Price in Nepal | Tech Enthusiast Community</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/home.css">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="Header.jsp" />
        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <h2>Discover and Discuss Tech in Nepal with PIN</h2>
                    <p>Your go-to platform for the latest prices and information on mobile phones, laptops, and smartwatches available in Nepal.</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/devices" class="btn btn-primary">Browse Devices</a>
                        <a href="${pageContext.request.contextPath}/blog" class="btn btn-secondary">Read Blog</a>
                    </div>
                </div>
                <div class="hero-image">
                    <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Tech devices showcase">
                </div>
            </div>
        </section>
    
        <!-- Category Navigation -->
        <section class="category-nav">
            <div class="container">
                <h3>Browse By Category</h3>
                <div class="category-grid">
                    <a href="${pageContext.request.contextPath}/devices?category=mobile" class="category-card">
                        <div class="category-icon"><i class="fas fa-mobile-alt"></i></div>
                        <h4>Mobile Phones</h4>
                    </a>
                    <a href="${pageContext.request.contextPath}/devices?category=laptop" class="category-card">
                        <div class="category-icon"><i class="fas fa-laptop"></i></div>
                        <h4>Laptops</h4>
                    </a>
                    <a href="${pageContext.request.contextPath}/devices?category=smartwatch" class="category-card">
                        <div class="category-icon"><i class="fas fa-running"></i></div>
                        <h4>Smartwatches</h4>
                    </a>
                </div>
            </div>
        </section>
    
        <!-- Featured Devices -->
        <section class="featured-devices">
            <div class="container">
                <div class="section-header">
                    <h3>Featured Devices</h3>
                    <a href="${pageContext.request.contextPath}/devices" class="view-all">View All</a>
                </div>
                <div class="device-grid">
                    <c:forEach var="device" items="${featuredDevices}">
                        <div class="device-card">
                            <div class="device-image">
                                <c:choose>
                                    <c:when test="${not empty device.images}">
                                        <img src="${device.images[0].imageUrl}" alt="${device.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="${device.name}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="device-info">
                                <h4>${device.name}</h4>
                                <div class="device-meta">
                                    <span class="brand">${device.brand}</span>
                                    <span class="category">${device.type}</span>
                                </div>
                                <div class="device-price">NPR ${device.price}</div>
                                <div class="device-actions">
                                    <a href="${pageContext.request.contextPath}/devices?id=${device.deviceId}" class="btn btn-sm">View Details</a>
                                    <button class="btn-icon"><i class="far fa-heart"></i></button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    
        <!-- Popular Brands -->
<!-- Popular Brands -->
<section class="popular-brands">
    <div class="container">
        <h3>Popular Brands</h3>
        <div class="brand-grid">
            <a href="${pageContext.request.contextPath}/devices?brand=apple" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Apple">
                <span>Apple</span>
            </a>
            <a href="${pageContext.request.contextPath}/devices?brand=samsung" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Samsung">
                <span>Samsung</span>
            </a>
            <a href="${pageContext.request.contextPath}/devices?brand=xiaomi" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Xiaomi">
                <span>Xiaomi</span>
            </a>
            <a href="${pageContext.request.contextPath}/devices?brand=dell" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Dell">
                <span>Dell</span>
            </a>
            <a href="${pageContext.request.contextPath}/devices?brand=hp" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="HP">
                <span>HP</span>
            </a>
            <a href="${pageContext.request.contextPath}/devices?brand=asus" class="brand-card">
                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Asus">
                <span>Asus</span>
            </a>
        </div>
    </div>
</section>
    
        <!-- Latest Blog Posts -->
        <section class="latest-blogs">
            <div class="container">
                <div class="section-header">
                    <h3>Latest Blog Posts</h3>
                    <a href="${pageContext.request.contextPath}/blog" class="view-all">View All</a>
                </div>
                <div class="blog-grid">
                    <c:forEach var="post" items="${latestBlogPosts}" varStatus="loop">
                        <div class="blog-card">
                            <div class="blog-image">
                                <img src="${not empty post.imageUrl ? post.imageUrl : 'https://example.com'}" alt="${post.title}">
                            </div>
                            <div class="blog-content">
                                <div class="blog-meta">
                                    <span class="blog-date"><fmt:formatDate value="${post.createdAt}" pattern="MMM dd, yyyy"/></span>
                                </div>
                                <h4>${post.title}</h4>
                                <a href="${pageContext.request.contextPath}/blog?action=view&postId=${post.postId}" class="read-more">Read More</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <!-- Footer -->
        <jsp:include page="Footer.jsp" />
        <script src="../js/main.js"></script>
    </body>
    </html>