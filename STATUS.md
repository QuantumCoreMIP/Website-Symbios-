# Project Status — Symbios Site Rebuild

**Date:** 2026-07-11

## Just completed
- Detailed 44-page parity pass against the live sites (5 parallel audits + fixes):
  - Header corrected to live spec: cream 41px topbar, WHITE 120px nav row, 80px logo, cream dropdowns w/ brand hover; body type 17px/26px
  - Rotating hero sliders on all 5 homepages (Royal Slider timing: 1s fade / 3s autoplay); Google Maps section added to the 4 sub-brand homepages
  - Inner pages rebuilt to live pattern: flat brand-color h1 title band + intro photo as left split column (29 pages); root inner bands coral
  - Forms wired to the client's real ActiveCampaign embeds (request-an-appointment id20, fit consultation id20, physio appointments id21, email signups id3/id15) + Dover job-board iframe on careers — resolves the "forms need a handler" punch-list item
  - Primary Care: 4 dark brand bands, 2 misplaced images moved to "How It Works" sections, alternation fixes, 4 sexual-health tiles linked (to live pages pending migration)
  - Physio: homepage section order fixed, invented 7th card removed, Why-Choose images flipped right on 5 pages, 2-col service lists, 3-col offer grids, live metas restored
  - About pages: team cards converted to live View Bio popup modals (verified working)
  - Live footers replicated (logo left, right-aligned address/socials/per-brand copyright), per-brand favicons, en-dash titles, brand-first index titles, nav dropdown trimmed to live's 5 items, invented CTAs/cards/sections removed, Aria header logo corrected to arialogo-1.png
- Items intentionally NOT carried over (flag to client): UserWay accessibility widget, GA4 tag, header search overlay, blog pagination pages 2–17 (outbound link instead), blog-single category sidebar on the ED post
- Brand logo PNGs (18 files: main/primary-care/physio/aria taglines across all hosts) converted from white-background to true transparency (alpha unmix), matching the Fit logo — brand strips and headers now blend into the cream sections
- Live-site animations replicated in assets/site.js + CSS: scroll-reveal fade-up/fade-left (Impreza us_animate_this afb/afl), staggered grid/brand-strip items, hero intro animation, back-to-top arrow button; respects prefers-reduced-motion; wired into all 44 pages
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
- Client review of flagged items (see README "Outstanding items"): Fit logo asset, Fit social handles, "Fit Rx" / "The Mobility Edge" naming, past-dated webinar on advanced-ed-solutions page, and whether to carry over UserWay / GA4 / header search / blog pagination
- Migrate the 4 women's sexual-health treatment pages (FemiLift, O-Shot, Alma Duo for Enhanced Sexual Function, PRP Wing Lift) — tiles currently link to the live site
- Decide hosting/domain for Fit (fit.mysymbios.com) and DNS cutover plan; forms now use the client's ActiveCampaign embeds, so no separate form backend is needed
- athenahealth API: if pursuing integration, register at developer portal (Preview sandbox is self-service; production needs practice authorization + BAA)
