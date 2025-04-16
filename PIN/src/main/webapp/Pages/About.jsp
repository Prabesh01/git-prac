<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | PIN - Price in Nepal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
     <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/common.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Css/about.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="Header.jsp" />
    <!-- Hero Section -->
    <section class="about-hero">
        <div class="hero-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
        </div>
        <div class="container">
            <div class="about-hero-content" data-aos="fade-up">
                <span class="hero-subtitle">Our Story</span>
                <h1>About <span class="highlight">PIN</span></h1>
                <p>Empowering Nepalese consumers with accurate information to make informed tech purchasing decisions.</p>
                <div class="hero-scroll-indicator">
                    <div class="mouse">
                        <div class="wheel"></div>
                    </div>
                    <div class="arrow">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission Section -->
    <section class="mission-section">
        <div class="container">
            <div class="mission-grid">
                <div class="mission-content" data-aos="fade-right" data-aos-delay="100">
                    <span class="section-tag">Our Purpose</span>
                    <h2>Our Mission</h2>
                    <p class="mission-statement">To provide the most accurate, up-to-date, and comprehensive information about tech devices available in Nepal, helping consumers make informed purchasing decisions.</p>
                    <p>At PIN, we believe that access to reliable information is essential for consumers to make smart choices in an increasingly complex tech market. We're committed to transparency, accuracy, and user empowerment.</p>
                    <div class="mission-values">
                        <div class="value-item" data-aos="fade-up" data-aos-delay="200">
                            <div class="value-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="value-content">
                                <h3>Accuracy</h3>
                                <p>We verify all information through multiple sources to ensure the prices and specifications we publish are accurate.</p>
                            </div>
                        </div>
                        <div class="value-item" data-aos="fade-up" data-aos-delay="300">
                            <div class="value-icon">
                                <i class="fas fa-sync-alt"></i>
                            </div>
                            <div class="value-content">
                                <h3>Up-to-date</h3>
                                <p>Our team constantly monitors the market to provide the most current information about devices and their prices.</p>
                            </div>
                        </div>
                        <div class="value-item" data-aos="fade-up" data-aos-delay="400">
                            <div class="value-icon">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <div class="value-content">
                                <h3>Unbiased</h3>
                                <p>We maintain editorial independence and provide unbiased information without favoring any brand or retailer.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mission-image" data-aos="fade-left" data-aos-delay="200">
                    <div class="image-wrapper">
                        <img src="https://arthubs-rev.netlify.app/placeholder.svg" alt="PIN team working on device research">
                        <div class="image-decoration"></div>
                    </div>
                    <div class="mission-stats">
                        <div class="mission-stat">
                            <span class="stat-number">5+</span>
                            <span class="stat-text">Years of Experience</span>
                        </div>
                        <div class="mission-stat">
                            <span class="stat-number">100%</span>
                            <span class="stat-text">Commitment</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

   

    <!-- Team Section -->
    <section class="team-section">
        <div class="section-bg-pattern"></div>
        <div class="container">
            <div class="section-header" data-aos="fade-up">
                <span class="section-tag">The People</span>
                <h2>Meet Our Team</h2>
                <p>The passionate individuals behind PIN who work tirelessly to bring you accurate information</p>
            </div>
            <div class="team-grid">
                <div class="team-member" data-aos="fade-up" data-aos-delay="100">
                    <div class="member-image">
                        <img src="https://arthubs-rev.netlify.app/placeholder.svg" alt="Founder & CEO">
                        <div class="member-social">
                            <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                    <div class="member-info">
                        <h3>Aarav Sharma</h3>
                        <p class="member-role">Founder & CEO</p>
                        <p class="member-bio">A tech enthusiast with a background in computer engineering, Aarav founded PIN to solve the problem of unreliable tech pricing information in Nepal.</p>
                    </div>
                </div>
                <div class="team-member" data-aos="fade-up" data-aos-delay="200">
                    <div class="member-image">
                        <img src="https://arthubs-rev.netlify.app/placeholder.svg" alt="Head of Content">
                        <div class="member-social">
                            <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                    <div class="member-info">
                        <h3>Priya Thapa</h3>
                        <p class="member-role">Head of Content</p>
                        <p class="member-bio">With a journalism background and passion for technology, Priya leads our content team, ensuring all information is accurate, comprehensive, and easy to understand.</p>
                    </div>
                </div>
                <div class="team-member" data-aos="fade-up" data-aos-delay="300">
                    <div class="member-image">
                        <img src="https://arthubs-rev.netlify.app/placeholder.svg" alt="Lead Developer">
                        <div class="member-social">
                            <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" aria-label="GitHub"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                    <div class="member-info">
                        <h3>Rohan Poudel</h3>
                        <p class="member-role">Lead Developer</p>
                        <p class="member-bio">A full-stack developer with expertise in web applications, Rohan is responsible for building and maintaining the PIN platform, ensuring a seamless user experience.</p>
                    </div>
                </div>
                <div class="team-member" data-aos="fade-up" data-aos-delay="400">
                    <div class="member-image">
                        <img src="https://arthubs-rev.netlify.app/placeholder.svg" alt="Data Analyst">
                        <div class="member-social">
                            <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                    <div class="member-info">
                        <h3>Sita Gurung</h3>
                        <p class="member-role">Data Analyst</p>
                        <p class="member-bio">With a background in statistics and market research, Sita analyzes pricing trends and ensures that our database is always up-to-date with the latest information.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="cta-bg-shapes">
            <div class="cta-shape cta-shape-1"></div>
            <div class="cta-shape cta-shape-2"></div>
        </div>
        <div class="container">
            <div class="cta-content" data-aos="fade-up">
                <span class="section-tag">Join Us</span>
                <h2>Join the PIN Community</h2>
                <p>Be part of Nepal's growing tech community. Create an account to save your favorite devices, participate in discussions, and get personalized recommendations.</p>
                <div class="cta-buttons">
                    <a href="signup.html" class="btn btn-primary btn-lg">
                        <span>Sign Up Now</span>
                        <i class="fas fa-arrow-right"></i>
                    </a>
                    <a href="contact.html" class="btn btn-outline btn-lg">Contact Us</a>
                </div>
                <div class="cta-features">
                    <div class="cta-feature">
                        <i class="fas fa-check-circle"></i>
                        <span>Free Account</span>
                    </div>
                    <div class="cta-feature">
                        <i class="fas fa-check-circle"></i>
                        <span>Personalized Alerts</span>
                    </div>
                    <div class="cta-feature">
                        <i class="fas fa-check-circle"></i>
                        <span>Save Favorites</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Footer -->
    <jsp:include page="Footer.jsp" />

    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script src="../js/main.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true,
            offset: 100
        });
        
        // Testimonial Slider
        const testimonialSlides = document.querySelectorAll('.testimonial-slide');
        const testimonialDots = document.querySelectorAll('.testimonial-dot');
        const prevButton = document.querySelector('.testimonial-prev');
        const nextButton = document.querySelector('.testimonial-next');
        let currentSlide = 0;
        
        function showSlide(index) {
            // Hide all slides
            testimonialSlides.forEach(slide => {
                slide.classList.remove('active');
            });
            
            // Remove active class from all dots
            testimonialDots.forEach(dot => {
                dot.classList.remove('active');
            });
            
            // Show the current slide and activate the corresponding dot
            testimonialSlides[index].classList.add('active');
            testimonialDots[index].classList.add('active');
            
            // Update current slide index
            currentSlide = index;
        }
        
        // Next slide
        nextButton.addEventListener('click', function() {
            let nextIndex = currentSlide + 1;
            if (nextIndex >= testimonialSlides.length) {
                nextIndex = 0;
            }
            showSlide(nextIndex);
        });
        
        // Previous slide
        prevButton.addEventListener('click', function() {
            let prevIndex = currentSlide - 1;
            if (prevIndex < 0) {
                prevIndex = testimonialSlides.length - 1;
            }
            showSlide(prevIndex);
        });
        
        // Dot navigation
        testimonialDots.forEach(dot => {
            dot.addEventListener('click', function() {
                const index = parseInt(this.getAttribute('data-index'));
                showSlide(index);
            });
        });
        
        // Auto-advance slides every 5 seconds
        setInterval(function() {
            let nextIndex = currentSlide + 1;
            if (nextIndex >= testimonialSlides.length) {
                nextIndex = 0;
            }
            showSlide(nextIndex);
        }, 5000);
        
        // Animate stats when they come into view
        const statNumbers = document.querySelectorAll('.stat-number');
        let animated = false;
        
        function animateStats() {
            if (animated) return;
            
            const statsSection = document.querySelector('.stats-section');
            const sectionPosition = statsSection.getBoundingClientRect().top;
            const screenPosition = window.innerHeight / 1.3;
            
            if (sectionPosition < screenPosition) {
                animated = true;
                
                statNumbers.forEach(stat => {
                    const targetNumber = parseInt(stat.getAttribute('data-count'));
                    let currentNumber = 0;
                    const increment = Math.ceil(targetNumber / 100); // Adjust for animation speed
                    const duration = 2000; // 2 seconds
                    const interval = duration / (targetNumber / increment);
                    
                    const counter = setInterval(function() {
                        currentNumber += increment;
                        
                        if (currentNumber >= targetNumber) {
                            currentNumber = targetNumber;
                            clearInterval(counter);
                        }
                        
                        // Format number with commas
                        stat.textContent = currentNumber.toLocaleString();
                    }, interval);
                });
            }
        }
        
        // Check if stats are in view on scroll
        window.addEventListener('scroll', animateStats);
        // Also check on page load
        window.addEventListener('load', animateStats);
    </script>
</body>
</html>