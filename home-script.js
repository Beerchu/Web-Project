// home-script.js
// SİNEMA HOMEPAGE NİHAİ JAVASCRIPT KODU

// =========================================================
// 1. CAROUSEL KAYDIRMA FONKSİYONU
// Yatay film/kampanya listelerini kaydırmak için kullanılır.
// =========================================================

/**
 * Scrolls the designated carousel element horizontally.
 * @param {string} carouselId - The ID of the carousel container to scroll.
 * @param {number} scrollAmount - The distance in pixels to scroll (positive for right, negative for left).
 */
function scrollCarousel(carouselId, scrollAmount) {
    const carousel = document.getElementById(carouselId);
    
    // If the carousel exists, we scroll it
    if (carousel) {
        carousel.scrollLeft += scrollAmount;
    }
}


// =========================================================
// 2. KULLANICI MENÜSÜ DROPDOWN FONKSİYONLARI
// Hamburger menüye tıklandığında açılır menüyü gösterir/gizler.
// =========================================================

/**
 * Toggles the visibility of the user dropdown menu (Sign In, Sign Up, Cart).
 */
function toggleDropdown() {
    // Dropdown içeriğini seçer
    const dropdown = document.getElementById("userDropdown");
    
    // show-dropdown sınıfını ekleyerek/kaldırarak menüyü gösterir/gizler
    dropdown.classList.toggle("show-dropdown");
}

/**
 * Closes the dropdown menu when a click occurs outside of the menu button.
 * @param {Event} event - The click event.
 */
window.onclick = function(event) {
    // Tıklanan elementin hamburger butonu veya içindeki ikon olup olmadığını kontrol et
    if (!event.target.matches('.menu-button') && !event.target.matches('.menu-button i')) {
        const dropdown = document.getElementById("userDropdown");
        
        // Eğer menü görünür durumdaysa, kapat
        if (dropdown && dropdown.classList.contains('show-dropdown')) {
            dropdown.classList.remove('show-dropdown');
        }
    }
}


// =========================================================
// 3. VİDEO OYNATMA VE KONTROL FONKSİYONLARI
// Sayfa yüklendiğinde video oynatmayı ve play/pause kontrollerini yönetir.
// =========================================================

document.addEventListener('DOMContentLoaded', function() {
    const video = document.querySelector('.trailer-video');
    const playPauseButton = document.getElementById('play-pause-button');
    const playIcon = playPauseButton ? playPauseButton.querySelector('i') : null;
    const playOverlay = document.querySelector('.play-overlay');

    // Video ve kontrol elementlerinin varlığını kontrol et
    if (!video || !playPauseButton || !playIcon || !playOverlay) {
        // Video traileri olmayan diğer sayfalarda (About, Contact) bu kısmı atla
        return; 
    }

    // Start video automatically (tarayıcının otomatik oynatma kısıtlamalarını yönetir)
    video.play().catch(error => {
        console.warn('Auto-play prevented (muted required):', error);
    });

    // Play/Pause the trailer on the main page
    playPauseButton.addEventListener('click', function(e) {
        e.preventDefault();
        
        if (video.paused) {
            video.play();
            playIcon.className = 'fas fa-pause';
        } else {
            video.pause();
            playIcon.className = 'fas fa-play';
        }
    });

    // Update icon when video ends (for looping)
    video.addEventListener('ended', function() {
        playIcon.className = 'fas fa-play';
    });

    // Hide the pause/play button when video is playing, show when paused
    video.addEventListener('play', function() {
        playOverlay.style.opacity = '0';
    });

    video.addEventListener('pause', function() {
        playOverlay.style.opacity = '1';
    });

    // Show pause/play button on hover
    playOverlay.addEventListener('mouseenter', function() {
        playOverlay.style.opacity = '1';
    });

    // Hide play/pause button when not hovering 
    playOverlay.addEventListener('mouseleave', function() {
        if (!video.paused) {
            playOverlay.style.opacity = '0';
        }
    });
});