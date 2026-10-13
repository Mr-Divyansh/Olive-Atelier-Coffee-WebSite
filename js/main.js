const menuToggle = document.querySelector(".menu-toggle");
const primaryNavigation = document.querySelector("#primary-navigation");

function setNavigationOpen(isOpen) {
  menuToggle.setAttribute("aria-expanded", String(isOpen));
  menuToggle.setAttribute(
    "aria-label",
    isOpen ? "Close navigation menu" : "Open navigation menu",
  );
  primaryNavigation.classList.toggle("is-open", isOpen);
}

menuToggle.addEventListener("click", () => {
  setNavigationOpen(menuToggle.getAttribute("aria-expanded") !== "true");
});

primaryNavigation.addEventListener("click", (event) => {
  if (event.target.closest("a")) setNavigationOpen(false);
});

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape" && menuToggle.getAttribute("aria-expanded") === "true") {
    setNavigationOpen(false);
    menuToggle.focus();
  }
});

function configureFilters(filterSelector, itemSelector, filterAttribute, itemAttribute) {
  document.querySelectorAll(filterSelector).forEach((button) => {
    button.addEventListener("click", () => {
      const category = button.dataset[filterAttribute];
      document.querySelectorAll(filterSelector).forEach((filter) => {
        const isActive = filter === button;
        filter.classList.toggle("is-active", isActive);
        filter.setAttribute("aria-pressed", String(isActive));
      });
      document.querySelectorAll(itemSelector).forEach((item) => {
        item.hidden = category !== "all" && item.dataset[itemAttribute] !== category;
      });
    });
  });
}

configureFilters("[data-menu-filter]", ".dish-card", "menuFilter", "menuCategory");
configureFilters("[data-gallery-filter]", ".gallery-item", "galleryFilter", "galleryCategory");

const bookingDate = document.querySelector('input[name="date"]');

if (bookingDate) {
  const today = new Date();
  bookingDate.min = new Date(today.getTime() - today.getTimezoneOffset() * 60_000)
    .toISOString()
    .slice(0, 10);
}

document.querySelectorAll("form[data-demo-form]").forEach((form) => {
  form.addEventListener("submit", (event) => {
    event.preventDefault();
    if (!form.reportValidity()) return;
    const message = form.querySelector(".form-message");
    if (message) {
      message.textContent =
        form.dataset.demoMessage ||
        "Thanks for exploring the demo. No reservation was sent or saved.";
    }
  });
});

const currentYear = document.querySelector("#current-year");
if (currentYear) currentYear.textContent = new Date().getFullYear();

const siteHeader = document.querySelector(".site-header");
if (siteHeader) {
  const setHeaderState = () => {
    siteHeader.classList.toggle("is-scrolled", window.scrollY > 8);
  };
  setHeaderState();
  window.addEventListener("scroll", setHeaderState, { passive: true });
}

/* ==========================================================================
   Scroll-reveal -- subtle, once-only, reduced-motion & no-JS safe.
   The .js gate means content stays visible if JavaScript never runs.
   ========================================================================== */
document.documentElement.classList.add("js");

(function initReveal() {
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  const revealTargets = [
    ".intro__copy", ".intro__photo", ".intro__label",
    ".section-heading", ".filter-row", ".dish-grid", ".gallery-grid",
    ".experience__copy", ".experience__images",
    ".reserve-copy", ".booking-form", ".visit-intro", ".visit-details",
    ".story-hero__content", ".journey-section", ".values-section",
    ".story-quote", ".about-gallery__grid", ".contact-band",
    ".page-cta", ".gallery-disclaimer", ".menu-disclaimer",
  ];

  const nodes = [];
  revealTargets.forEach((selector) => {
    document.querySelectorAll(selector).forEach((el) => {
      if (!el.hasAttribute("data-reveal")) {
        el.setAttribute("data-reveal", "");
        nodes.push(el);
      }
    });
  });

  if (reduceMotion || !("IntersectionObserver" in window)) {
    nodes.forEach((el) => el.classList.add("is-visible"));
    return;
  }

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.12, rootMargin: "0px 0px -8% 0px" },
  );

  // Stagger siblings inside grids for a gentle cascade.
  [".dish-grid", ".gallery-grid", ".about-gallery__grid", ".visit-details"].forEach((grid) => {
    const children = document.querySelectorAll(grid + " > *");
    children.forEach((child, i) => {
      child.style.setProperty("--reveal-delay", Math.min(i, 6) * 70 + "ms");
    });
  });

  nodes.forEach((el) => observer.observe(el));
})();

/* ==========================================================================
   Gallery lightbox -- opens on image click; keyboard + focus managed.
   ========================================================================== */
(function initLightbox() {
  const triggers = Array.from(
    document.querySelectorAll(".gallery-item, .about-gallery__item"),
  );
  if (!triggers.length) return;

  let galleryItems = [];
  let currentIndex = 0;
  let lastFocused = null;

  const overlay = document.createElement("div");
  overlay.className = "lightbox";
  overlay.setAttribute("role", "dialog");
  overlay.setAttribute("aria-modal", "true");
  overlay.setAttribute("aria-label", "Image viewer");
  overlay.innerHTML =
    '<button class="lightbox__close" type="button" aria-label="Close image viewer">&times;</button>' +
    '<button class="lightbox__nav lightbox__nav--prev" type="button" aria-label="Previous image">&#8249;</button>' +
    '<button class="lightbox__nav lightbox__nav--next" type="button" aria-label="Next image">&#8250;</button>' +
    '<figure class="lightbox__figure">' +
    '<img class="lightbox__img" alt="">' +
    '<figcaption class="lightbox__caption"></figcaption>' +
    "</figure>";
  document.body.appendChild(overlay);

  const img = overlay.querySelector(".lightbox__img");
  const caption = overlay.querySelector(".lightbox__caption");
  const closeBtn = overlay.querySelector(".lightbox__close");
  const prevBtn = overlay.querySelector(".lightbox__nav--prev");
  const nextBtn = overlay.querySelector(".lightbox__nav--next");

  function visibleItems() {
    return triggers.filter((el) => !el.hidden && el.offsetParent !== null);
  }

  function highResSrc(src) {
    try {
      const url = new URL(src, window.location.href);
      url.searchParams.set("w", "1600");
      url.searchParams.set("q", "85");
      return url.toString();
    } catch (e) {
      return src;
    }
  }

  function render() {
    const item = galleryItems[currentIndex];
    if (!item) return;
    const sourceImg = item.querySelector("img");
    const figcaption = item.querySelector("figcaption");
    img.src = highResSrc(sourceImg ? sourceImg.currentSrc || sourceImg.src : "");
    img.alt = sourceImg ? sourceImg.alt : "";
    caption.innerHTML = figcaption ? figcaption.innerHTML : "";
    const multi = galleryItems.length > 1;
    prevBtn.style.display = multi ? "" : "none";
    nextBtn.style.display = multi ? "" : "none";
  }

  function open(index) {
    galleryItems = visibleItems();
    if (!galleryItems.length) return;
    currentIndex = Math.max(0, Math.min(index, galleryItems.length - 1));
    lastFocused = document.activeElement;
    render();
    overlay.classList.add("is-open");
    document.body.style.overflow = "hidden";
    closeBtn.focus();
  }

  function close() {
    overlay.classList.remove("is-open");
    document.body.style.overflow = "";
    if (lastFocused && typeof lastFocused.focus === "function") lastFocused.focus();
  }

  function step(delta) {
    if (galleryItems.length < 2) return;
    currentIndex = (currentIndex + delta + galleryItems.length) % galleryItems.length;
    render();
  }

  triggers.forEach((item) => {
    item.style.cursor = "zoom-in";
    if (!item.hasAttribute("tabindex")) item.setAttribute("tabindex", "0");
    if (!item.hasAttribute("role")) item.setAttribute("role", "button");
    if (!item.hasAttribute("aria-label")) {
      const cap = item.querySelector("figcaption");
      item.setAttribute("aria-label", (cap ? cap.textContent.trim() : "Image") + " — open larger");
    }
    const openIndex = () => open(visibleItems().indexOf(item));
    item.addEventListener("click", openIndex);
    item.addEventListener("keydown", (event) => {
      if (event.key === "Enter" || event.key === " ") {
        event.preventDefault();
        openIndex();
      }
    });
  });

  closeBtn.addEventListener("click", close);
  prevBtn.addEventListener("click", () => step(-1));
  nextBtn.addEventListener("click", () => step(1));
  overlay.addEventListener("click", (event) => {
    if (event.target === overlay) close();
  });

  document.addEventListener("keydown", (event) => {
    if (!overlay.classList.contains("is-open")) return;
    if (event.key === "Escape") {
      close();
    } else if (event.key === "ArrowLeft") {
      step(-1);
    } else if (event.key === "ArrowRight") {
      step(1);
    } else if (event.key === "Tab") {
      const focusables = [prevBtn, nextBtn, closeBtn].filter((el) => el.style.display !== "none");
      if (!focusables.length) return;
      const first = focusables[0];
      const last = focusables[focusables.length - 1];
      if (event.shiftKey && document.activeElement === first) {
        event.preventDefault();
        last.focus();
      } else if (!event.shiftKey && document.activeElement === last) {
        event.preventDefault();
        first.focus();
      }
    }
  });
})();

