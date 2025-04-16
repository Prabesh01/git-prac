<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${device.name} - PIN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/device-details.css">
</head>
<body>
    <jsp:include page="Header.jsp" />
    
    <main class="device-details">
        <div class="container">
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/devices" class="btn btn-link">
                    <i class="fas fa-arrow-left"></i> Back to Devices
                </a>
            </div>
            
            <div class="device-content">
                <div class="device-gallery">
                    <div class="main-image">
                        <c:choose>
                            <c:when test="${not empty device.images}">
                                <img src="${device.images[0].imageUrl}" alt="${device.name}" id="mainImage">
                                <img src="${device.images[1].imageUrl}" alt="${device.name}" id="mainImage">
                            </c:when>
                            <c:otherwise>
                                <img src="https://rev-art-v3.vercel.app/placeholder.svg" alt="${device.name}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="image-thumbnails">
                        <c:forEach var="image" items="${device.images}" varStatus="status">
                            <div class="thumbnail ${status.index == 0 ? 'active' : ''}">
                                <img src="${image.imageUrl}" alt="${device.name}" 
                                     onclick="updateMainImage('${image.imageUrl}', this)">
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="device-info">
                    <h1 class="device-name">${device.name}</h1>
                    <div class="device-meta">
                        <span class="brand">${device.brand}</span>
                        <span class="category">${device.type}</span>
                    </div>
                    <div class="device-price">NPR ${device.price}</div>
                    
                    <div class="device-specs">
                        <h2>Specifications</h2>
                        <div class="specs-grid">
                            <div class="spec-item">
                                <span class="spec-label">Brand</span>
                                <span class="spec-value">${device.brand}</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Category</span>
                                <span class="spec-value">${device.type}</span>
                            </div>
                            <div class="spec-item">
                                <span class="spec-label">Release Date</span>
                                <span class="spec-value">
                                    <fmt:formatDate value="${device.releaseDate}" pattern="MMM dd, yyyy"/>
                                </span>
                            </div>
                            
                            <!-- Performance Specs -->
                            <c:if test="${not empty performance}">
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-desktop"></i> OS</span>
                                    <span class="spec-value">${performance['os']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-microchip"></i> CPU</span>
                                    <span class="spec-value">${performance['cpu']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-memory"></i> Chipset</span>
                                    <span class="spec-value">${performance['chipset']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-hdd"></i> Storage</span>
                                    <span class="spec-value">${performance['storage']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-gamepad"></i> GPU</span>
                                    <span class="spec-value">${performance['gpu']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-memory"></i> RAM</span>
                                    <span class="spec-value">${performance['ram']}</span>
                                </div>
                            </c:if>
                            
                            <!-- Connectivity Specs -->
                            <c:if test="${not empty connectivity}">
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fab fa-bluetooth-b"></i> Bluetooth</span>
                                    <span class="spec-value">${connectivity['bluetooth']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-wifi"></i> Wi-Fi</span>
                                    <span class="spec-value">${connectivity['wlan']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-plug"></i> Port</span>
                                    <span class="spec-value">${connectivity['port']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-broadcast-tower"></i> NFC</span>
                                    <span class="spec-value">${connectivity['nfc']}</span>
                                </div>
                            </c:if>
                            
                            <!-- Design and Display Specs -->
                            <c:if test="${not empty design_display}">
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-tv"></i> Display Type</span>
                                    <span class="spec-value">${design_display['display_type']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-mobile-alt"></i> Build</span>
                                    <span class="spec-value">${design_display['build']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-weight-hanging"></i> Weight</span>
                                    <span class="spec-value">${design_display['weight']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-expand"></i> Screen Size</span>
                                    <span class="spec-value">${design_display['screen_size']}</span>
                                </div>
                            </c:if>
                            
                            <!-- Camera Specs -->
                            <c:if test="${not empty camera}">
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-camera"></i> Main Camera</span>
                                    <span class="spec-value">${camera['main_camera']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-camera-retro"></i> Selfie Camera</span>
                                    <span class="spec-value">${camera['selfie_camera']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-video"></i> Video</span>
                                    <span class="spec-value">${camera['video']}</span>
                                </div>
                            </c:if>
                            
                            <!-- Battery Specs -->
                            <c:if test="${not empty battery}">
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-battery-full"></i> Battery Type</span>
                                    <span class="spec-value">${battery['battery_type']}</span>
                                </div>
                                <div class="spec-item">
                                    <span class="spec-label"><i class="fas fa-bolt"></i> Charging</span>
                                    <span class="spec-value">${battery['charging']}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="Footer.jsp" />
    
    <script>
    function updateMainImage(imageUrl, thumbnail) {
        const mainImages = document.querySelectorAll('.main-image img');
        const thumbnails = document.querySelectorAll('.thumbnail');
        
        // Find the index of the clicked thumbnail
        let currentIndex = Array.from(thumbnails).findIndex(thumb => thumb.contains(thumbnail));
        
        // Set the first main image to the clicked image
        mainImages[0].src = imageUrl;
        
        // Set the second main image to the next image (or first if at the end)
        let nextIndex = (currentIndex + 1) % thumbnails.length;
        mainImages[1].src = thumbnails[nextIndex].querySelector('img').src;
        
        // Update active thumbnail
        thumbnails.forEach(thumb => thumb.classList.remove('active'));
        thumbnail.parentElement.classList.add('active');
    }
    </script>
</body>
</html>