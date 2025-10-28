/* ===========================
   About page interactions
   - Smooth scroll
   - Section fade-in
   - Stats: card reveal 
   =========================== */

/* ---------- Helpers ---------- */
const fmt = n => n.toLocaleString('en-US');           // 983,476
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

/* ---------- Stats: reveal + counters ---------- */
const statCards = document.querySelectorAll('.stat-card');
const statNumbers = document.querySelectorAll('.stat-number');

/* kartların fade+slide animasyonu için .visible sınıfı */
statCards.forEach(card => card.classList.remove('visible'));

const playCounter = el => {
  const base = parseInt(el.getAttribute('data-base'), 10) || 0;
  const inc  = parseInt(el.getAttribute('data-target'), 10) || 0;
  const dur  = parseInt(el.getAttribute('data-duration'), 10) || 1200;

  const start = performance.now();
  const end   = start + dur;

  const tick = now => {
    const t = Math.min(1, (now - start) / (end - start));
    const current = Math.round(base + inc * easeOutCubic(t));
    el.textContent = fmt(current);
    if (t < 1) requestAnimationFrame(tick);
  };
  requestAnimationFrame(tick);
};



statCards.forEach(c => statsIO.observe(c));
statNumbers.forEach(n => statsIO.observe(n));


