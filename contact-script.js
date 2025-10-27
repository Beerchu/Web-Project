// Form gönderimi için olay dinleyicisi
document.addEventListener('DOMContentLoaded', function() {
    const contactForm = document.getElementById('contactForm');

    contactForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = {
            name: document.getElementById('name').value,
            email: document.getElementById('email').value,
            subject: document.getElementById('subject').value,
            message: document.getElementById('message').value
        };

        console.log('Form verileri:', formData);
        alert('Message sent successfully! We will get back to you soon.');
        contactForm.reset();
    });
});

// Form gönderimi için olay dinleyicisi ekleme
document.addEventListener('DOMContentLoaded', function() {
    // Yıldız yağmuru efekti için logo tıklama olayı
    const navBrand = document.querySelector('.nav-brand');
    navBrand.style.cursor = 'pointer';
    navBrand.addEventListener('click', showStarRain);

    // Contact form elementini seçme
    const contactForm = document.getElementById('contactForm');

    // Form gönderildiğinde çalışacak fonksiyon
    contactForm.addEventListener('submit', function(e) {
        // Formun varsayılan davranışını engelleme
        e.preventDefault();

        // Form verilerini alma
        const formData = {
            name: document.getElementById('name').value,
            email: document.getElementById('email').value,
            subject: document.getElementById('subject').value,
            message: document.getElementById('message').value
        };

        // Form verilerini konsola yazdırma (test amaçlı)
        console.log('Form verileri:', formData);

        // Başarılı gönderim mesajı
        alert('Mesajınız başarıyla gönderildi! En kısa sürede size dönüş yapacağız.');

        // Formu sıfırlama
        contactForm.reset();
    });
});
