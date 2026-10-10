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