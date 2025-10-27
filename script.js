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

// Add event listeners to scroll buttons
document.addEventListener('DOMContentLoaded', () => {
    // Get all scroll buttons
    const scrollButtons = document.querySelectorAll('.scroll-btn');
    
    scrollButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Find the closest carousel wrapper
            const wrapper = button.closest('.movie-carousel-wrapper');
            if (wrapper) {
                // Find the carousel inside this wrapper
                const carousel = wrapper.querySelector('.movie-carousel');
                if (carousel) {
                    // Determine scroll direction based on button class
                    const scrollAmount = button.classList.contains('left') ? -300 : 300;
                    carousel.scrollLeft += scrollAmount;
                }
            }
        });
    });

    // Mobile menu toggle
    const menuButton = document.querySelector('.menu-button');
    const nav = document.querySelector('nav');
    
    if (menuButton && nav) {
        menuButton.addEventListener('click', () => {
            nav.classList.toggle('active');
        });
    }
});

// Note: In a real application, you would also likely add event listeners
// for the main trailer play button or individual movie items.
// E.g., document.querySelector('.play-button').addEventListener('click', () => { /* open trailer video */ });