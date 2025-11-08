// This function lets us scroll the selections left and right
function scrollCarousel(carouselId, scrollAmount) {
    const carousel = document.getElementById(carouselId);
    
    //If the selection aka carousel exists, we scroll it
    if (carousel) {
        carousel.scrollLeft += scrollAmount;
    }
}

// Main trailer video play/pause controls
document.addEventListener('DOMContentLoaded', function() {
    const video = document.querySelector('.trailer-video');
    const playPauseButton = document.getElementById('play-pause-button');
    const playIcon = playPauseButton.querySelector('i');
    const playOverlay = document.querySelector('.play-overlay');

    // Start video automatically
    video.play().catch(error => {
        console.log('Auto-play prevented:', error);
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