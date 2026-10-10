# Olive Atelier — Design System

**Concept:** Olive Atelier — Natural Premium  
**Status:** implemented in the static concept prototype; real-business adaptation is pending
**Reference:** supplied Olive Atelier desktop identity/site board and mobile screen board

## Brand and audience

Olive Atelier should feel natural, warm, sophisticated, welcoming, and quietly premium: closer to an independent restaurant with an editorial point of view than a generic hospitality template. The intended audience is people choosing a café or restaurant for food, atmosphere, and a straightforward visit-planning experience.

Use real details and unforced language. The boards are inspiration for hierarchy and mood, not a source of verified business claims or reusable third-party artwork.

## Official palette and tokens

These five colors are fixed brand colors and must retain the exact values below.

| Token | Official color | HEX | Usage |
|---|---|---|---|
| `--color-background` | Warm Ivory | `#F7F3E8` | Main page/canvas background |
| `--color-primary` | Deep Forest Green | `#24382C` | Primary actions, navigation accents, selected dark sections |
| `--color-secondary` | Muted Olive | `#7A8056` | Restrained supporting accents, tags, selected highlights |
| `--color-accent` | Soft Brass | `#C6A56B` | Fine borders and small decorative details; not small text on ivory |
| `--color-text` | Espresso Brown | `#4A3024` | Headings and primary text where appropriate |

Suggested semantic tokens for implementation:

| Token | Value | Purpose |
|---|---|---|
| `--color-surface` | `#FCFAF4` | Slightly lifted content surface |
| `--color-on-primary` | `#FFFFFF` | Text/icons on deep forest green, subject to contrast verification |
| `--color-border` | `#E6E1D6` | Subtle warm divider and form boundary |
| `--color-text-muted` | `#6B6860` | Secondary text; verify contrast in its actual context |
| `--color-control-border` | `#8F897A` | Higher-contrast borders for interactive control boundaries; 3:1 minimum against warm ivory |

These additional neutrals support hierarchy; they do not replace or redefine the official five colors. Do not introduce arbitrary hues. Any new color must be documented with a purpose and checked for contrast. Brass is decorative on light backgrounds, not a default text color.

## Typography

Use an editorial serif for display/headings (preferred starting point: **Playfair Display**) paired with a clean sans serif for body/UI (preferred starting point: **Inter**). The initial static implementation avoids external font dependencies and uses Georgia/system-serif and Avenir/Segoe UI/system-sans fallbacks. This preserves the editorial pairing but may render differently by device; load licensed web fonts only after deciding a production font-serving approach.

- Display/hero: expressive serif, regular or medium weight, controlled line length; scale responsively.
- Section headings: serif with clear hierarchy, avoid using display sizing everywhere.
- Body: sans serif, comfortable line-height, readable measure and plain language.
- Labels/captions: compact sans-serif; uppercase only when it improves scanning.
- Buttons/navigation: sans-serif with strong legibility and consistent casing.
- Limit the site to this pairing and a small, deliberate set of weights.

## Layout, grid, spacing, and breakpoints

- Use an editorial grid with aligned content edges and intentionally varied image/text compositions; avoid a uniform grid of identical cards.
- Center content in a fluid container with a proposed maximum width of about `1200px`; allow generous side gutters on desktop and compact, consistent gutters on mobile.
- Use a spacing scale based on `4px` increments (e.g. 8/12/16/24/32/48/64/96px) and apply it consistently.
- Proposed responsive checkpoints: `480px` (small/large mobile transition), `768px` (tablet), `1024px` (laptop), and `1280px` (wide container behavior). These are implementation starting points, not device-specific assumptions; test between them.
- Keep paragraphs at a comfortable reading width. Avoid excessive empty space and avoid compressing dense content.

## Section direction

- **Header:** restrained brand wordmark, concise desktop navigation, one clear action if the business can support it. At mobile widths, a clear menu control opens a compact, keyboard-operable navigation.
- **Hero:** one strong, relevant photograph; short headline and supporting sentence; one primary action and at most one secondary action. Preserve the food/room focal point and ensure copy remains readable.
- **Story:** editorial text-and-image composition that feels personal without inventing provenance or founder history.
- **Menu:** curated set of dishes with image, name, concise description, and price only when confirmed. Use restrained categorization and avoid repetitive floating cards.
- **Experience:** show atmosphere, ingredients, or hospitality with one considered image/text contrast section; a deep-green band may separate major content.
- **Gallery:** curated, varied but coherent photographs in a responsive grid; provide an accessible way to inspect them if enlarged interaction is added.
- **CTA:** a clear, factual action near the end; no urgency or booking availability claims unless true.
- **Footer:** compact brand sign-off, useful navigation, confirmed contact/social/legal destinations only.

## Photography and image treatment

Use distinct, relevant images for food, interiors, and experience. Prefer natural daylight, realistic food styling, wood, stone, linen, produce, and greenery in a coherent warm palette. Avoid synthetic-looking food, unrelated stock, over-saturation, and repeating one image across sections.

Proposed aspect ratios: hero `3:2` or wide `16:9` (crop guided by the focal subject); menu `4:3` or `1:1`; gallery a deliberate mix of `4:3` and portrait `3:4`. Use responsive sizing and intentional `object-fit: cover` crops; preserve focal content. Provide meaningful alt text for informative images. Record source, license/attribution, local path, and verification in [assets.md](./assets.md). Never imply stock photography depicts the actual venue.

## Components and interaction states

- **Buttons:** primary deep green with white label; secondary quiet outline or text treatment. Provide hover, pressed, disabled, and obvious keyboard-focus states. Ensure target size is comfortable for touch.
- **Links:** distinguishable by more than color where necessary; focus is visible and underline behavior remains clear.
- **Forms:** only add when there is a real destination and purpose; associate labels and errors with controls, explain required fields, and provide success/error feedback.
- **Cards:** use only when they aid scanning or action. Prefer editorial separators and image/text compositions over stacks of rounded cards.
- **Borders:** thin warm neutral dividers; brass only as a restrained accent.
- **Icons:** use a consistent, minimal icon set with accessible names for icon-only controls; do not use emoji as interface icons.
- **Motion:** short, subtle hover/focus transitions and purposeful section effects only. Respect `prefers-reduced-motion`; the full experience must remain polished with motion disabled.

## Responsive behavior

Recompose rather than merely shrink: stack editorial layouts in a deliberate reading order, simplify multi-column menu/gallery layouts, keep navigation reachable, and adjust image crops per viewport. Prevent horizontal overflow from text, images, menus, and controls. Verify narrow mobile, large mobile, tablet, desktop, and wide layouts.

## Accessibility and contrast

- Use semantic landmarks and heading order, keyboard-operable controls, visible focus, descriptive names, and useful form instructions.
- Do not convey status through color alone. Supply text, shape, or icon cues.
- Check actual text/background combinations against WCAG contrast requirements during implementation; do not assume palette combinations are compliant. In particular, do not use brass for small text on ivory, and verify olive/muted text on light surfaces.
- The prototype uses primary green for small eyebrow labels because muted olive (`#7A8056`) on ivory has only 3.75:1 contrast. It uses muted text (`#6B6860`) for secondary small text (5.02:1) and a separate `--color-control-border` (`#8F897A`) for control outlines (3.14:1 against ivory); the softer `--color-border` is reserved for non-interactive dividers.
- The keyboard focus outline is primary green on light surfaces and brass (`#C6A56B`) on deep-green sections. Re-check controls against actual backgrounds if colors or page structure change.
- Give informative images concise contextual alt text; use empty alt text for decorative imagery.
- Respect reduced-motion settings and ensure animation does not block content or interaction.

## Do not use

Purple gradients, glassmorphism, neon/glow effects, excessive orange/amber, emoji UI icons, fake reviews/metrics/awards, vague hero copy, excessive pill-shaped buttons, cursor animations, dramatic scroll effects, unverified claims, repeated generic card grids, or stock photos presented as the real restaurant.

## Visual QA checklist

- [ ] The five official HEX values remain unchanged and all extra tokens are documented.
- [ ] No unsupported colors or generic AI-template treatments have entered the interface.
- [ ] The page reads as warm, editorial, human, and photography-led rather than overdesigned.
- [ ] Headings, body, labels, and controls have a clear typographic hierarchy.
- [ ] Images are relevant, distinct, appropriately cropped, optimized, and source-recorded.
- [ ] Mobile, tablet, desktop, and wide layouts have no unintended overflow or awkward stacking.
- [ ] Keyboard focus, control names, semantic structure, contrast, and reduced motion are checked.
- [ ] All buttons and links lead to real actions; placeholder content is conspicuously identified.
