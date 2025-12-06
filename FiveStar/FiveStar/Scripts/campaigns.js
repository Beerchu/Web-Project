// campaigns.js - Campaign Page Interactivity
document.addEventListener('DOMContentLoaded', function () {
    console.log('Campaigns page loaded');

    // Initialize all campaign functionality
    initFilters();
    initSearch();
    initApplyButtons();
    initCountdowns();

    // Initialize tooltips for details
    initTooltips();
});

// Filter campaigns by category
function initFilters() {
    const filterTabs = document.querySelectorAll('.filter-tab');
    const campaignCards = document.querySelectorAll('.campaign-card');

    filterTabs.forEach(tab => {
        tab.addEventListener('click', function () {
            // Remove active class from all tabs
            filterTabs.forEach(t => t.classList.remove('active'));
            // Add active class to clicked tab
            this.classList.add('active');

            const filterValue = this.dataset.filter;

            // Filter cards with animation
            campaignCards.forEach(card => {
                if (filterValue === 'all' || card.dataset.category === filterValue) {
                    card.style.display = 'block';
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'scale(1)';
                    }, 10);
                } else {
                    card.style.opacity = '0';
                    card.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        card.style.display = 'none';
                    }, 300);
                }
            });
        });
    });
}

// Search functionality
function initSearch() {
    const searchInput = document.getElementById('campaignSearch');
    const campaignCards = document.querySelectorAll('.campaign-card');

    if (searchInput) {
        searchInput.addEventListener('input', function () {
            const searchTerm = this.value.toLowerCase().trim();

            campaignCards.forEach(card => {
                const title = card.querySelector('.card-title').textContent.toLowerCase();
                const description = card.querySelector('.card-description').textContent.toLowerCase();
                const category = card.dataset.category;

                if (searchTerm === '' || title.includes(searchTerm) || description.includes(searchTerm)) {
                    card.style.display = 'block';
                    card.style.opacity = '1';
                    card.style.transform = 'scale(1)';
                } else {
                    card.style.opacity = '0';
                    card.style.transform = 'scale(0.9)';
                    setTimeout(() => {
                        card.style.display = 'none';
                    }, 300);
                }
            });
        });
    }
}

// Apply button functionality
function initApplyButtons() {
    const applyButtons = document.querySelectorAll('.btn-apply');

    applyButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();

            const card = this.closest('.campaign-card');
            const campaignTitle = card.querySelector('.card-title').textContent;
            const campaignType = this.dataset.campaign;

            // Visual feedback
            const originalHTML = this.innerHTML;
            this.innerHTML = '<i class="fas fa-check"></i><span>Applied!</span>';
            this.disabled = true;
            this.style.background = '#27ae60';
            this.style.cursor = 'not-allowed';

            // Show notification
            showNotification(`🎉 "${campaignTitle}" has been applied!`);

            // Store in localStorage (for demo purposes)
            const appliedCampaigns = JSON.parse(localStorage.getItem('appliedCampaigns') || '[]');
            appliedCampaigns.push({
                title: campaignTitle,
                type: campaignType,
                appliedAt: new Date().toISOString()
            });
            localStorage.setItem('appliedCampaigns', JSON.stringify(appliedCampaigns));

            // Reset button after 3 seconds (for demo)
            setTimeout(() => {
                this.innerHTML = originalHTML;
                this.disabled = false;
                this.style.background = '';
                this.style.cursor = 'pointer';
            }, 3000);
        });
    });
}

// Countdown timers
function initCountdowns() {
    document.querySelectorAll('.time-badge:not(.limited):not(.weekly)').forEach(badge => {
        const text = badge.querySelector('span').textContent;
        const match = text.match(/(\d+)\s*days?/i);

        if (match) {
            const days = parseInt(match[1]);
            updateCountdown(badge, days);
        }
    });
}

function updateCountdown(badge, days) {
    let remaining = days;
    const span = badge.querySelector('span');
    const icon = badge.querySelector('i');

    function update() {
        if (remaining > 0) {
            span.textContent = `${remaining} day${remaining !== 1 ? 's' : ''} left`;

            // Color coding based on remaining days
            if (remaining <= 3) {
                badge.style.color = '#e74c3c'; // Red for urgent
                icon.style.color = '#e74c3c';
            } else if (remaining <= 7) {
                badge.style.color = '#f39c12'; // Orange for warning
                icon.style.color = '#f39c12';
            }

            remaining--;
        } else {
            span.textContent = 'Expired';
            badge.style.color = '#95a5a6'; // Gray for expired
            icon.style.color = '#95a5a6';
        }
    }

    update(); // Initial call
    // Update every 24 hours (for demo, update every minute)
    setInterval(update, 60000);
}

// Tooltips for details
function initTooltips() {
    const detailButtons = document.querySelectorAll('.btn-details');

    detailButtons.forEach(button => {
        button.addEventListener('mouseenter', function () {
            const card = this.closest('.campaign-card');
            const title = card.querySelector('.card-title').textContent;

            // You could add a tooltip system here
            // For now, we'll just use the title attribute
            this.title = `View details for ${title}`;
        });
    });
}

// Modal functions
function showDetails(campaignId) {
    const modal = document.getElementById('detailsModal');
    const modalBody = document.getElementById('modalBody');

    // Campaign data
    const campaigns = {
        1: {
            title: "Student Discount 20% Off",
            description: "All students with a valid student ID can enjoy 20% off on all movie tickets from Monday to Friday before 18:00.",
            code: "STUDENT20",
            terms: [
                "Valid student ID must be presented at the ticket counter",
                "Available Monday to Friday only",
                "Valid for shows starting before 18:00",
                "Cannot be combined with other offers",
                "Valid for standard seating only",
                "Maximum 2 tickets per student ID"
            ],
            expires: "30 days remaining",
            icon: "🎓"
        },
        2: {
            title: "Family Package: Buy 3 Get 1 Free",
            description: "Perfect for family weekends! Purchase 3 tickets and get the 4th one absolutely free. Available every Saturday and Sunday.",
            code: "FAMILY4",
            terms: [
                "Minimum purchase of 4 tickets required",
                "Available only on Saturdays and Sundays",
                "Children under 12 count as full tickets",
                "Not valid for premium or VIP seating",
                "Must purchase all tickets in a single transaction",
                "Valid for same movie and showtime only"
            ],
            expires: "Limited time offer",
            icon: "👨‍👩‍👧‍👦"
        },
        3: {
            title: "Public Tuesday: All Movies 60 TL",
            description: "Every Tuesday, all movies, all sessions are fixed at just 60 TL. Perfect for budget-friendly entertainment!",
            code: "TUESDAY60",
            terms: [
                "Valid every Tuesday only",
                "Applicable to all movies and showtimes",
                "Standard seating only",
                "Not valid for 3D or IMAX screenings",
                "Maximum 4 tickets per transaction",
                "Cannot be combined with other offers"
            ],
            expires: "Ongoing",
            icon: "📅"
        },
        4: {
            title: "Free Popcorn Upgrade + Surprise",
            description: "Buy any medium popcorn and get a free upgrade to large size plus a surprise treat. Perfect companion for your movie!",
            code: "POPCORNUP",
            terms: [
                "Must purchase medium popcorn",
                "Free upgrade to large size",
                "Receive one surprise treat (random selection)",
                "Valid at food court only",
                "One per customer per visit",
                "Cannot be combined with other food offers"
            ],
            expires: "15 days remaining",
            icon: "🍿"
        }
    };

    const campaign = campaigns[campaignId];

    if (campaign) {
        modalBody.innerHTML = `
            <div class="modal-header">
                <div class="modal-icon">${campaign.icon}</div>
                <h2>${campaign.title}</h2>
            </div>
            
            <div class="modal-description">
                <p>${campaign.description}</p>
            </div>
            
            <div class="modal-code-section">
                <h3><i class="fas fa-ticket-alt"></i> Promo Code</h3>
                <div class="code-container">
                    <span class="promo-code">${campaign.code}</span>
                    <button class="copy-code-btn" onclick="copyCode('${campaign.code}')">
                        <i class="fas fa-copy"></i> Copy
                    </button>
                </div>
            </div>
            
            <div class="modal-terms">
                <h3><i class="fas fa-file-contract"></i> Terms & Conditions</h3>
                <ul>
                    ${campaign.terms.map(term => `<li>${term}</li>`).join('')}
                </ul>
            </div>
            
            <div class="modal-expiry">
                <i class="fas fa-clock"></i>
                <span>Expires: ${campaign.expires}</span>
            </div>
            
            <button class="modal-apply-btn" onclick="applyFromModal('${campaign.code}', '${campaign.title}')">
                <i class="fas fa-check-circle"></i> Apply This Offer
            </button>
        `;

        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
}

function closeModal() {
    const modal = document.getElementById('detailsModal');
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
}

function copyCode(code) {
    navigator.clipboard.writeText(code).then(() => {
        showNotification('📋 Code copied to clipboard!');
    }).catch(err => {
        console.error('Failed to copy: ', err);
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = code;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
        showNotification('📋 Code copied to clipboard!');
    });
}

function applyFromModal(code, title) {
    showNotification(`✅ "${title}" applied successfully!`);
    closeModal();

    // Find and trigger the apply button for this campaign
    const applyButtons = document.querySelectorAll('.btn-apply');
    applyButtons.forEach(button => {
        if (button.dataset.campaign && button.closest('.campaign-card').querySelector('.card-title').textContent === title) {
            button.click();
        }
    });
}

function showNotification(message) {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = 'campaign-notification';
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-check-circle"></i>
            <span>${message}</span>
        </div>
    `;

    // Add styles
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(45deg, #27ae60, #2ecc71);
        color: white;
        padding: 15px 25px;
        border-radius: 10px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.3);
        z-index: 9999;
        transform: translateX(150%);
        transition: transform 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        max-width: 350px;
    `;

    document.body.appendChild(notification);

    // Show with animation
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 10);

    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.transform = 'translateX(150%)';
        setTimeout(() => {
            if (notification.parentNode) {
                document.body.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Close modal when clicking outside
document.addEventListener('click', function (event) {
    const modal = document.getElementById('detailsModal');
    if (event.target === modal) {
        closeModal();
    }
});

// Close modal with Escape key
document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        closeModal();
    }
});