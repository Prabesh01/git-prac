<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Devices | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/devices.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h2>Browse Devices</h2>
            <p>Explore the latest mobile phones, laptops, and smartwatches available in Nepal</p>
        </div>
    </section>

    <!-- Devices Section -->
    <section class="devices-section">
        <div class="container">
            <div class="devices-layout">
                <!-- Filters Sidebar -->
                <aside class="filters-sidebar">
                    <div class="filter-group">
                        <h3>Categories</h3>
                        <div class="filter-options">
                            <c:forEach items="${categories}" var="category">
                                <label class="filter-option">
                                    <input type="checkbox" name="category" value="${category.value}" ${fn:contains(selectedCategories, category.value) ? 'checked' : ''}>
                                    <span>${category.name}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="filter-group">
                        <h3>Brands</h3>
                        <div class="filter-options">
                            <c:forEach items="${brands}" var="brand">
                                <label class="filter-option">
                                    <input type="checkbox" name="brand" value="${brand.value}" ${fn:contains(selectedBrands, brand.value) ? 'checked' : ''}>
                                    <span>${brand.name}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="filter-group">
                        <h3>Price Range</h3>
                        <div class="price-range">
                            <input type="range" id="price-slider" min="0" max="500000" step="5000" value="250000">
                            <div class="price-inputs">
                                <input type="number" id="min-price" placeholder="Min" min="0" max="500000">
                                <span>-</span>
                                <input type="number" id="max-price" placeholder="Max" min="0" max="500000">
                            </div>
                        </div>
                    </div>

                    <button class="btn btn-primary apply-filters">Apply Filters</button>
                    <button class="btn btn-secondary clear-filters">Clear All</button>
                </aside>

                <!-- Devices Content -->
                <div class="devices-content">
                    <div class="devices-header">
                        <div class="devices-count">
                            <p>Showing <span>${fn:length(devices)}</span> devices</p>
                        </div>
                        <div class="devices-sort">
                            <label for="sort-by">Sort by:</label>
                            <select id="sort-by">
                                <option value="newest" ${param['sort-by'] == 'newest' ? 'selected' : ''}>Newest First</option>
                                <option value="price-low" ${param['sort-by'] == 'price-low' ? 'selected' : ''}>Price: Low to High</option>
                                <option value="price-high" ${param['sort-by'] == 'price-high' ? 'selected' : ''}>Price: High to Low</option>
                            </select>
                        </div>
                        <div class="view-toggle">
                            <button class="view-btn grid-view active" aria-label="Grid view">
                                <i class="fas fa-th"></i>
                            </button>
                            <button class="view-btn list-view" aria-label="List view">
                                <i class="fas fa-list"></i>
                            </button>
                        </div>
                    </div>

                    <div class="devices-grid">
                        <c:forEach items="${devices}" var="device">
                            <div class="device-card">
                                <div class="device-image">
                                    <img src="${not empty device.images && device.images.size() > 0 ? device.images[0].imageUrl : '/images/placeholder.jpg'}" alt="${device.name}">
                                </div>
                                <div class="device-info">
                                    <h4>${device.name}</h4>
                                    <div class="device-meta">
                                        <span class="brand">${device.brand}</span>
                                        <span class="category">${device.category}</span>
                                    </div>
                                    <div class="device-price">NPR <fmt:formatNumber value="${device.price}" pattern="#,###"/></div>
                                    <div class="device-actions">
                                        <a href="${pageContext.request.contextPath}/devices?id=${device.id}" class="btn btn-sm">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <button class="pagination-btn prev" ${currentPage == 1 ? 'disabled' : ''}>
                            <i class="fas fa-chevron-left"></i> Previous
                        </button>
                        <div class="pagination-numbers">
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <c:choose>
                                    <c:when test="${pageNum == currentPage}">
                                        <a href="#" class="active">${pageNum}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/devices?page=${pageNum}">${pageNum}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <button class="pagination-btn next" ${currentPage == totalPages ? 'disabled' : ''}>
                            Next <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="Footer.jsp" />

        <!-- JavaScript for Filters and Sorting -->
        <script>
            document.querySelector('.apply-filters').addEventListener('click', function() {
                submitFilters();
            });

            document.querySelector('.clear-filters').addEventListener('click', function() {
                document.querySelectorAll('input[name="category"], input[name="brand"]').forEach(input => input.checked = false);
                document.getElementById('min-price').value = '';
                document.getElementById('max-price').value = '';
                document.getElementById('price-slider').value = 250000;
                submitFilters();
            });

            document.getElementById('sort-by').addEventListener('change', function() {
                submitFilters();
            });

            function submitFilters() {
                const form = document.createElement('form');
                form.method = 'GET';
                form.action = '${pageContext.request.contextPath}/devices';

                document.querySelectorAll('input[name="category"]:checked').forEach(input => {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = 'category';
                    hidden.value = input.value;
                    form.appendChild(hidden);
                });

                document.querySelectorAll('input[name="brand"]:checked').forEach(input => {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = 'brand';
                    hidden.value = input.value;
                    form.appendChild(hidden);
                });

                const minPrice = document.getElementById('min-price').value;
                if (minPrice) {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = 'min-price';
                    hidden.value = minPrice;
                    form.appendChild(hidden);
                }

                const maxPrice = document.getElementById('max-price').value;
                if (maxPrice) {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = 'max-price';
                    hidden.value = maxPrice;
                    form.appendChild(hidden);
                }

                const sortBy = document.getElementById('sort-by').value;
                const hiddenSort = document.createElement('input');
                hiddenSort.type = 'hidden';
                hiddenSort.name = 'sort-by';
                hiddenSort.value = sortBy;
                form.appendChild(hiddenSort);

                document.body.appendChild(form);
                form.submit();
            }

            const priceSlider = document.getElementById('price-slider');
            const minPriceInput = document.getElementById('min-price');
            const maxPriceInput = document.getElementById('max-price');

            priceSlider.addEventListener('input', function() {
                maxPriceInput.value = priceSlider.value;
            });
        </script>
</body>
</html>