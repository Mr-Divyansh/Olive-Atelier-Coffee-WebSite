# Implementation Roadmap

Phase 1 is complete. The user has now approved proceeding with the website concept. The first static prototype covers page structure, sections, and demo interactions; phase status below distinguishes prototype checks from production readiness.

## Phase 1 — Repository inspection and documentation

- **Tasks:** inspect repository and instructions; identify known project constraints; document product, design, architecture, content, assets, workflow, rules, and tasks.
- **Deliverables:** `README.md`, `PRD.md`, `design.md`, `architecture.md`, `phases.md`, `ai-loop.md`, `rules.md`, `content.md`, `assets.md`, `tasks.md`.
- **Dependencies:** supplied brief and reference boards.
- **Acceptance:** docs agree; design has exact palette and practical responsive/accessibility/image guidance; unknown facts and stack are labelled; no frontend code is added.
- **Checklist:** repository inspected; current state recorded; docs cross-checked; no implementation started.
- **Status:** Complete for this documentation pass.

## Phase 2 — Design-system and asset preparation

- **Tasks:** implement the documented tokens; select image sources and record URL checks; note font and business-detail limitations.
- **Deliverables:** implementation-ready design tokens and initial asset inventory.
- **Dependencies:** Phase 1 documentation and user approval (received).
- **Acceptance:** URLs respond; used stock images are identified as illustrative. **Production rights review remains outstanding**, so the phase is not fully production-complete.
- **Checklist:** [x] Exact design tokens implemented. [x] Image URLs reachable and recorded. [ ] Review current image-specific usage rights and final source/attribution decisions.
- **Status:** Partial; production image/license review remains.

## Phase 3 — Responsive page structure

- **Tasks:** confirm stack and deployment needs; implement semantic page skeleton, navigation landmarks, responsive containers, and documented tokens.
- **Deliverables:** responsive structural page with no invented content.
- **Dependencies:** Phase 2 completion and approval.
- **Acceptance:** intended reading order and navigation work at mobile, tablet, and desktop; no unintended overflow; implementation uses the selected palette.
- **Checklist:** [x] Semantic one-page structure, navigation, and responsive layouts implemented. [x] Browser checked at desktop and mobile widths.
- **Status:** Complete for the prototype.

## Phase 4 — Main sections and content

- **Tasks:** add approved hero, story, menu, experience/gallery, contact, and footer content where useful; add verified imagery and accurate alt text.
- **Deliverables:** populated page sections and recorded assets.
- **Dependencies:** Phase 3 structure and approved business copy/assets.
- **Acceptance:** every factual claim is confirmed; demo content is labelled; the page has a clear, useful visitor journey.
- **Checklist:** [x] Story, demo menu, experience imagery, gallery, visit placeholders, and footer implemented. [x] Demo/business distinction labelled in the page.
- **Status:** Complete for the concept prototype; content requires replacement/approval for a real venue.

## Phase 5 — Interactions and functionality

- **Tasks:** implement mobile navigation and only confirmed menu, booking, order, gallery, or contact behavior; include success/error states for real submissions.
- **Deliverables:** working, accessible actions with valid destinations.
- **Dependencies:** Phases 3–4 and confirmed integrations/actions.
- **Acceptance:** controls are keyboard/touch operable; no dead links or success-shaped placeholders; failures are communicated.
- **Checklist:** [x] Mobile navigation open/close and Escape behavior implemented. [x] Menu/gallery filters and demo form feedback verified. [x] All in-page links target existing sections.
- **Status:** Complete for the prototype; no live booking/contact integration exists.

## Phase 6 — Responsive, accessibility, and visual QA

- **Tasks:** inspect narrow and large mobile, tablet, desktop, keyboard use, focus, contrast, semantics, alt text, reduced motion, and visual design consistency.
- **Deliverables:** resolved QA findings and evidence/notes for remaining limitations.
- **Dependencies:** implemented page and interactions.
- **Acceptance:** documented `design.md` checklist passes or remaining issues are explicitly reported and addressed before production.
- **Checklist:** [x] No horizontal overflow at tested 390px and 1440px widths. [x] Final image URLs returned HTTP 200. [x] Reduced-motion, focus, and contrast treatments added. [ ] Full photo/content and physical-device accessibility review.
- **Status:** Prototype checks complete; production review pending.

## Phase 7 — Performance optimization and final review

- **Tasks:** inspect image sizes/loading, remove unused assets/dependencies, run available checks, review factual content and deployment configuration.
- **Deliverables:** validated release candidate and updated documentation.
- **Dependencies:** Phase 6 review and target deployment details.
- **Acceptance:** available build/lint/tests pass; performance work preserves visual quality; deployment details and unresolved production requirements are recorded.
- **Checklist:** [x] JavaScript syntax check passed. [ ] No project build, automated test suite, or Lighthouse run is configured; production optimization and hosting review remain.
- **Status:** Partial; prototype has no build step, production readiness is not claimed.
