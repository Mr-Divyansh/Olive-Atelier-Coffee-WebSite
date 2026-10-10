# Project Checklist

Status: `[x]` complete with evidence; `[ ]` pending. The user approved continuing after Phase 1; the site is a concept prototype, not a verified production site.

## Phase 1 — Repository inspection and documentation

- [x] Inspect the project directory and check for existing source, manifests, docs, and hidden files.
- [x] Record confirmed current status and avoid assuming a technology stack.
- [x] Document product goals, audience, journeys, requirements, and acceptance criteria in `PRD.md`.
- [x] Document exact palette, responsive behavior, accessibility, imagery, interactions, and visual QA in `design.md`.
- [x] Record existing/proposed architecture and limits in `architecture.md`.
- [x] Document gated implementation phases in `phases.md`.
- [x] Document AI workflow, project rules, and section content plan.
- [x] Create an asset inventory that clearly distinguishes unverified candidates from real assets.
- [x] Cross-check documentation for unsupported claims and consistency.
- [x] Keep the original Phase 1 pass documentation-only.

## Phase 2 — Design-system and asset preparation

- [x] Implement the official palette and documented contrast tokens.
- [x] Select stock-image URLs, check they return HTTP 200, and record them in `assets.md`.
- [ ] Review current Unsplash terms and production image-specific usage/attribution rights.
- [ ] Confirm real-client vs fictional-demo identity, approved content, and font serving approach.

## Phase 3 — Responsive page structure

- [x] Choose native HTML/CSS/JavaScript for the static one-page prototype; no framework or dependencies needed.
- [x] Implement semantic, responsive page structure and approved design tokens.
- [x] Verify navigation and no horizontal overflow at 390px and 1440px browser viewports.

## Phase 4 — Main sections and content

- [x] Add concept hero, story, illustrative menu, experience/gallery, visit placeholders, and footer.
- [x] Clearly label demo menu, stock photography, reservation limits, and unconfirmed business information.
- [ ] Replace/approve content and imagery for a real venue.

## Phase 5 — Interactions and functionality

- [x] Implement mobile navigation with accessible state and Escape key support.
- [x] Implement menu/gallery filters and client-side demo form feedback with no data submission.
- [x] Verify in-page targets and interactive behavior in the browser.
- [ ] Connect real booking/contact destinations only after they are provided.

## Phase 6 — Responsive, accessibility, and visual QA

- [x] Browser-check mobile and desktop widths, navigation, filters, and demo form behavior; verify source URLs respond.
- [x] Correct small olive text and control-boundary contrast; document measured palette ratios.
- [x] Add visible focus and reduced-motion styles.
- [ ] Complete physical-device, broader assistive-technology, and final production visual QA.

## Phase 7 — Performance optimization and final review

- [x] Use responsive Unsplash URL parameters, lazy-load below-the-fold images, and add no JS dependencies.
- [x] Run `node --check js/main.js`; no build or automated-test setup exists.
- [ ] Review image rights and final content; configure production host and run production performance/accessibility review.
