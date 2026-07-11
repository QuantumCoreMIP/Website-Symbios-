/* Symbios Health — scroll animations + back-to-top
   Mirrors the live Impreza theme behaviors: us_animate_this elements fade in
   from the bottom (afb) or left (afl) as they scroll into view, grid items and
   brand logos stagger, and a scroll-to-top arrow appears after scrolling. */
(function () {
  var reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---------- scroll-reveal ---------- */
  if (!reduced && 'IntersectionObserver' in window) {
    var SELECTORS = [
      '.eyebrow', '.section-title', '.section-lead',
      '.iconbox', '.card', '.testimonial',
      '.split > *', '.brand-strip > a', '.brand-strip > img',
      '.newsletter .container > *', 'form.contact-form',
      '.container > .learn-more', '.signup-img'
    ];
    var els = document.querySelectorAll(SELECTORS.join(','));
    els.forEach(function (el) {
      if (el.closest('.anim')) return;            // don't double-animate nested targets
      el.classList.add('anim', 'anim-fb');
      var parent = el.parentElement;
      if (parent && (parent.classList.contains('grid') || parent.classList.contains('brand-strip'))) {
        var idx = Array.prototype.indexOf.call(parent.children, el);
        el.style.transitionDelay = (idx * 0.15) + 's';
      }
    });

    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('anim-in');
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
    document.querySelectorAll('.anim').forEach(function (el) { io.observe(el); });

    /* hero intro: headline from the left, copy from the bottom (afl/afb) */
    var heroH1 = document.querySelector('.hero h1');
    var heroP = document.querySelectorAll('.hero .hero-box p');
    if (heroH1) heroH1.classList.add('anim', 'anim-fl');
    heroP.forEach(function (p) { p.classList.add('anim', 'anim-fb'); });
    requestAnimationFrame(function () {
      requestAnimationFrame(function () {
        if (heroH1) heroH1.classList.add('anim-in');
        heroP.forEach(function (p) { p.classList.add('anim-in'); });
      });
    });
  }

  /* ---------- hero slider (live: Royal Slider — fade 1s, autoplay 3s, loop) ---------- */
  var slides = document.querySelectorAll('.hero-slides .hero-slide');
  if (slides.length > 1 && !reduced) {
    var current = 0;
    setInterval(function () {
      slides[current].classList.remove('active');
      current = (current + 1) % slides.length;
      slides[current].classList.add('active');
    }, 3000);
  }

  /* ---------- View Bio popups (live: w-popup modals on team cards) ---------- */
  document.querySelectorAll('.view-bio').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var card = btn.closest('.card');
      var img = card.querySelector('img');
      var name = card.querySelector('h4');
      var role = card.querySelector('.card-body p');
      var bio = card.querySelector('.bio-popup');
      var overlay = document.createElement('div');
      overlay.className = 'bio-modal-overlay';
      overlay.innerHTML = '<div class="bio-modal" role="dialog" aria-modal="true">' +
        '<button class="bio-close" aria-label="Close">&times;</button>' +
        (img ? '<img src="' + img.src + '" alt="">' : '') +
        '<h4>' + (name ? name.innerHTML : '') + '</h4>' +
        '<p class="bio-role">' + (role ? role.textContent : '') + '</p>' +
        '<div class="bio-text">' + (bio ? bio.innerHTML : '') + '</div></div>';
      var close = function () { overlay.remove(); document.removeEventListener('keydown', onKey); };
      var onKey = function (e) { if (e.key === 'Escape') close(); };
      overlay.addEventListener('click', function (e) { if (e.target === overlay) close(); });
      overlay.querySelector('.bio-close').addEventListener('click', close);
      document.addEventListener('keydown', onKey);
      document.body.appendChild(overlay);
    });
  });

  /* ---------- back to top (live: .w-toplink with arrow-up) ---------- */
  var top = document.createElement('a');
  top.className = 'toplink';
  top.href = '#';
  top.setAttribute('aria-label', 'Back to top');
  top.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" xmlns="http://www.w3.org/2000/svg"><path d="M12 20V5M5 12l7-7 7 7"/></svg>';
  top.addEventListener('click', function (e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: reduced ? 'auto' : 'smooth' });
  });
  document.body.appendChild(top);
  var onScroll = function () {
    top.classList.toggle('show', window.scrollY > 300);
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
})();
