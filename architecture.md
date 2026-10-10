# Architecture Notes

## Current implementation

The original project directory held documentation only. With approval to create the visual demo, the site was implemented as a static single-page website using native browser technologies. No framework, bundler, server, package manager, third-party runtime dependency, or environment variable is required.

| File | Responsibility |
|---|---|
| `index.html` | Semantic page structure, sections, text, interactive controls, and image references |
| `css/styles.css` | Palette tokens, typography fallbacks, responsive layout, component states, and reduced-motion treatment |
| `js/main.js` | Mobile navigation, menu/gallery filters, demo form validation and feedback, and current footer year |
| `favicon.svg` | Small Olive Atelier-inspired browser mark |

## Page composition

The one-page flow is: concept disclosure, navigation, hero, story, illustrative menu, experience imagery, filterable gallery, demo reservation form, unconfirmed visit details, and footer. The header and footer link to in-page section IDs; no router is necessary.

The dishes and supporting prose are concept copy, not confirmed menu or sourcing information. The visit section deliberately uses placeholders instead of invented address/contact/hour data. The reservation form validates date, time, and party size in the browser but sends no request and stores no personal information.

## Routing

Use the existing in-page section navigation while the brochure experience remains single-page. Add a route only if approved production content requires it.

## Assets and content

The current prototype references remote Unsplash CDN image URLs directly from `index.html`; each URL returned HTTP 200 during verification. No image file has been downloaded locally, and production usage rights/terms still require review and documentation in [assets.md](./assets.md). If approved images are later stored locally, put optimized files under `img/` and update the inventory. Copy and content are in the HTML for this small static demo; keep the demo/factual boundary explicit when replacing it.

## Styling

Tokens and responsive styles are implemented in `css/styles.css`, without a CSS framework. `--color-control-border` is a separate documented contrast-support token for control boundaries; `--color-border` remains the subtle divider color.

## State and integrations

No client state library or backend is used. Small DOM event handlers in `js/main.js` implement the mobile menu, menu/gallery category filters, and demo-only reservation feedback. Booking, ordering, maps, contact forms, analytics, and newsletter integrations are not connected.

## Performance and accessibility

Images use responsive CDN parameters and below-the-fold images use native lazy loading. The implementation uses semantic landmarks, accessible navigation state, live filter controls, meaningful image alternatives, visible focus, and reduced-motion support. Desktop and mobile viewport sizes and interactions have been checked in a browser. Individual image rights and production device QA are outstanding.
