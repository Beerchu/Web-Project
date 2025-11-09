/* ===========================
   About page interactions
   - Smooth scroll
   - Section fade-in
   =========================== */
/* ---------- Helpers ---------- */
const easeOutCubic = t => 1 - Math.pow(1 - t, 3);


/* ---------- Smooth scroll for in-page anchors ---------- */
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const href = a.getAttribute('href');
    if (!href || href === '#') return;
    const target = document.querySelector(href);
    if (!target) return;
    e.preventDefault();
    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
  });
});

/* ---------- Section fade-in on scroll (light) ---------- */
const sections = document.querySelectorAll('.section');
const sectionIO = new IntersectionObserver(entries => {
  entries.forEach(ent => {
    if (ent.isIntersecting) {
      ent.target.style.opacity = '1';
      ent.target.style.transform = 'translateY(0)';
      sectionIO.unobserve(ent.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -100px 0px' });

sections.forEach(sec => {
  sec.style.opacity = '0';
  sec.style.transform = 'translateY(30px)';
  sec.style.transition = 'opacity .6s ease, transform .6s ease';
  sectionIO.observe(sec);
});

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