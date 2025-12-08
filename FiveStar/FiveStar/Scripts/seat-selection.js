// Scripts/seat-selection.js

const TICKET_PRICE = @Model.TicketPrice;

function toggleSeatSelection(button) {
    // Sadece müsait olan koltuklara izin ver
    if (button.dataset.status === "Sold") {
        return;
    }

    let currentStatus = button.dataset.status;
    let newStatus;
    let extraPrice = parseFloat(button.dataset.price) - TICKET_PRICE;

    if (currentStatus === "Available") {
        newStatus = "Selected";
        button.classList.remove('seat-available');
        button.classList.add('seat-selected');
    } else if (currentStatus === "Selected") {
        newStatus = "Available";
        button.classList.remove('seat-selected');
        button.classList.add('seat-available');
    } else {
        return; // Satılmış koltukta bir şey yapma
    }

    button.dataset.status = newStatus;
    updateSummary();
}

function updateSummary() {
    let selectedSeats = document.querySelectorAll('.seat-item[data-status="Selected"]');
    let totalTickets = selectedSeats.length;
    let totalPrice = 0;
    let selectedSeatNumbers = [];

    selectedSeats.forEach(seat => {
        let price = parseFloat(seat.dataset.price);
        totalPrice += price;
        selectedSeatNumbers.push(seat.textContent.trim());
    });

    // Özet alanlarını güncelle
    document.getElementById('selected-seats-info').textContent = `Seats: ${totalTickets} (${selectedSeatNumbers.join(', ')})`;
    document.getElementById('total-price').textContent = `Total: ${totalPrice.toFixed(2)} TL`;

    const checkoutBtn = document.getElementById('checkout-btn');

    // Ödeme butonunu etkinleştir/pasifleştir
    if (totalTickets > 0) {
        checkoutBtn.removeAttribute('disabled');
        checkoutBtn.style.opacity = 1;
        // Ödeme bağlantısını güncelle (gerçek ID'ler ile)
        // checkoutBtn.href = `/Tickets/Checkout?seats=${selectedSeatNumbers.join(',')}`; 
    } else {
        checkoutBtn.setAttribute('disabled', 'disabled');
        checkoutBtn.style.opacity = 0.5;
        checkoutBtn.href = "#";
    }
}

// Sayfa yüklendiğinde özeti bir kez güncelle
document.addEventListener('DOMContentLoaded', updateSummary);