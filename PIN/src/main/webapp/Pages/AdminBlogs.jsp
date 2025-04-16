<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Management | PIN Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/admin-blogs.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="adminHeader.jsp" />
    <!-- Main Content -->
    <div class="admin-container">
        <!-- Sidebar -->
        <jsp:include page="adminSidebar.jsp" />

        <!-- Main Content Area -->
        <main class="admin-main">
                    <div class="admin-quick-actions">
                        <a href="${pageContext.request.contextPath}/admin/dashboard?action=write-blog" class="admin-quick-action">
                            <i class="fas fa-edit"></i>
                            <span>Write Blog</span>
                        </a>
                    </div>
            <!-- Blog Posts Table -->
            <div class="data-table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="selectAll">
                            </th>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Date</th>
                            <th>Comments</th>
                            <th>Likes</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${blogPosts}" var="post">
                            <tr>
                                <td>
                                    <input type="checkbox" class="post-select" data-id="${post.postId}">
                                </td>
                                <td>${post.postId}</td>
                                <td class="post-title">
                                    <a href="#" class="view-post" data-id="${post.postId}">${post.title}</a>
                                </td>
                                <td>${post.userId}</td>
                                <td><fmt:formatDate value="${post.createdAt}" pattern="MMM dd, yyyy"/></td>
                                <td>
                                    <span class="badge">${requestScope["commentCount_".concat(post.postId)]}</span>
                                    <button class="btn-icon view-comments" data-id="${post.postId}" title="View Comments">
                                        <i class="fas fa-comments"></i>
                                    </button>
                                </td>
                                <td>
                                    <span class="badge">${requestScope["likeCount_".concat(post.postId)]}</span>
                                </td>
                                <td>
                                    <span class="status-badge ${post.deleted ? 'deleted' : 'active'}">
                                        ${post.deleted ? 'Deleted' : 'Active'}
                                    </span>
                                </td>
                                <td class="actions">
                                    <c:choose>
                                        <c:when test="${post.deleted}">
                                            <button class="btn-icon restore-post" data-id="${post.postId}" title="Restore Post">
                                                <i class="fas fa-undo"></i>
                                            </button>
                                            <button class="btn-icon delete-permanent" data-id="${post.postId}" title="Delete Permanently">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn-icon edit-post" data-id="${post.postId}" title="Edit Post">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn-icon delete-post" data-id="${post.postId}" title="Delete Post">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <button class="pagination-btn ${currentPage == 1 ? 'disabled' : ''}" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard?action=blogs&page=${currentPage - 1}'" ${currentPage == 1 ? 'disabled' : ''}>
                    <i class="fas fa-chevron-left"></i>
                </button>
                
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <button class="pagination-btn active">${pageNum}</button>
                        </c:when>
                        <c:when test="${(pageNum <= 3) || (pageNum >= totalPages-2) || (pageNum >= currentPage-1 && pageNum <= currentPage+1)}">
                            <button class="pagination-btn" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard?action=blogs&page=${pageNum}'">${pageNum}</button>
                        </c:when>
                        <c:when test="${pageNum == 4 && currentPage > 5}">
                            <span class="pagination-ellipsis">...</span>
                        </c:when>
                        <c:when test="${pageNum == totalPages-3 && currentPage < totalPages-4}">
                            <span class="pagination-ellipsis">...</span>
                        </c:when>
                    </c:choose>
                </c:forEach>
                
                <button class="pagination-btn ${currentPage == totalPages ? 'disabled' : ''}" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard?action=blogs&page=${currentPage + 1}'" ${currentPage == totalPages ? 'disabled' : ''}>
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </main>
    </div>

    <!-- Add/Edit Post Modal -->
    <div class="modal" id="postModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Add New Post</h3>
                <button class="close-modal" aria-label="Close modal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <form id="postForm">
                    <input type="hidden" id="postId" value="">
                    <div class="form-group">
                        <label for="postTitle">Title</label>
                        <input type="text" id="postTitle" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="postContent">Content</label>
                        <div class="editor-toolbar">
                            <button type="button" class="editor-btn" title="Bold">
                                <i class="fas fa-bold"></i>
                            </button>
                            <button type="button" class="editor-btn" title="Italic">
                                <i class="fas fa-italic"></i>
                            </button>
                            <button type="button" class="editor-btn" title="Heading">
                                <i class="fas fa-heading"></i>
                            </button>
                            <button type="button" class="editor-btn" title="List">
                                <i class="fas fa-list-ul"></i>
                            </button>
                            <button type="button" class="editor-btn" title="Link">
                                <i class="fas fa-link"></i>
                            </button>
                            <button type="button" class="editor-btn" title="Image">
                                <i class="fas fa-image"></i>
                            </button>
                        </div>
                        <textarea id="postContent" name="content" rows="15" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="postAuthor">Author</label>
                        <select id="postAuthor" name="user_id" required>
                            <c:forEach items="${users}" var="user">
                                <option value="${user.userId}">${user.userName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn btn-outline" id="cancelPost">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="savePost">Save Post</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- View Comments Modal -->
    <div class="modal" id="commentsModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Comments for: <span id="commentPostTitle"></span></h3>
                <button class="close-modal" aria-label="Close modal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="comments-filter">
                    <input type="text" placeholder="Search comments...">
                    <select>
                        <option value="newest">Newest First</option>
                        <option value="oldest">Oldest First</option>
                    </select>
                </div>
                <div class="comments-list">
                    <c:forEach items="${postComments}" var="comment">
                        <div class="comment-item">
                            <div class="comment-header">
                                <div class="comment-user">
                                    <strong>${comment.userName}</strong>
                                    <span class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="MMM dd, yyyy"/></span>
                                </div>
                                <div class="comment-actions">
                                    <button class="btn-icon delete-comment" data-id="${comment.commentId}" title="Delete Comment">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="comment-content">
                                <p>${comment.content}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty postComments}">
                        <p class="no-comments">No comments yet.</p>
                    </c:if>
                </div>
                <div class="modal-pagination">
                    <button class="pagination-btn" disabled>
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <button class="pagination-btn active">1</button>
                    <button class="pagination-btn">2</button>
                    <button class="pagination-btn">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal" id="confirmModal">
        <div class="modal-content modal-sm">
            <div class="modal-header">
                <h3 id="confirmTitle">Confirm Action</h3>
                <button class="close-modal" aria-label="Close modal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <p id="confirmMessage">Are you sure you want to perform this action?</p>
                <div class="form-actions">
                    <button type="button" class="btn btn-outline" id="cancelAction">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmAction">Confirm</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay"></div>
</body>
</html>