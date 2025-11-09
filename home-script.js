// home-script.js

/**
//The @param tag is used within JSDoc comments to formally describe a function's parameters, and it follows this format:
//@param {DataType} variableName - Description of the parameter.

@param {string} carouselId - The ID of the carousel container to scroll.
@param {number} scrollAmount - The distance in pixels to scroll (positive for right, negative for left).
*/
function scrollCarousel(carouselId, scrollAmount) {
    const carousel = document.getElementById(carouselId);
    
    // If the carousel exists, we scroll it
    if (carousel) {
        carousel.scrollLeft += scrollAmount;
    }
}


//User Dropdown Menu Functionality
//Toggles the visibility of the user dropdown menu (Sign In, Sign Up, Cart).

function toggleDropdown() {
    // Choose the dropdown menu element
    const dropdown = document.getElementById("userDropdown");
    
    //Toggle the "show-dropdown" class to show/hide the menu
    dropdown.classList.toggle("show-dropdown");
}

/**
 * Closes the dropdown menu when a click occurs outside of the menu button.
 * @param {Event} event - The click event.
 */
window.onclick = function(event) {
    // Check if the click is not on the menu button or its icon
    if (!event.target.matches('.menu-button') && !event.target.matches('.menu-button i')) {
        const dropdown = document.getElementById("userDropdown");
        
        // If the dropdown is open, remove the "show-dropdown" class to close it
        if (dropdown && dropdown.classList.contains('show-dropdown')) {
            dropdown.classList.remove('show-dropdown');
        }
    }
}


// Pause/play buttons and overlay effects for the trailer video on the main page
document.addEventListener('DOMContentLoaded', function() {
    const video = document.querySelector('.trailer-video');
    const playPauseButton = document.getElementById('play-pause-button');
    const playIcon = playPauseButton ? playPauseButton.querySelector('i') : null;
    const playOverlay = document.querySelector('.play-overlay');

    // Check if video and controls exist
    if (!video || !playPauseButton || !playIcon || !playOverlay) {
        // Video or controls not found, exit the function
        return; 
    }

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