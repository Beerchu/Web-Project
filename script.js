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