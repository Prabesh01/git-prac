<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write Blog Post | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/write-blogs.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h2>Write a Blog Post</h2>
            <p>Share your tech insights with the PIN community</p>
        </div>
    </section>

    <!-- Write Blog Section -->
    <section class="write-blog-section">
        <div class="container">
            <div class="write-blog-layout">
                <!-- Main Content -->
                <div class="write-blog-main">
                    <div class="blog-form-container">
                        <form class="blog-form" id="blog-form" action="${pageContext.request.contextPath}/blogs" method="post" enctype="multipart/form-data">
                            <!-- Title -->
                            <div class="form-group">
                                <label for="blog-title">Title *</label>
                                <input type="text" id="blog-title" name="title" placeholder="Enter a descriptive title" maxlength="255" required>
                            </div>

                            <!-- Content -->
                            <div class="form-group">
                                <label for="blog-content">Content *</label>
                                <div class="editor-toolbar">
                                    <button type="button" class="toolbar-btn" title="Bold"><i class="fas fa-bold"></i></button>
                                    <button type="button" class="toolbar-btn" title="Italic"><i class="fas fa-italic"></i></button>
                                    <button type="button" class="toolbar-btn" title="Heading 2"><i class="fas fa-heading"></i>2</button>
                                    <button type="button" class="toolbar-btn" title="Bulleted List"><i class="fas fa-list-ul"></i></button>
                                    <button type="button" class="toolbar-btn" title="Insert Link"><i class="fas fa-link"></i></button>
                                </div>
                                <textarea id="blog-content" name="content" rows="15" placeholder="Write your blog post content here..." required></textarea>
                            </div>

                            <!-- Optional Fields (Stored Separately) -->
                            <div class="form-group">
                                <label for="blog-category">Category</label>
                                <select id="blog-category" name="category">
                                    <option value="" disabled selected>Select a category</option>
                                    <option value="mobile">Mobile Phones</option>
                                    <option value="laptop">Laptops</option>
                                    <option value="smartwatch">Smartwatches</option>
                                    <option value="news">Tech News</option>
                                    <option value="review">Reviews</option>
                                    <option value="tips">Tips & Tricks</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="blog-image">Featured Image</label>
                                <div class="image-upload-container">
                                    <div class="image-preview">
                                        <img id="image-preview" src="https://via.placeholder.com/800x400?text=Featured+Image" alt="Featured image preview">
                                    </div>
                                    <div class="image-upload-controls">
                                        <input type="file" id="blog-image" name="image" accept="image/*" class="file-input">
                                        <label for="blog-image" class="file-label">
                                            <i class="fas fa-upload"></i> Choose Image
                                        </label>
                                        <p class="file-info">Recommended size: 1200 x 600 pixels. Max size: 2MB</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="form-actions">
                                <button type="button" class="btn btn-secondary" id="preview-btn">Preview</button>
                                <button type="submit" class="btn btn-primary">Publish</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Sidebar -->
                <aside class="write-blog-sidebar">
                    <div class="sidebar-widget">
                        <h3 class="widget-title">Writing Tips</h3>
                        <ul class="tips-list">
                            <li><i class="fas fa-check-circle"></i><span>Use a clear, descriptive title</span></li>
                            <li><i class="fas fa-check-circle"></i><span>Break content with headings</span></li>
                            <li><i class="fas fa-check-circle"></i><span>Include high-quality images</span></li>
                        </ul>
                    </div>
                </aside>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="Footer.jsp" />

    <script>
        // Image preview
        document.getElementById('blog-image').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    document.getElementById('image-preview').src = event.target.result;
                };
                reader.readAsDataURL(file);
            }
        });

        // Form submission
        document.getElementById('blog-form').addEventListener('submit', function(e) {
            const title = document.getElementById('blog-title').value.trim();
            const content = document.getElementById('blog-content').value.trim();
            
            if (!title || !content) {
                e.preventDefault();
                alert('Please fill in both title and content fields.');
                return;
            }
            
            // Add hidden field for action
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'create';
            this.appendChild(actionInput);
        });
    </script>
</body>
</html>