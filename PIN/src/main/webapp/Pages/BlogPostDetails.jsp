<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${post.title}" /> | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/blog-post-details.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="/Pages/Header.jsp" />

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <div class="container">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/blogs">Blog</a></li>
                <li><c:out value="${post.title}" /></li>
            </ul>
        </div>
    </div>

    <!-- Blog Post Section -->
    <section class="blog-post-section">
        <div class="container">
            <div class="blog-post-layout">
                <!-- Main Content -->
                <div class="blog-post-main">
                    <!-- Post Header -->
                    <div class="post-header">
                        <div class="post-meta">
                            <span class="post-category">Tech</span>
                            <span class="post-date">
                                <fmt:formatDate value="${post.createdAt}" pattern="MMMM dd, yyyy" />
                            </span>
                        </div>
                        <h1><c:out value="${post.title}" /></h1>
                        <div class="post-author">
                            <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="Author avatar">
                            <div class="author-info">
                                <h3>TechGuru</h3>
                                <p>Senior Tech Writer</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Featured Image -->
                    <c:if test="${not empty post.imageUrl}">
                        <div class="post-featured-image">
                            <img src="${post.imageUrl}" alt="${post.title}">
                        </div>
                    </c:if>
                    
                    <!-- Post Content -->
                    <div class="post-content">
                        ${post.content} <!-- Render HTML directly -->
                    </div>

                    <!-- Like Actions -->
                    <div class="post-actions">
                        <div class="like-section">
                            <form action="${pageContext.request.contextPath}/blogs?action=like" method="post" class="like-form">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <button type="submit" class="like-button ${hasLiked ? 'active' : ''}" aria-label="Like post">
                                    <i class="${hasLiked ? 'fas' : 'far'} fa-heart"></i>
                                    <span class="like-count">${likeCount}</span>
                                </button>
                            </form>
                        </div>
                        <div class="share-section">
                            <button class="share-button" aria-label="Share post">
                                <i class="fas fa-share-alt"></i>
                                <span>Share</span>
                            </button>
                        </div>
                    </div>

                    <!-- Comments Section -->
                    <div class="comments-section">
                        <h2>Comments (${commentCount})</h2>
                        <c:if test="${not empty sessionScope.user}">
                            <div class="comment-form-container">
                                <h3>Leave a Comment</h3>
                                <form class="comment-form" action="${pageContext.request.contextPath}/blogs?action=comment" method="post">
                                    <input type="hidden" name="postId" value="${post.postId}">
                                    <div class="form-group">
                                        <label for="comment">Comment *</label>
                                        <textarea id="comment" name="comment" rows="5" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Post Comment</button>
                                </form>
                            </div>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <div class="login-prompt">
                                <p>Please <a href="${pageContext.request.contextPath}/user?action=login-form">login</a> to leave a comment.</p>
                            </div>
                        </c:if>
                        <div class="comments-list">
                            <c:choose>
                                <c:when test="${not empty comments}">
                                    <c:forEach var="comment" items="${comments}">
                                        <div class="comment">
                                            <div class="comment-content">
                                                <div class="comment-header">
                                                    <h4>User #${comment.userId}</h4>
                                                    <span class="comment-date">
                                                        <fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy 'at' h:mm a" />
                                                    </span>
                                                </div>
                                                <div class="comment-text">
                                                    <p><c:out value="${comment.content}" /></p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>No comments yet. Be the first to comment!</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <aside class="blog-sidebar">
                    <div class="sidebar-widget search-widget">
                        <form class="search-form" action="${pageContext.request.contextPath}/blogs" method="get">
                            <input type="text" name="search" placeholder="Search blog posts...">
                            <button type="submit" aria-label="Search">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="sidebar-widget categories-widget">
                        <h3>Categories</h3>
                        <ul>
                            <li><a href="#">Mobile Phones <span>(24)</span></a></li>
                            <li><a href="#">Laptops <span>(18)</span></a></li>
                            <li><a href="#">Smartwatches <span>(12)</span></a></li>
                        </ul>
                    </div>
                </aside>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="/Pages/Footer.jsp" />
</body>
</html>