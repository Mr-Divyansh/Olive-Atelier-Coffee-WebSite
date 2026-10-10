# Architecture Notes

## Current implementation

The original project directory held documentation only. With approval to create the visual demo, the site was implemented as a small static website with home and About pages using native browser technologies. No framework, bundler, server, package manager, third-party runtime dependency, or environment variable is required.

| File | Responsibility |
|---|---|
| `index.html` | Semantic page structure, sections, text, interactive controls, and image references |
| `about.html` | Dedicated story/about page following the supplied reference composition |
| `css/styles.css` | Palette tokens, typography fallbacks, responsive layout, component states, and reduced-motion treatment |
| `js/main.js` | Mobile navigation, menu/gallery filters, demo form validation and feedback, and current footer year |
| `favicon.svg` | Small Olive Atelier-inspired browser mark |

## Page composition

The home page flow is: concept disclosure, navigation, hero, story, illustrative menu, experience imagery, filterable gallery, demo reservation form, unconfirmed visit details, and footer. The dedicated About page contains a story hero, journey composition, values strip, concept-motto band, photo gallery, and contact/location placeholders. Native document links connect the two pages; no router is necessary.

The dishes and supporting prose are concept copy, not confirmed menu or sourcing information. The visit section deliberately uses placeholders instead of invented address/contact/hour data. The reservation form validates date, time, and party size in the browser but sends no request and stores no personal information.

## Routing

The prototype has two static documents, `index.html` and `about.html`, connected with ordinary page links. Section links use in-page anchors; no client-side router is needed.

## Assets and content

The current prototype references remote Unsplash CDN image URLs directly from `index.html` and `about.html`; each URL returned HTTP 200 during verification. No image file has been downloaded locally, and production usage rights/terms still require review and documentation in [assets.md](./assets.md). If approved images are later stored locally, put optimized files under `img/` and update the inventory. Copy and content are in the HTML for this small static demo; keep the demo/factual boundary explicit when replacing it.

## Styling

Tokens and responsive styles are implemented in `css/styles.css`, without a CSS framework. The story-page-specific layouts are scoped with `story-`/`about-` classes and have mobile breakpoints. `--color-control-border` is a separate documented contrast-support token for control boundaries; `--color-border` remains the subtle divider color.

## State and integrations

No client state library or backend is used. Small DOM event handlers in `js/main.js` implement the mobile menu, menu/gallery category filters, and demo-only reservation feedback. Booking, ordering, maps, contact forms, analytics, and newsletter integrations are not connected.

## Performance and accessibility

Images use responsive CDN parameters and below-the-fold images use native lazy loading. The implementation uses semantic landmarks, accessible navigation state, live filter controls, meaningful image alternatives, visible focus, and reduced-motion support. Desktop and mobile viewport sizes and interactions have been checked in a browser. Individual image rights and production device QA are outstanding.
