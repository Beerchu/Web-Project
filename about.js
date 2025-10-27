// Small enhancements – defer loaded

// Animated counters when stats section enters viewport
const counters = document.querySelectorAll('.stat-number');
const io = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (!entry.isIntersecting) return;
    const el = entry.target;
    const target = parseInt(el.dataset.countTo, 10);
    const dur = 900; // ms
    // const start = performance.now();

    requestAnimationFrame(tick);
    io.unobserve(el);
  });
}, { threshold: 0.6 });
counters.forEach(c => io.observe(c));

// Accessible accordion
const accButtons = document.querySelectorAll('.acc-btn');
accButtons.forEach(btn => {
  btn.addEventListener('click', (e) => {
    const expanded = btn.getAttribute('aria-expanded') === 'true';
    btn.setAttribute('aria-expanded', String(!expanded));
    const panel = btn.nextElementSibling;
    panel.classList.toggle('open', !expanded);
  });
  // keyboard friendliness: Enter/Space default handled by button
});
