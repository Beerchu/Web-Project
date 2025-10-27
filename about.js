// Small enhancements – defer loaded

// Animated counters when stats section enters viewport
const counters = document.querySelectorAll('.stat-number');

if (counters.length > 0) {
  const io = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (!entry.isIntersecting) return;
      const el = entry.target;
      const target = parseInt(el.dataset.countTo, 10);
      const dur = 2000; // ms
      const start = performance.now();

      function tick(now) {
        const elapsed = now - start;
        const progress = Math.min(elapsed / dur, 1);
        const current = Math.floor(progress * target);
        el.textContent = current.toLocaleString('tr-TR');

        if (progress < 1) {
          requestAnimationFrame(tick);
        } else {
          el.textContent = target.toLocaleString('tr-TR');
        }
      }

      requestAnimationFrame(tick);
      io.unobserve(el);
    });
  }, { threshold: 0.5 });

  counters.forEach(c => io.observe(c));
}

// Smooth scroll for internal links
const links = document.querySelectorAll('a[href^="#"]');
links.forEach(link => {
  link.addEventListener('click', (e) => {
    const href = link.getAttribute('href');
    if (href === '#') return; // Skip empty anchors
    
    e.preventDefault();
    const target = document.querySelector(href);
    if (target) {
      target.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      });
    }
  });
});

// Add fade-in animation on scroll
const observerOptions = {
  threshold: 0.1,
  rootMargin: '0px 0px -100px 0px'
};

const fadeInObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.opacity = '1';
      entry.target.style.transform = 'translateY(0)';
    }
  });
}, observerOptions);

// Apply fade-in to sections
const sections = document.querySelectorAll('.section');
sections.forEach(section => {
  section.style.opacity = '0';
  section.style.transform = 'translateY(30px)';
  section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
  fadeInObserver.observe(section);
});

// --- STAT COUNTERS (base + increment) ----------------------------------------------------------------------
(function () {
  const fmt = n => n.toLocaleString('tr-TR'); // 983.476 formatı
  const counters = document.querySelectorAll('.stat-number');
  if (!counters.length) return;

  const animate = el => {
    const base = parseInt(el.getAttribute('data-base'), 10) || 0;
    const inc  = parseInt(el.getAttribute('data-target'), 10) || 0;
    const dur  = parseInt(el.getAttribute('data-duration'), 10) || 1200;

    const start = performance.now();
    const end   = start + dur;

    const tick = now => {
      const t = Math.min(1, (now - start) / (end - start));
      const eased = 1 - Math.pow(1 - t, 3);              // easeOutCubic
      const current = Math.round(base + inc * eased);
      el.textContent = fmt(current);
      if (t < 1) requestAnimationFrame(tick);
    };
    requestAnimationFrame(tick);
  };

  const io = new IntersectionObserver((entries, obs) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        animate(e.target);
        obs.unobserve(e.target); // bir kez çalışsın
      }
    });
  }, { threshold: 0.35 });

  counters.forEach(el => io.observe(el));
})();