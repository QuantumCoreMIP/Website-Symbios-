# Project Status — Symbios Site Rebuild

**Date:** 2026-07-11

## Just completed
- Full UI-parity pass against the live sites: per-brand accent palettes (main coral #F15C58, Fit taupe #A29382/#786c5f, Primary Care green #4EA647, Physio magenta #A81A8D, Aria cyan #1BBED5) via body classes; live Impreza typography (Cormorant h1 60px/h2 49px, accent-colored h3/h4/eyebrows); topbar CTA buttons (brand + dark); curved SVG hero divider on all 5 homepages; italic hero phrase on main; What-We-Do rebuilt as icon boxes with hand-drawn SVG line icons (live uses FA Pro Light — not redistributable, so drawn from scratch); LEARN MORE text links; white/gray outline buttons; brand-color subscribe band with email_signup.png image button; Google Maps embed on homepage; SVG social icons in all footers; header made static (live is non-sticky). All 44 pages verified locally: zero broken/external images.
- All 156 hotlinked wp-content images/PDF downloaded and rehosted under `assets/wp/<host>/...`; every HTML reference rewritten to relative local paths (0 wp-content refs remain, all pages verified loading locally)
- Symbios Fit logo created from the client's original Edge logo (same icon, wordmark, tagline, colors; "Fit" in matching script) and applied to all 16 pages that used the text lockup
- Full static rebuild of mysymbios.com + all 4 sub-brand sites (44 pages), pushed to GitHub `main`
- Primary Care final pass merged: full 6-item services nav on all pages, men's health treatment links restored (link check clean)
- "SymbiosEdge / The Edge" rebranded to **Symbios Fit** throughout (text lockup logo, `/fit/` section, "Edge Rx" → "Fit Rx")
- All internal links verified (0 broken); per-brand phone numbers and CTAs verified against live site

## In progress
- Nothing in flight

## Next steps
- Client review of flagged items (see README "Outstanding items"): Fit logo asset, Fit social handles, "Fit Rx" / "The Mobility Edge" naming, past-dated webinar on advanced-ed-solutions page
- Wire the static forms to a handler
- Decide hosting/domain for Fit (fit.mysymbios.com) and DNS cutover plan
- athenahealth API: if pursuing integration, register at developer portal (Preview sandbox is self-service; production needs practice authorization + BAA)
