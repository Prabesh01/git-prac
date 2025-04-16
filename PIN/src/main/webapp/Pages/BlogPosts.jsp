<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/blog.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h2>PIN Blog</h2>
            <p>Stay updated with the latest tech news, reviews, and guides in Nepal</p>
        </div>
    </section>

    <!-- Blog Section -->
    <section class="blog-section">
        <div class="container">
            <div class="blog-layout">
                <!-- Main Content -->
                <div class="blog-main">
                    <!-- Featured Post (Show first post as featured if available) -->
                    <c:if test="${not empty posts}">
                        <div class="featured-post">
                            <div class="featured-image">
                                <img src="${posts[0].imageUrl != null ? posts[0].imageUrl : 'https://rev-art-v3.vercel.app/placeholder.svg'}" alt="Featured post image">
                            </div>
                            <div class="featured-content">
                                <div class="post-meta">
                                    <span class="post-category">Tech</span>
                                    <span class="post-date"><fmt:formatDate value="${posts[0].createdAt}" pattern="MMMM dd, yyyy" /></span>
                                </div>
                                <h2><c:out value="${posts[0].title}" /></h2>
                                
                                <div class="post-footer">
                                    <div class="post-author">
                                        <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Author avatar">
                                        <span>By Author</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/blogs?action=view&id=${posts[0].postId}" class="read-more">Read Full Article</a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Blog Posts Grid -->
                    <div class="blog-grid">
                        <c:forEach var="post" items="${posts}" begin="1">
                            <div class="blog-card">
                                <div class="blog-image">
                                    <img src="${post.imageUrl != null ? post.imageUrl : 'https://rev-art-v3.vercel.app/placeholder.svg'}" alt="Blog post image">
                                    <div class="post-category">Tech</div>
                                </div>
                                <div class="blog-content">
                                    <div class="post-meta">
                                        <span class="post-date"><fmt:formatDate value="${post.createdAt}" pattern="MMMM dd, yyyy" /></span>
                                        <span class="post-author">By Author</span>
                                    </div>
                                    <h3><c:out value="${post.title}" /></h3>
                                    <a href="${pageContext.request.contextPath}/blogs?action=view&id=${post.postId}" class="read-more">Read More</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/blogs?page=${currentPage - 1}" class="pagination-btn prev">
                                <i class="fas fa-chevron-left"></i> Previous
                            </a>
                        </c:if>
                        <c:if test="${currentPage <= 1}">
                            <button class="pagination-btn prev" disabled>
                                <i class="fas fa-chevron-left"></i> Previous
                            </button>
                        </c:if>

                        <div class="pagination-numbers">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="${pageContext.request.contextPath}/blogs?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                            </c:forEach>
                        </div>

                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/blogs?page=${currentPage + 1}" class="pagination-btn next">
                                Next <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                        <c:if test="${currentPage >= totalPages}">
                            <button class="pagination-btn next" disabled>
                                Next <i class="fas fa-chevron-right"></i>
                            </button>
                        </c:if>
                    </div>
                </div>

                <!-- Sidebar -->
                <aside class="blog-sidebar">
                    <!-- Search Widget -->
                    <div class="sidebar-widget search-widget">
                        <form class="search-form" action="${pageContext.request.contextPath}/blogs" method="get">
                            <input type="text" name="search" placeholder="Search blog posts...">
                            <button type="submit" aria-label="Search">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>

                    <!-- Categories Widget -->
                    <div class="sidebar-widget categories-widget">
                        <h3>Categories</h3>
                        <ul>
                            <li><a href="#">Mobile Phones <span>(24)</span></a></li>
                            <li><a href="#">Laptops <span>(18)</span></a></li>
                            <li><a href="#">Smartwatches <span>(12)</span></a></li>
                            <li><a href="#">Reviews <span>(32)</span></a></li>
                            <li><a href="#">Guides <span>(15)</span></a></li>
                            <li><a href="#">News <span>(20)</span></a></li>
                        </ul>
                    </div>

                    <!-- Popular Posts Widget -->
                    <div class="sidebar-widget popular-posts-widget">
                        <h3>Popular Posts</h3>
                        <div class="popular-posts">
                            <c:forEach var="post" items="${posts}" begin="0" end="2">
                                <div class="popular-post">
                                    <div class="post-image">
                                        <img src="${post.imageUrl != null ? post.imageUrl : 'https://rev-art-v3.vercel.app/placeholder.svg'}" alt="Popular post image">
                                    </div>
                                    <div class="post-info">
                                        <h4><a href="${pageContext.request.contextPath}/blogs?action=view&id=${post.postId}"><c:out value="${post.title}" /></a></h4>
                                        <div class="post-meta">
                                            <span class="post-date"><fmt:formatDate value="${post.createdAt}" pattern="MMMM dd, yyyy" /></span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="Footer.jsp" />
</body>
</html>