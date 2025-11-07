// Function to handle horizontal scrolling of carousels
function scrollCarousel(carouselId, scrollAmount) {
    // Get the element of the carousel using its ID
    const carousel = document.getElementById(carouselId);
    
    // Check if the carousel element exists
    if (carousel) {
        // scrollLeft property sets or returns the number of pixels an element's content 
        // has been scrolled to the left.
        // We add the scrollAmount (e.g., +300 for right, -300 for left) to the current scroll position.
        carousel.scrollLeft += scrollAmount;
    }
}

// Note: In a real application, you would also likely add event listeners
// for the main trailer play button or individual movie items.
// E.g., document.querySelector('.play-button').addEventListener('click', () => { /* open trailer video */ });

// Main trailer video play/pause controls
document.addEventListener('DOMContentLoaded', function() {
    const video = document.querySelector('.trailer-video');
    const playPauseButton = document.getElementById('play-pause-button');
    const playIcon = playPauseButton.querySelector('i');
    const playOverlay = document.querySelector('.play-overlay');

    // Start video automatically (muted)
    video.play().catch(error => {
        console.log('Auto-play prevented:', error);
    });

    // Play/Pause functionality
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

    // Optional: Hide overlay when video is playing, show when paused
    video.addEventListener('play', function() {
        playOverlay.style.opacity = '0';
    });

    video.addEventListener('pause', function() {
        playOverlay.style.opacity = '1';
    });

    // Show overlay on hover
    playOverlay.addEventListener('mouseenter', function() {
        playOverlay.style.opacity = '1';
    });

    // Hide overlay when not hovering (if video is playing)
    playOverlay.addEventListener('mouseleave', function() {
        if (!video.paused) {
            playOverlay.style.opacity = '0';
        }
    });
});