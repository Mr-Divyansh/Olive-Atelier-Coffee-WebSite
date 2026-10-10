# Product Requirements Document

**Product:** Olive Atelier restaurant and café website demo  
**Status:** Static concept prototype implemented; business details remain unconfirmed
**Owner/context:** D Web Studio brief and supplied visual references

## Problem and opportunity

Independent restaurants and cafés need a clear online presence that communicates what a visit feels like and helps people take a practical next step. A considered, photography-led site can make the menu, location, and contact path easier to understand without relying on exaggerated claims or a generic template.

Olive Atelier is the working concept for exploring that experience. The supplied design boards show a possible brand direction; they do not establish that a real business, menu, location, or booking service exists.

## Target users

- **Prospective diners:** want to decide whether the food and atmosphere suit them, check useful visit details, and find the menu or contact route.
- **Returning guests:** want a quick route to current menu, opening hours, directions, or booking information.
- **Restaurant owner/operator:** needs accurate, maintainable presentation of approved business information and a clear enquiry or visit pathway.

## Business goals

- Present the restaurant/café concept with a distinctive, consistent identity.
- Make key information and next steps easy to find, especially on mobile.
- Build trust through accurate, useful content rather than unsupported social proof.
- Provide an accessible, responsive foundation that can later be adapted to confirmed business needs.

Success is evaluated through completion of the acceptance criteria and stakeholder review, not invented traffic, conversion, or revenue targets.

## User needs and journeys

1. **Considering a visit:** arrive from search or a shared link → understand the concept and atmosphere → inspect menu highlights → find verified hours/location → use a valid booking, directions, or contact action.
2. **Checking the menu:** open menu from navigation or hero → scan categories and descriptions → see prices only if confirmed → use the real order/contact action if one exists.
3. **Finding the venue:** reach contact/location section → access confirmed address, phone, email, hours, and directions → use accessible links that work on the visitor's device.
4. **Mobile browsing:** use a touch-friendly navigation → read content without zooming or horizontal scrolling → reach the primary action with keyboard or touch.

## Functional requirements

- **FR-1 Navigation:** provide clear links to available primary sections; on small screens, provide an operable menu with a visible open/closed state.
- **FR-2 Hero:** communicate the confirmed brand proposition with concise copy, a relevant image, and a primary action whose destination is real.
- **FR-3 Story:** present approved background or hospitality positioning in a short, human voice.
- **FR-4 Menu:** show only supplied or explicitly labelled demo items. Do not represent illustrative names or prices as confirmed offerings.
- **FR-5 Images/gallery:** use relevant, appropriately licensed and verified assets; give informative images meaningful alt text and decorative images empty alt text.
- **FR-6 Contact/location:** show business details only after confirmation. Use telephone, email, map, reservation, and ordering links only when their destinations are valid.
- **FR-7 Footer:** provide useful site navigation and only confirmed legal/social/contact links.
- **FR-8 Feedback and states:** interactive controls need understandable hover, focus, active, disabled, and submission feedback states as relevant to the actual functionality.
- **FR-9 Testimonials:** omit unless genuine, authorized testimonials are supplied; any demo-only content must be conspicuously labelled.
- **FR-10 Legal and consent:** determine applicable privacy, cookie, terms, and refund information from actual data collection and business operations before production. Do not imply legal compliance by adding generic pages.

## Non-functional requirements

- Work across small/large mobile, tablet, laptop, desktop, and wide layouts.
- No unintended horizontal overflow; navigation and controls work with touch and keyboard.
- Use semantic structure, visible keyboard focus, meaningful names, adequate contrast, and reduced-motion support.
- Prefer responsive, optimized images; lazy-load below-the-fold imagery when appropriate.
- Keep motion restrained and ensure content remains usable with motion disabled.
- Keep content, assets, and components maintainable; avoid adding dependencies without a demonstrated need.
- Do not expose credentials or collect personal data without a defined, reviewed purpose and secure handling plan.

## Proposed core page sections

The home page covers header/navigation, hero, short story, selected menu, dining experience, curated gallery, demo-only reservation form, visit details, and footer. A dedicated About page provides the long-form story, values, concept motto, gallery, and contact placeholders. Include only sections that help the confirmed business and available content. Testimonials are optional and require verified material.

## Mobile requirements

- Navigation is usable with a thumb and exposes its state to assistive technology.
- Content reflows into a readable single-column or deliberately adapted layout.
- Text and controls remain legible and operable at narrow widths.
- Images use intentional crops that keep the subject visible.
- CTAs remain clear without covering key photography or competing with one another.
- Layout is checked at narrow and large mobile widths, not just simulated desktop scaling.

## Acceptance criteria

- Visitors can identify the restaurant/café concept and find the primary available action.
- Every displayed business fact, price, testimonial, address, and operational detail is confirmed or clearly marked as demo placeholder.
- Every active navigation/action link has a valid destination; unavailable actions are omitted rather than faked.
- Layout adapts to mobile, tablet, and desktop without horizontal page overflow.
- Core page content and controls are keyboard operable with visible focus and meaningful accessible names.
- Images have appropriate alt treatment, verified sourcing records, and fit their intended layout.
- Color, type, spacing, image treatment, and motion follow [design.md](./design.md).
- Build, lint, and test status is reported only after the corresponding tooling exists and commands have actually run.

## Out of scope for the initial demo

- Online payment, ordering, customer accounts, or booking backend.
- CMS, analytics, tracking, or newsletter storage.
- Invented operational details, testimonials, awards, ratings, or performance metrics.
- Legal advice or claims of regulatory compliance.
- Production launch before business, content, image rights, and deployment details are confirmed.

## Demo-content and placeholder policy

Mark all unknown real-business facts as **[PLACEHOLDER — confirm with business]** in working content. Remove or replace them before publication. If illustrative menu content is needed for a prototype, label it as sample/demo content in the interface and documentation; never use sample details in a way that could be mistaken for the actual business.
