# SEO Review — Symbios Health Static Rebuild

**Site:** `symbios-fit-site` (46 pages, static, clean URLs `folder/index.html`)
**Target domain:** www.mysymbios.com (subdirectory architecture for the 4 sub-brands)
**Audited:** 2026-07-12 · All 46 pages machine-scanned; ~14 pages inspected in depth (5 section indexes, 2+ inner pages per section, blog, request-an-appointment)
**Note:** This is a report-only audit. The main session is concurrently adding per-brand LocalBusiness JSON-LD to the 5 index pages (already present at scan time), plus `sitemap.xml` and `robots.txt` (appeared mid-audit). Those are marked "in progress" below.

---

## Executive Summary

This rebuild is in **very good SEO shape for a pre-launch static site** — dramatically better than typical WordPress migrations. Fundamentals are already solid: exactly **one H1 on all 46 pages**, **100% image alt-text coverage**, unique titles and meta descriptions on every page, `lang="en"` and mobile viewport everywhere, per-brand favicons, all images rehosted locally (zero hotlinks), no orphan pages, and cross-brand "Our Brands" navigation on every page. The subdirectory architecture (`/fit/`, `/primary-care/`, `/physiotherapy/`, `/medspa/`) is the correct long-term call and consolidates authority that is currently fragmented across four subdomains.

The remaining gaps are concentrated in four areas:

1. **Launch-critical redirects.** The live site's link equity lives on `theedge.` / `primarycare.` / `physiotherapy.` / `medspa.mysymbios.com`. Without a complete 301 map at DNS cutover, existing rankings are lost. Additionally, the rebuilt `/blog/` page links to 16 post URLs on `www.mysymbios.com/<slug>/` that **will 404 the moment this site replaces the live one** unless the posts are migrated or redirected.
2. **Missing head-level tech:** canonical tags (0/46 pages), Open Graph/Twitter cards (0/46), and staging noindex protection for the temporary `*.onrender.com` URL.
3. **Title/description tuning:** ~10 titles exceed 60 chars (physiotherapy's brand-first pattern is the worst offender), the homepage title is a near-useless "Home – Symbios Health", and 18 descriptions exceed ~165 chars.
4. **Local SEO execution:** NAP is 95% consistent (three wrong-phone-number instances found), and the biggest untapped win is **four separate Google Business Profiles** — one per brand — which the distinct names/phones/entrances support (plan in its own section below).

Performance is acceptable (16 MB total assets, only 3 files >300 KB) but no lazy loading and no WebP leaves easy Core Web Vitals points on the table.

---

## Prioritized Action Table

| # | Action | Impact | Effort | Notes |
|---|--------|--------|--------|-------|
| 1 | Build the 301 redirect map (old subdomains → subdirectories) and deploy at cutover | **High** | Med | See Launch Checklist. Render supports a `_redirects`-style rules file / `render.yaml` |
| 2 | Migrate or 301 the 16 blog posts linked from `/blog/` — they point at `www.mysymbios.com/<slug>/` and will 404 post-launch | **High** | Med | e.g. `/the-real-story-on-glp-1-medications…/`, `/cholesterol-metabolic-health-heart-risk/` |
| 3 | Noindex the Render staging URL (`X-Robots-Tag: noindex` or conditional robots.txt) until DNS cutover | **High** | Low | `robots.txt` currently says `Allow: /` — correct for prod, dangerous on `*.onrender.com` |
| 4 | Add `<link rel="canonical">` to all 46 pages | **High** | Low | Currently 0/46. Absolute URLs on `https://www.mysymbios.com` |
| 5 | Create 4 separate Google Business Profiles (one per brand) + keep/claim the Symbios Health parent | **High** | Med | Full plan below. Distinct phones already exist (4800/4600/4300/4000) |
| 6 | Fix homepage title (`Home – Symbios Health`) and normalize physiotherapy brand-first titles to keyword-first | **High** | Low | Details in §1 |
| 7 | Fix 3 wrong/inconsistent phone instances (fit consult page, physio appointments page, dotted format on advanced-ed page) | **Med** | Low | Details in §6 |
| 8 | Add BreadcrumbList JSON-LD + FAQPage on treatment pages with FAQ sections + MedicalWebPage on service pages | **Med** | Med | LocalBusiness on 5 indexes already in progress |
| 9 | Add Open Graph + Twitter Card tags site-wide | **Med** | Low | 0/46 today; matters for social shares of blog/med-spa content |
| 10 | Add `loading="lazy"` to below-fold images; convert 3 largest PNGs (1.2 MB, 720 KB, 492 KB) to WebP | **Med** | Low | 0 of ~250 `<img>` tags lazy-load today |
| 11 | Trim 18 meta descriptions >165 chars (worst: sexual-health 218, medspa index 207) | **Med** | Low | Details in §2 |
| 12 | Migrate the 4 women's sexual-health treatment pages (FemiLift, O-Shot, Alma Duo, PRP Wing Lift) currently linking to `primarycare.mysymbios.com` | **Med** | Med | Already on STATUS.md next-steps; also an SEO issue (equity leaks + subdomain will die) |
| 13 | Migrate blog pages 2–17 (or at minimum the 10 highest-traffic posts) with `Article` schema and author bylines | **Med** | High | Only page 1 exists; "More Articles" links off-site |
| 14 | Add a dedicated GLP-1 / medical weight loss page targeting "GLP-1 Hilton Head", "weight loss program Hilton Head" | **Med** | Med | Keyword gap; Fit Rx page is men-only and the GLP-1 post is off-site |
| 15 | Preload hero background images (22 inline CSS `background-image` heroes = undiscoverable LCP) | **Low** | Low | `<link rel="preload" as="image">` per page |
| 16 | Add a 404 page (`404.html`) | **Low** | Low | None exists; Render serves a bare default |
| 17 | Fix H2→H4 heading skips (card grids use `<h4>` with no `<h3>` ancestor) | **Low** | Med | Cosmetic; not a ranking factor but easy during other edits |

---

## Findings by Dimension

### 1. Title Tags

**Good:** All 46 titles are unique. Most follow a consistent `Page – Brand` pattern with en-dashes. Location targeting is present on most money pages (e.g. `Nutritional Health on Hilton Head Island, SC – Primary Care by Symbios Health`, `Symbios Aria – Medical Spa on Hilton Head Island`).

**Issues:**

- **Homepage title is the weakest on the site:** `index.html` → `Home – Symbios Health` (21 chars, no keywords, no location). Recommend: `Symbios Health – Medical & Wellness Campus | Hilton Head Island, SC` or similar.
- **~10 titles exceed 60 chars** (truncated in SERPs). Worst offenders:
  - `advanced-ed-solutions/index.html` — 91 chars (`Reclaim Your Confidence This Men's Health Month with Advanced ED Solutions – Symbios Health`); also references a past "Men's Health Month" (dated content, already on the client-review flag list)
  - `fit/index.html` — 82 chars (`Symbios Fit by Symbios Health – Everyday Living Programs on Our One-of-Kind Campus`; also a typo: "One-of-Kind" → "One-of-a-Kind"); no location keyword — recommend `Symbios Fit – Fitness & Wellness Programs | Hilton Head Island, SC`
  - `physiotherapy/lymphedema-management/index.html` — 78 chars, and **brand-first**: `Physio Therapy by Symbios Health – Lymphedema Management in Hilton Head Island`. The keyword is pushed past the truncation point.
- **Inconsistent pattern within the physiotherapy section:** `lymphedema-management` and `pelvic-floor-therapy` are brand-first while `pain-injury-rehabilitation`, `sports-injury-recovery` etc. are keyword-first. Normalize all to keyword-first: `Lymphedema Management in Hilton Head Island, SC – Symbios Physio Therapy` (still 73 — consider dropping "in" and ", SC" strategically).
- Several strong pages lack location in the title where there's room: `medspa/injectables-fillers/` (42 chars — room for "Hilton Head"), `primary-care/sick-care/` (42), `primary-care/the-p-shot/` (43).

### 2. Meta Descriptions

**Good:** 46/46 present, all unique, all handwritten (not boilerplate), most include "Hilton Head Island, SC" and brand. This is far above average.

**Issues:**

- **18 descriptions exceed ~165 chars** and will be truncated. Worst: `primary-care/sexual-health/` (218), `medspa/index.html` (207), `primary-care/family-internal-medicine/` (207), `medspa/body-contouring-treatments/` (201), `primary-care/priapus-toxin-for-erectile-dysfunction/` (201). Trim to ≤160 keeping the location + CTA up front.
- `privacy-policy/index.html` is only 58 chars — fine for a legal page, no action needed.
- Homepage description contains "physio therapy" as two words where it means the generic service ("Primary care, physio therapy, fitness…") — reads like a typo to searchers; use "physical therapy" for the generic term (that's also the search term people use).

### 3. Heading Hierarchy

**Good:** Exactly **one H1 on every one of the 46 pages** (verified by scan). H1s are descriptive and match page intent (`Vampire Face Procedures (PRP treatments)`, `Healthy Weight Loss for Men with Fit Rx`, `Pelvic Floor Therapy`). Logical H2 sections mirror the live site.

**Issues (minor):**

- **Site-wide H2→H4 skip:** card grids and FAQ items use `<h4>` directly under `<h2>` with no `<h3>` (e.g. `index.html` "What We Do" → six `<h4>`s; `medspa/prp-vampire-treatments/index.html` FAQ answers under `<h2>Frequently Asked Questions` are `<h4>`s). Not a ranking factor, but flagged for accessibility audits.
- **`<h4>` misused as a styled paragraph** for closing CTAs on most service pages, e.g. `primary-care/mens-health/index.html`: `<h4 style="margin-top:24px">Contact us today to schedule your private Men's Health consultation.</h4>` — this is body copy, not a heading.
- `request-an-appointment/index.html` jumps H1→H3 (`<h3>You deserve care that feels clear…`) with no H2 until the subscribe band.

### 4. Image Alt Text

**Excellent: 0 missing alt attributes across all ~250 `<img>` tags on 46 pages.** Spot-checked quality on `index.html` is good — descriptive and specific (`Symbios Fit - Healthy, fit and beautiful for life`, `Golf, Tennis & Pickleball Health`), not keyword-stuffed.

**Notes:**

- 22 hero images are inline CSS `background-image` (all 5 homepages' sliders + inner-page heroes). These convey no alt text and are invisible to image search — acceptable for decorative heroes, but it means the most visually distinctive campus/facility photos aren't indexable. Consider `<img>` with `object-fit: cover` for the single-image inner-page heroes, or at minimum keep meaningful photos in `<img>` elsewhere on the page (about pages already do this).
- Alt text could work location in on a handful of key images (e.g. campus photo alt "The Symbios Health campus" → "Symbios Health campus at 460 William Hilton Parkway, Hilton Head Island").

### 5. Internal Linking

**Good:**

- **No orphan pages.** Every one of the 46 URLs has inbound links (minimum 2).
- **Cross-brand linking is structural:** every page carries an "Our Brands" dropdown linking the other four sections (verified in `medspa/index.html` nav), plus the root homepage's "Our Brands" section links all four sub-brands with descriptive anchor text. This is exactly the cross-linking benefit of the subdirectory move.
- Section indexes are well-linked hubs: `/fit/` 63 inbound, `/medspa/` 61, `/physiotherapy/` 54, `/primary-care/` 54.

**Issues:**

- **Weakly linked pages:** `/advanced-ed-solutions/` (2 inbound — only from `/blog/`), `/primary-care/erectile-dysfunction-ed/` (5), `/primary-care/priapus-toxin-for-erectile-dysfunction/` (5), `/primary-care/the-p-shot/` (6). The ED cluster would benefit from cross-links between its own pages (ED hub ↔ P-Shot ↔ Priapus Toxin ↔ advanced-ed-solutions article) — a natural topic cluster that's currently only loosely stitched via `/primary-care/mens-health/`.
- **16 blog-card links on `/blog/index.html` point to the live domain** (`https://www.mysymbios.com/<slug>/`, `target="_blank"`) plus a "More Articles on mysymbios.com" link to `/blog/page/2/`. Fine for the staging period; **broken the day this site takes over the domain** (see Launch Checklist).
- **4 sexual-health tiles on `primary-care/sexual-health/index.html` link to `primarycare.mysymbios.com`** (femilift, the-o-shot, alma-duo, vampire-prp-winglift) — known pending migration; these leak users to a subdomain that will be redirected away at launch.
- Anchor text is generally descriptive (service names). No "click here" antipatterns found.

### 6. Local SEO — NAP Consistency

**Address: fully consistent.** `460 William Hilton Parkway, Hilton Head Island, SC 29926` appears in 49 visible instances + 5 JSON-LD instances with zero variants. Excellent.

**Phones: consistent per brand with 3 exceptions:**

| Brand | Correct number | Status |
|---|---|---|
| Symbios Health (root) | 843-738-4800 | Consistent (root pages also correctly reference the four brand lines) |
| Symbios Fit | 843-738-4600 | 22 of 23 tel links correct — **exception below** |
| Primary Care | 843-738-4800 | Fully consistent (20/20) |
| Physio Therapy | 843-738-4300 | 18 of 19 correct — **exception below** |
| Symbios Aria (medspa) | 843-738-4000 | Fully consistent (17/17) |

Exceptions found:

1. **`fit/request-a-consultation/index.html` line 72:** "Call `tel:+18437384800` 843-738-4800" — the Fit consultation page uses the main campus line, and its meta description repeats it ("Call 843-738-4800"). If the live Edge site used 4800 here this may be intentional, but every other Fit page (including its own topbar) says 843-738-4600. Confirm with client; make consistent either way.
2. **`physiotherapy/appointments/index.html` line 69:** same pattern — body copy says 843-738-4800 while the page's own topbar/footer say 843-738-4300.
3. **`advanced-ed-solutions/index.html` line 103:** dotted format `843.738.4800` — the only dotted instance on the site. Normalize.

Also: two display formats coexist site-wide — `(843) 738-XXXX` (topbars) and `843-738-XXXX` (body/footers). Citation-consistency purists standardize on one; at minimum keep each brand's GBP listing format matching the site's dominant format.

**JSON-LD phones** (in-progress schema on the 5 indexes) are all correct per brand — good.

### 7. Technical SEO

| Item | Status | Detail |
|---|---|---|
| Canonical URLs | ❌ **Missing on all 46 pages** | Add `<link rel="canonical" href="https://www.mysymbios.com/<path>/">`. Critical because the site will be reachable at both `*.onrender.com` and the real domain, and Render may serve both `https`/`http` and trailing-slash variants |
| sitemap.xml | ✅ Just added (in progress) | 46 URLs, absolute on `www.mysymbios.com`, correct format. Consider adding `<lastmod>` |
| robots.txt | ✅ Just added (in progress) | `Allow: /` + sitemap reference. **Correct for production only** — see staging noindex note in Launch Checklist |
| Favicon | ✅ | Root `favicon.ico` + per-brand `<link rel="icon">` on every page (e.g. medspa uses `icon_MedSpa-150x150.png`, fit uses `TheEdge_icon-150x150.png` — consider renaming the fit icon file post-rebrand) |
| Mobile viewport | ✅ 46/46 | |
| `lang` attribute | ✅ 46/46 `lang="en"` | |
| Open Graph / Twitter cards | ❌ 0/46 | Add `og:title`, `og:description`, `og:image` (per-brand logo or hero), `og:url`, `og:type`, `twitter:card` |
| Page weight | ✅ Good | 16 MB total assets for 46 pages; all images local (zero hotlinks — the 156 wp-content images were rehosted under `assets/wp/`). Only 3 files >300 KB: `assets/wp/www.mysymbios.com/2026/03/Carbs-vs.-Fats…-1024x1024.png` (1.2 MB), `Cholesterol-and-Heart-Health-1024x1024.png` (720 KB), `primarycare…new_homeslider.jpg` (492 KB) |
| Lazy loading | ❌ 0 images | Add `loading="lazy"` to all below-fold `<img>` (blog cards, team photos, service grids). Keep hero/above-fold images eager |
| Modern formats | ❌ | 183 JPG/PNG, 0 WebP/AVIF. Converting just the 3 largest files recovers ~2 MB |
| LCP discoverability | ⚠️ | 22 heroes load via inline `style="background-image:url(…)"` — the browser preload scanner can't see them. Add `<link rel="preload" as="image" href="…">` in each page's head, or convert to `<img>` |
| 404 page | ❌ | No `404.html`; Render will serve its default |
| GA4 / analytics | ⚠️ Intentionally omitted | On the client-review flag list; needed before launch to preserve measurement continuity |

**Domain strategy — subdirectories vs subdomains (recommendation: subdirectories, as built).**
The legacy site splits authority across `theedge.` / `primarycare.` / `physiotherapy.` / `medspa.mysymbios.com`. Google treats subdomains largely as separate sites: each accrues its own link equity, each needs its own Search Console property, and none reinforce the others. The rebuild's `/fit/`, `/primary-care/`, `/physiotherapy/`, `/medspa/` structure consolidates all inbound links and content depth onto one domain — the single biggest structural SEO win of this project. For a 46-page site with one physical location and one parent brand, there is no argument for keeping subdomains. **The cost is the migration itself:** every old subdomain URL must 301 to its new subdirectory URL (mapping in the Launch Checklist), and the four old subdomains must keep resolving (with redirects) indefinitely — do not let their DNS records lapse.

### 8. Content Opportunities

- **Blog depth:** only page 1 of the blog is migrated (`blog/index.html`, 12 post cards); the live site has **pages 2–17** (~150+ posts). That corpus is the site's long-tail organic engine — posts on GLP-1, ketogenic diet, cholesterol, sleep, TRT map directly to services. Migrate in priority order (check GA/GSC on the live site for the top performers), each with `BlogPosting` schema, author byline, and internal links to the relevant service page. Until then, the one migrated post (`/advanced-ed-solutions/`) is the only indexable article — and it's a dated seasonal piece ("This Men's Health Month") already flagged for client review.
- **Keyword gaps (high-intent local terms with no dedicated page or under-optimized page):**
  - **"med spa hilton head" / "medical spa hilton head island"** — `medspa/index.html` title (`Symbios Aria – Medical Spa on Hilton Head Island`) covers this reasonably; strengthen with H1 support (current H1 not brand+geo) and GBP.
  - **"physical therapy hilton head island"** — the section brands itself "Physio Therapy" (two words), which is not what Americans search. The index title wisely appends "Physical Therapy on Hilton Head Island"; ensure H1/body copy also use "physical therapy" (inner pages mostly do).
  - **"weight loss program hilton head" / "medical weight loss hilton head"** — `fit/healthy-weight-loss/` targets *men only* (Fit Rx). No page targets general/female weight-loss searchers.
  - **"GLP-1 hilton head" / "semaglutide hilton head"** — no on-site page; the GLP-1 article lives on the legacy domain. A service page ("Medically Supervised Weight Loss & GLP-1 Support") bridging primary care + Fit would own an uncontested local term.
  - **"botox hilton head"** — `medspa/injectables-fillers/` mentions Botox in the meta but not the title; title has 18 chars of headroom.
  - "pelvic floor therapy hilton head", "lymphedema therapist hilton head" — pages exist and are well-targeted; just fix the brand-first titles (§1).
- **E-E-A-T:** genuinely strong raw material — physician-led positioning, `Dr. Stephen Luther` named in medspa/primary-care metas and copy, team bio modals on the three about pages (`about-us/`, `fit/about-us/`, `medspa/about-us/`). To convert that into machine-readable E-E-A-T: add `Physician` schema for Dr. Luther (with `medicalSpecialty`, credentials, `sameAs` to any professional profiles), give each provider a crawlable bio (modal content is in the DOM — verify it's not JS-injected), add author bylines + reviewed-by lines on migrated blog posts, and cite the Runels certification claim on `medspa/prp-vampire-treatments/` ("the region's only provider certified by Dr. Charles Runels") with a verifiable link.

### 9. Schema / Structured Data

**In progress (main session):** per-brand LocalBusiness JSON-LD is now on the 5 index pages — `MedicalClinic` (root + primary care + physio), `ExerciseGym` (fit), `HealthAndBeautyBusiness` (medspa), each with correct per-brand phone, shared address, geo, hours, and `parentOrganization`. Two refinements to that work: (a) all five blocks use the same `image` (`symbioshealth_tagline.png`) — point each at its own brand logo; (b) on the root block, consider listing the four sub-brands via `department` (Google's documented pattern for co-located entities), which mirrors the GBP structure below.

**Still needed (not yet present anywhere):**

| Schema | Where | Why |
|---|---|---|
| `BreadcrumbList` | All 41 inner pages | Breadcrumb trails in SERPs; trivially generated from the URL path |
| `FAQPage` | Treatment pages with existing FAQ sections — e.g. `medspa/prp-vampire-treatments/index.html` has 4 Q&A pairs under "Frequently Asked Questions" already written | FAQ rich results (note: since 2023 Google limits FAQ rich results mostly to well-known health sites, but the markup still aids entity understanding and other engines) |
| `MedicalWebPage` (+ `about` → `MedicalProcedure`/`MedicalTherapy`) | Service pages: P-Shot, Priapus Toxin, ED/Alma Duo, pelvic floor, lymphedema, PRP treatments | Signals YMYL medical content with a named provider behind it |
| `Physician` / `Person` | About pages, ideally a dedicated bio page for Dr. Luther | E-E-A-T anchor for all the medical claims |
| `BlogPosting` (Article) | `/advanced-ed-solutions/` now; every migrated post later | Author/date/publisher signals; required for any article rich features |
| `Service` or `Offer` list | Optionally on the 5 indexes (`hasOfferCatalog`) | Ties service pages to the LocalBusiness entity |

---

## Google Business Profile Plan — One Profile Per Brand

Google explicitly allows multiple Business Profiles at a single address **when the businesses are distinct entities**: each must have its own public-facing name, its own phone number, its own category, and operate as a genuinely separate business (separate signage/check-in helps). Symbios clears this bar unusually cleanly — four brands, four dedicated phone lines, distinct service categories, one campus. Practices where individual practitioners see patients also qualify for practitioner profiles on top of facility profiles.

### Recommended profile structure (5 profiles)

| Profile name | Phone | Primary category | Secondary categories | Landing URL |
|---|---|---|---|---|
| Symbios Health | 843-738-4800 | Medical clinic | Wellness center, Medical office | `https://www.mysymbios.com/` |
| Symbios Primary Care | 843-738-4800* | Medical clinic | Family practice physician, Internist, Men's health physician, Women's health clinic | `/primary-care/` |
| Symbios Physio Therapy | 843-738-4300 | Physical therapy clinic | Physical therapist, Sports medicine clinic | `/physiotherapy/` |
| Symbios Fit | 843-738-4600 | Gym | Personal trainer, Weight loss service, Fitness center | `/fit/` |
| Symbios Aria Med Spa | 843-738-4000 | Medical spa | Skin care clinic, Facial spa, Laser hair removal service (if offered) | `/medspa/` |

*The shared 4800 line between the parent and Primary Care is the one friction point — Google's duplicate detection keys heavily on name+address+phone. **Options:** (a) provision a distinct DID for Primary Care (cleanest), or (b) treat Primary Care as the parent profile's core identity and skip a separate Primary Care profile (4 profiles instead of 5), or (c) proceed with both and be prepared to appeal — distinct names and categories usually suffice, but expect a review. Recommend (a).*

### Requirements & setup order

1. **Suite/unit designators first.** Google's guidelines require distinct businesses at one address to be distinguishable. Assign each brand an internal suite/unit ("460 William Hilton Parkway, Ste A/B/C/D" or "Bldg 2") **and put the same designator on the website's footer + JSON-LD for that brand** before creating the profiles. If the campus genuinely has separate buildings/entrances, use those. Do NOT invent fake suite numbers that mail can't reach — verification postcards may be used.
2. **Match everything to the site.** Each profile's name, phone, hours, and URL must exactly match what the corresponding section of the site displays (this is why the three phone inconsistencies in §6 must be fixed first). Hours per site/schema: Mon–Thu 8:00–4:30, Fri 8:00–4:00.
3. **Create/claim in this order:** claim any existing profiles first (the live brands likely already have profiles under "The Edge by Symbios Health", "MedSpa by Symbios Health", etc. — **rename, don't duplicate**; the Edge→Fit rebrand is a profile edit, and renaming preserves reviews). Search Google Maps for the address before creating anything new.
4. **Verification:** expect video verification (walk-through showing each brand's signage, entrance, and equipment) — Google now defaults to it for multi-profile addresses. Physical brand signage at the campus materially helps.
5. **Per-profile content:** unique description, brand logo, 10+ real photos of that brand's space, services list mirroring the site's service pages, booking link (ActiveCampaign form URLs / athenahealth portal), and UTM-tagged website links (`?utm_source=gbp&utm_medium=organic&utm_campaign=<brand>`).
6. **Reviews:** solicit per-brand (the review link differs per profile). Never pool all reviews on the parent.
7. **Citations:** once live, propagate each brand's exact NAP to Apple Business Connect, Bing Places, Yelp, Healthgrades/Zocdoc (primary care, physio), and the Hilton Head–Bluffton Chamber directory.

### Pitfalls

- **Duplicate suspension risk:** same name-ish + same address + same phone = merge/suspension. Distinct names/phones/categories per brand avoids this; the shared 4800 line is the exposure (see * above).
- **Don't keyword-stuff profile names** ("Symbios Aria Med Spa – Botox & Fillers Hilton Head" will get suspended). Use real signage names.
- **Practitioner profiles:** if Dr. Luther has (or gets) his own practitioner profile, set its category differently from the facility profile and point it at his bio page, not the homepage — otherwise Google may merge them.
- **The Edge rebrand:** update the existing profile's name/website rather than creating "Symbios Fit" fresh; a name edit triggers re-verification but keeps review history.

---

## Launch Checklist

**Pre-launch (on Render staging):**
- [ ] Block indexing of the staging URL: serve `X-Robots-Tag: noindex` header (Render header rules) or a `Disallow: /` robots.txt **conditionally on the onrender.com host** — the committed robots.txt says `Allow: /`, which is correct only for the production domain
- [ ] Add canonical tags (46 pages) pointing at `https://www.mysymbios.com/…` — these also defuse staging-URL indexing
- [ ] Fix the 3 phone inconsistencies (§6) — must precede GBP work
- [ ] Add OG/Twitter tags, lazy loading, WebP for the 3 large files, 404 page
- [ ] Re-add GA4 (client decision pending) so pre/post-launch traffic is comparable
- [ ] Decide blog-post strategy: migrate top posts now, or 301 all post slugs to `/blog/` at launch (losing their rankings) — **do not leave them 404ing**

**301 redirect map (deploy at DNS cutover, keep forever):**

| Legacy URL pattern | Redirect to |
|---|---|
| `https://theedge.mysymbios.com/` | `https://www.mysymbios.com/fit/` |
| `https://theedge.mysymbios.com/<page>/` | `https://www.mysymbios.com/fit/<page>/` (per-slug map — note renamed slugs, e.g. Edge Rx / StrongHer pages) |
| `https://primarycare.mysymbios.com/<page>/` | `https://www.mysymbios.com/primary-care/<page>/` |
| `https://primarycare.mysymbios.com/{femilift-vaginal-rejuvenation, the-o-shot, alma-duo-for-enhanced-sexual-function, vampire-prp-winglift}/` | new local pages once migrated; until then → `/primary-care/sexual-health/` |
| `https://physiotherapy.mysymbios.com/<page>/` | `https://www.mysymbios.com/physiotherapy/<page>/` |
| `https://medspa.mysymbios.com/<page>/` | `https://www.mysymbios.com/medspa/<page>/` |
| `https://www.mysymbios.com/blog/page/{2..17}/` | `/blog/` (or migrated pagination) |
| `https://www.mysymbios.com/<post-slug>/` (150+ posts) | migrated post URL, else `/blog/` |
| `http://` and apex `mysymbios.com` | force `https://www.` (single canonical host) |

Build the per-slug map by crawling the four live subdomains before cutover (`wget --spider -r` or Screaming Frog) — do not assume slug parity; the rebuild renamed several (`request-a-consultation` vs `request-an-appointment`, Edge→Fit pages). Old subdomain DNS must continue to resolve (pointing at a redirect service or the same Render app with host-based rules) — deleting the DNS records kills the redirects.

**Search Console / post-launch:**
- [ ] Verify **Domain property** for `mysymbios.com` in Google Search Console (covers www + all four legacy subdomains in one property — needed to monitor the redirect handoff)
- [ ] Keep/claim the individual legacy subdomain properties if they exist; watch their coverage reports drain to zero as redirects take effect
- [ ] Submit `https://www.mysymbios.com/sitemap.xml` in GSC and Bing Webmaster Tools
- [ ] Confirm robots.txt on production allows all + references the sitemap (already written correctly for prod)
- [ ] Spot-check redirects: top 20 legacy URLs by GSC clicks → 301 → correct new URL, single hop
- [ ] Update GBP website links (all 5 profiles), social bios, and any paid-ads final URLs to the new paths
- [ ] Update citations (Apple/Bing/Yelp/Healthgrades) to new URLs
- [ ] Monitor GSC "Page indexing" + "Redirect error" reports weekly for the first 8 weeks; expect rankings to transfer over 2–6 weeks
- [ ] After 30 days: crawl the site for lingering internal links to `*.mysymbios.com` subdomains or legacy post URLs

---

*Files inspected in depth: `index.html`, `fit/index.html`, `primary-care/index.html`, `physiotherapy/index.html`, `medspa/index.html`, `fit/healthy-weight-loss/index.html`, `fit/request-a-consultation/index.html`, `primary-care/mens-health/index.html`, `medspa/prp-vampire-treatments/index.html`, `physiotherapy/pelvic-floor-therapy/index.html`, `physiotherapy/appointments/index.html`, `blog/index.html`, `request-an-appointment/index.html`, `advanced-ed-solutions/index.html`; all 46 pages machine-scanned for titles, metas, H1 counts, alt coverage, canonicals, viewport, favicons, JSON-LD, lazy loading, tel/address consistency, and internal link graph.*
