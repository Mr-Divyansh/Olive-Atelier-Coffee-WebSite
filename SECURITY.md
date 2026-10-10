# Security

Olive Atelier is a **static website** built with plain HTML, CSS, and JavaScript. There is no server, database, admin area, or application backend. This note records the current security posture and what changes if that ever stops being true.

## Current state (verified)

- **No secrets in the repository.** A scan of the HTML, CSS, and JavaScript for API keys, tokens, passwords, and `Bearer`/`AKIA`/`sk-` style credentials returned nothing. Nothing sensitive is committed to Git.
- **No backend, so no server-side attack surface.** There are no admin routes, authentication flows, database queries, or API endpoints to protect.
- **Forms collect nothing.** The booking and contact forms are validated in the browser only. They never send or store data, so there is no server-side input to sanitise.
- **No third-party scripts.** The only external requests are Unsplash images and no tracking/analytics/advertising scripts are loaded.
- **No build step or dependencies.** There is no `package.json`, lockfile, or npm packages to keep updated or audit.

## What applies because it is a client-only static site

| Checklist item | Status here | Notes |
|---|---|---|
| Hide API keys / env variables | N/A | No keys, no environment, no backend. |
| Protect admin routes / authentication / access control | N/A | No admin area exists. |
| Sanitise forms / XSS protection | Low risk | Forms render no user input and send nothing. Any future feature that echoes user input must escape it and avoid `innerHTML`. |
| Rate limiting / secure API / CORS | N/A | No API or server. |
| Security headers / debug mode off | Host-level | Set by the host (e.g. GitHub Pages). No debug output is emitted. |
| Update dependencies / remove packages | N/A | No dependencies. |
| Secure database / hash passwords | N/A | No database or accounts. |
| Scan Git for leaked secrets | Done | No secrets present; keep it that way and never commit real credentials. |

## Before adding a real backend or payments

If booking, accounts, or payments are introduced, revisit all of the above: move secrets to server-side environment variables, add authentication and access control on any admin route, sanitise and validate all input server-side, hash passwords, enable rate limiting and CORS rules, and run a full security review. These items are intentionally out of scope while the site remains a concept demo.
