# Architecture Notes

## Repository findings

At Phase 1 inspection, the project directory contained no files, source code, dependency manifest, framework configuration, tests, or existing documentation. The only confirmed project context is the supplied D Web Studio brief and Olive Atelier reference boards. Therefore there is no existing application architecture or tooling to report.

## Proposed boundaries (for a later approved implementation phase)

The simplest suitable starting point is a single-page hospitality website unless confirmed requirements demonstrate a need for multiple routes. Choose the framework, build system, and package manager after the target hosting/deployment and developer constraints are known. Do not preemptively add dependencies.

Suggested component responsibilities, not existing files:

- `SiteHeader` — brand and primary navigation, including accessible mobile open/close behavior.
- `HeroSection` — proposition, verified image, and primary/secondary destinations.
- `StorySection` — approved brand copy and imagery.
- `MenuHighlights` — content-driven menu preview with explicit demo/verified status.
- `ExperienceSection` and `Gallery` — atmosphere imagery and accessible browsing.
- `LocationContact` — confirmed business details and working destination links.
- `SiteFooter` — approved supporting links and legal destinations.

Keep components focused on presentation and interaction. Do not create a generalized design framework for a small brochure site.

## Routing

Start with in-page section navigation when a one-page site meets user needs. Introduce separate routes only for a confirmed reason (for example, a substantial menu or policy page). Ensure links and browser navigation remain meaningful.

## Assets and content

Keep approved local images in a clearly named public/static asset directory chosen to match the eventual framework. Maintain a source/license record in [assets.md](./assets.md); use descriptive filenames and avoid storing large originals unnecessarily. Keep business content easy to review and replace, in the simplest structure supported by the chosen stack. Separate verified business facts from sample/demo content.

## Styling

Implement the tokens in [design.md](./design.md) using the styling approach already available once a stack is selected. Avoid adding a styling dependency solely by preference. Keep responsive layout and component states explicit and maintainable.

## State and integrations

No client state library or backend is justified for the documented brochure experience. Use local component state only for genuinely interactive behavior such as mobile navigation or a gallery viewer. Booking, ordering, maps, forms, analytics, and newsletter integrations are not confirmed; add none until a real service, destination, privacy purpose, and failure behavior are supplied.

## Performance and accessibility

Use appropriately sized responsive imagery, lazy-load noncritical below-the-fold images, and avoid unnecessary scripts and animation. Prefer semantic HTML, keyboard-operable controls, visible focus, meaningful alternative text, contrast checks, and reduced-motion handling. Test on actual responsive viewport sizes after implementation.
