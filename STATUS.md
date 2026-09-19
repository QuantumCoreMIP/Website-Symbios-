# Project Status — Symbios Site Rebuild

**Date:** 2026-09-18

## 2026-09-19 - client sent the approved logo set and a women's health messaging draft
- Dr. Luther replied to the brand-guide email with `Symbios Health Logos Darla.zip` (six PNGs, 2000x667, transparent, about 6.7 in at 300 dpi) and said the brand work was three months with Darla (Kirchner Marketing). Still raster, no vector. Saved to `Brand/approved-logos-darla-2026-09-19/`.
- The approved artwork disagrees with the guide's own swatches on two colors: PrimaryCare green in the logo is #4ea647 (guide swatch #4fa317) and Aria cyan is #1bbed5 (guide swatch #08bed5). Our original site values were sampled from the logos and were therefore right; yesterday's swatch alignment made the PrimaryCare page accent yellower than the logo in its own header. Decision pending with Nick/Scott on which is master. Health, PhysioTherapy, and Fit match within 8/255.
- Layout differences: the approved set has no tagline on Health, PrimaryCare, PhysioTherapy, or Fit (only Aria), and Health is a stacked layout with "Health" dropped below. The site uses the inline-with-tagline versions, which also appear in the guide (pages 10 and 11) and in Dr. Luther's own email signature. Confirm which layout is canonical for headers.
- Built `Brand/Symbios-Logo-Decisions.pdf` (5 pages, MIP style): guide vs approved zip vs live site side by side with the mismatches flagged per brand, then nine checkbox decisions for Dr. Luther with our recommendation on each. Live-site logos were pulled fresh the same day (`Brand/live-site-logos-2026-09-19/`); theedge.mysymbios.com still serves the SymbiosEdge logo. Measured tagline geometry: PhysioTherapy's tagline is centered under "Physio" and ends at 75% of the width while Health, PrimaryCare, and Aria are right-aligned to the edge; Health's tagline x-height is about 8% of logo height vs 6% on Aria.
- Added `CONTEXT.md` at the repo root as the handoff for parallel sessions: what was done and why, open client decisions, direction, email status, house rules.
- `SymbiosWomensHealth_Messaging.pdf` (Kirchner Marketing, June 2026, draft): proposes a women's health program named SymbiosHer (alternatives: Symbios Women's Health, SymbiosGrace), StoryBrand messaging, and a "Women's Health Repository" of physician-approved education content. Implies a future page, logo, and content library; not in current scope. Saved to `Brand/`.

## 2026-09-18 - brand guide pass (client's Symbios Brand Guide, 11 pages, saved to Brand/)
- Colors: style.css and the two inline spots (home doors, 404 buttons) now use the guide's exact hex values: coral #f15b57, green #4fa317, magenta #a7228b, cyan #08bed5, slate #4e5859. Previously each was a near-miss (#F15C58, #4EA647, #A81A8D, #1BBED5, #4D585A).
- SymbiosFit: the guide's Fit brand is blue #2f6fa3 (taupe #a39383 is only its gradient background) and its Fit logo is a blue brush script with no tagline. Replaced our Edge-derived taupe logo with the guide's own artwork (`assets/symbiosfit_logo.png`, 1543x346, 31 refs) and set `body.brand-fit` to #2f6fa3 / deep #25598a. The old `symbiosfit_tagline.png` files stay in assets but are unreferenced.
- Headline type: the guide specifies Zodiak, which is free on Fontshare (ITF Free Font License). Self-hosted 400/700 + italics in `assets/fonts/` with @font-face; `--font-heading` is now Zodiak with Cormorant Garamond as fallback. Body stays Montserrat as the stand-in for Gotham (paid).
- Copy: 15 leftover "MedSpa by Symbios" mentions on the med spa pages and blog changed to SymbiosAria; the blog's quoted tagline now matches the guide's "Healthy, fit and beautiful for life".
- Guide findings for the client (not fixable on our side): logos are raster only (max 1543 px wide, about 5 in at 300 dpi), no Pantone, no CMYK for Fit blue, hex and CMYK pairs do not round-trip (cyan and green shift visibly), the Zodiak and Futuristic Stylish specimens in the guide are actually set in Montserrat and IBM Plex Sans Condensed, and the mood boards use watermarked Shutterstock comps. Higher-resolution lockups extracted from the guide are in `Brand/guide-logo-exports/`.

## 2026-09-18 - SymbiosHealth logo reverted to the client's original
- The July 12 redraw (`d45a3bc`, `assets/symbioshealth_tagline.png`) set "Health" in Yellowtail and painted it at full opacity using the alpha-unmixed stroke color (#e80400), so it rendered fire-engine red instead of the brand coral (#f15b57; the original's strokes are #e80400 at ~65% alpha, which composites to #f05b58). The heavier script also matched the thin PrimaryCare/PhysioTherapy scripts worse, not better.
- All 32 header, footer, intro, and JSON-LD references now point back to the client's own `/assets/wp/www.mysymbios.com/2021/12/symbiosmain_tagline.png` (identical across all five hosts). The redrawn file is removed. Same 430x107 dimensions, so no sizing changes.
- Known flaw left as-is (it is their mark): the tail of the "H" dips into the tagline under "beautiful". That belongs with the vector cleanup already requested from their designer (see ToDoList).

## 2026-09-09 - site-wide em dash removal (`99c2dde`)
- Removed all 112 em dashes across 42 deployed pages (literal U+2014 and `&mdash;`), including blog/article pages. Zero remain in non-`Reports/` HTML (independently re-verified).
- Rule applied: spaced dashes in meta descriptions and headings (topic-to-detail separators) became colons; tight `word—word` dashes in body copy became commas. Spot-checked, reads cleanly. 113 en dashes in number ranges intentionally left intact per house style.
- Client intel from a forwarded email (2026-09-09), acted on separately in a review for the user: their CMO is leaving (0 marketing staff soon), a CMO-started website redesign is due end of month, they are replacing FitBud + PatientNow + **ActiveCampaign with Zenoti** and adding HeadsUp, and they want a Thursday 2:30-3:00 call covering ongoing "site overlay" maintenance. **Open decision:** the proposal's forms are wired to ActiveCampaign embeds (ids 3/15/20/21), which the client is retiring; form integration must move to Zenoti (self-serve REST API, webhooks, booking widget, HIPAA-ready intake) before launch.

## 2026-08-01 — reception.ai crawl unblocked (robots.txt + sitemap, BOTH TEMPORARY)
- **Root cause was misdirection, not exclusion.** The first theory (staging `robots.txt` serving `Disallow: /`) was wrong — flipping it to `Allow: /` (`9aa8d92`) changed nothing; the crawl still returned title/meta only. Render *did* redeploy, and `symbios.onrender.com` serves 200s with no anti-bot layer.
- **Actual chain:** crawler reads the root fine, then follows `Sitemap: https://www.mysymbios.com/sitemap.xml` -> 301 -> the old WordPress Yoast sitemap index. All 47 `<loc>` entries in our own `sitemap.xml` also pointed at `www.mysymbios.com`. **That host sits behind a Cloudflare challenge** (returns HTTP 200 with an "Attention Required!" interstitial, so status checks look healthy). Every URL the crawler discovered was unreadable, so it gave up after the root document.
- **Fix (`6572e19`):** repointed the `Sitemap:` directive and all 47 `<loc>` entries at `symbios.onrender.com`. Staging subpages verified serving real content — `/about-us/` 16KB, `/primary-care/` 13.6KB, `/physiotherapy/` 13.4KB, `/fit/` 12.9KB, `/medspa/` 13.7KB.
- Ruled out: no `canonical` or `og:url` tags on any of the 48 pages; no `X-Robots-Tag` header config; `noindex` only in `404.html` (intentional) and `SEO-REVIEW.md` (docs).
- **Crawl succeeded, and both temporary changes are REVERTED (`a745941`).** `robots.txt` and `sitemap.xml` are byte-identical to their pre-crawl state (`8cb35a1`) — staging is blocked again and the 47 `<loc>` entries point back at `www.mysymbios.com`, which is correct at launch. Nothing temporary is left in the repo.
- **Flagged for later:** the intro overlay is opaque, `z-index:9999`, and scroll-locks the page for ~10.4s. Content sits beneath it in the DOM (4,323 chars of `innerText`), so text extractors are fine, but any **screenshot-based** crawler or preview bot will capture a blank cream screen. Worth a `prefers-reduced-motion`-style bailout for bot user agents before launch.
- Repo re-cloned fresh to `C:\dev\Website-Symbios-` from `github.com/QuantumCoreMIP/Website-Symbios-`.

## 2026-07-18 — SymbiosHealth logo sizing, rest of site
- Audited every SymbiosHealth lockup instance (25 across 15 files): **header** (9), **footer** (9), **brand strip** (6), **intro animation** (1).
- **Brand strips fixed** — the one place the Health lockup sits beside the sub-brand lockups. `max-height:80px` rendered it 321px wide vs 258px for the others (same 430x107 vs 345x107 aspect cause as the header). Live constrains brand logos by `max-width` instead, so switched to `max-width:260px`. Every strip logo is now a uniform 260px wide (heights vary by aspect, as on live).
- **Header** (80px main / 100px sub-brand, all ~322px wide) and **footer** (`max-width:220px`, already identical to live's rule) were already correct — unchanged.
- Verified across 13 pages: header 321x80 on root pages, 322x100 sub-brands (Aria 336x100); strips uniform 260px; footers uniform 220px.

## 2026-07-18 — dropdown typography
- Dropdown links now match the top-level nav exactly: **13px / weight 500 / uppercase / .05em** (were .9rem, mixed case, weight 300 inherited from body). Live styles the whole menu as one unit so both levels share type; the rebuild had only styled level 1. Verified identical computed type on the main site and sub-brands.
- **Resolved:** dropdown items stay **mixed case** (per user). They match the top-level nav on family/size/weight/letter-spacing; case is the only intentional difference, so the one-word brand names keep their camelCase break (`PrimaryCare`, not `PRIMARYCARE`).

## 2026-07-18 — header logo sizing + dropdown animation
- **Logo sizing corrected to the live spec.** The live sites size each lockup so every brand's header logo lands at ~322px wide: main site 80px tall (430x107 source), sub-brands 100px (345x107) at >=1381px, 80px below. The rebuild used a flat 80px everywhere, which made the wider SymbiosHealth lockup render 321x80 vs 258x80 for the others — reading ~24% larger. Now verified at 1500px: Health 321w, PrimaryCare/PhysioTherapy/SymbiosFit 322w, SymbiosAria 336w.
- **Nav dropdowns now unroll** like the live nav (Impreza `dropdown_height`): `scaleY(0)->1` from the top edge + opacity fade, .3s. Replaces the instant `display:none/block`. Added `:focus-within` for keyboard users, a `prefers-reduced-motion` opt-out, and a transform reset for the mobile stacked menu.
- Not exercised live: the hover animation itself couldn't be triggered in the automation context (Browser pane wasn't compositing, so pseudo-classes/style recalc are frozen). Resting state and rule matching were verified programmatically; **worth a quick eyeball in a real browser.**

## 2026-07-18 — SymbiosFit phone correction
- **Client correction: SymbiosFit line is (843) 738-4600, not 4604.** Updated all 57 occurrences site-wide — topbars/footers on the 11 fit pages, every `tel:` link, the homepage LocalBusiness department schema, llms.txt, README, SITE-SPEC, SEO-REVIEW — so NAP stays consistent. Verified 0 stale `4604` remain.
- Removed the Port Royal Plaza address from the SymbiosFit card in the homepage "Where Would You Like to Start?" grid so all four campus cards match. The satellite address intentionally remains in the /fit/ footers, fit map embed, and JSON-LD.
- Repo moved to `C:\dev\Symbios` (was Downloads\brooke fin); preview launch.json path updated.

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
- Nothing in flight — the reception.ai crawl is done and both temporary staging changes have been reverted.

## Next steps
- Before launch: give the intro overlay a bot bailout so screenshot-based crawlers and link-preview bots don't capture a blank cream screen
- Note for cutover: `www.mysymbios.com` is behind a Cloudflare challenge that returns HTTP 200 with an interstitial body — any crawler or uptime check pointed at it will silently get a block page
- Client review of flagged items (see README "Outstanding items"): Fit logo asset, Fit social handles, "Fit Rx" / "The Mobility Edge" naming, past-dated webinar on advanced-ed-solutions page, and whether to carry over UserWay / GA4 / header search / blog pagination
- Migrate the 4 women's sexual-health treatment pages (FemiLift, O-Shot, Alma Duo for Enhanced Sexual Function, PRP Wing Lift) — tiles currently link to the live site
- Decide hosting/domain for Fit (fit.mysymbios.com) and DNS cutover plan; forms now use the client's ActiveCampaign embeds, so no separate form backend is needed
- athenahealth API: if pursuing integration, register at developer portal (Preview sandbox is self-service; production needs practice authorization + BAA)
