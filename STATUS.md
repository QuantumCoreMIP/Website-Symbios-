# Project Status — Symbios Site Rebuild

**Date:** 2026-07-13

## 2026-07-13 — PrimaryCare consultation + copy fix
- Added ToDoList.md (SymbiosFit hours tabled there per client), branded 404.html (Render serves it automatically), and REDIRECTS.md — full 301 map for old subdomain + www URLs ready for Cloudflare/Render at cutover
- SymbiosFit real address applied (Port Royal Plaza, 95 Mathews Dr, Suite D3): all 11 fit footers, fit homepage map embed, fit JSON-LD (stale campus geo dropped), gateway door card + department schema, llms.txt
- PrimaryCare now has its own green-branded /primary-care/request-a-consultation/ (form, hours, new-patient-forms link); all 10 PrimaryCare pages retargeted off the SymbiosHealth form
- Gateway and llms.txt: removed "one address" claim (SymbiosFit has a nearby satellite space); sitemap regenerated (47 URLs)

## 2026-07-12 — campus gateway homepage
- Final link sweep: 46 pages internal links/assets all resolve; 28 unique external URLs verified live (initial 403s were the live site WAF rate-limiting the checker) — one real 404 found and unlinked (past-dated /event/ webinar on advanced-ed-solutions); sitemap.xml regenerated (46 URLs), robots.txt staging-blocked with flip-at-launch note, llms.txt added
- Client feedback: brand names rendered as one word (SymbiosHealth, PrimaryCare, PhysioTherapy, SymbiosFit, SymbiosAria) in the campus bar, nav dropdowns, door buttons, footer brand lines, copyrights and intro kicker — 519 references across 46 pages; prose sentences untouched
- Hero second CTA fixed (was white-on-white via .btn-outline collision) with new .btn-ghost class; mobile audit: newsletter signup image was forcing 65px horizontal overflow at 375px — capped with min(420px,100%); hamburger/doors/brand-bar verified good on mobile
- Intro exit smoothed: scrollbar-gutter reserved during lock (was causing a 15px mid-fade layout shift), scroll unlock deferred until fade completes, fade lengthened to 1.2s with will-change compositing
- Intro rebuilt as a title sequence after feedback (corner fly-in read as cheap; flex bug jumbled the tagline): kicker + hairline rule, brands shown one at a time at 440px, word-by-word tagline, Symbios lockup, soft fade exit (~10.4s, skippable)
- Intro logos enlarged to 400px with a new hold phase: fly in to a 2x2 spread, hold readable ~1.7s, then converge; Symbios logo also 400px; total sequence ~9.2s
- Intro animation fixes after live review: convergence point was 325px off-center on desktop (min() vs transform centering bug) — now transform-centered at all widths; timeline slowed from ~4.4s to ~7.6s
- Root homepage is now a neutral Symbios campus gateway: hero ("One Campus. Every Dimension of Your Health."), four brand door panels with accent colors/services/phones, one-team section, testimonials, map
- Intro animation overlay: brand logos converge into Symbios, tagline slides in, logo rises, curtain lift (~4.4s); skippable, once per session (sessionStorage), honors prefers-reduced-motion, content rendered beneath for SEO
- Root JSON-LD now lists the four sub-brands as department entries

## Just completed
## 2026-07-12 — brand-consistency + SEO round
- Newsletter eyebrow reworded: "We don&#39;t keep secrets" (odd tone for a medical campus) is now "Wellness tips from our experts" on all 46 pages
- Cross-brand navigation: persistent dark campus-switcher bar on all 46 pages (current brand highlighted); "Our Brands" renamed "Our Campus" in nav and section headings
- Fixed 1,328 doubled-quote attribute bugs left by the clean-URL rewrite (44 files)
- Rebuilt Symbios Health logo script word "Health" in Yellowtail to match Therapy/Care (assets/symbioshealth_tagline.png, 21 refs updated)
- Footers: brand name above address + brand-matched copyrights (SymbiosAria/SymbiosFit/PrimaryCare/PhysioTherapy by Symbios Health)
- Removed the Home nav item on all pages (logo is the home link)
- Aria-branded /medspa/about-us/ and /medspa/request-a-consultation/ (live med spa content, cyan Aria scheme); all med spa CTAs now stay in-brand
- SEO: per-brand LocalBusiness JSON-LD on the 5 index pages, sitemap.xml (46 URLs), robots.txt (staging-blocked until cutover), 3 NAP phone fixes; full audit in SEO-REVIEW.md

- Clean URLs for Render hosting: all 39 non-index pages moved to `slug/index.html` folders, every internal link/asset/background rewritten to root-absolute paths with no `.html` (e.g. `/primary-care/mens-health/`); verified all 44 clean URLs + assets resolve locally
- Root `favicon.ico` added (from the Symbios icon) alongside the per-brand `<link rel="icon">` tags
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
