# Symbios Health site rebuild (Quantum Core MIP)

## Start here: context for anyone picking this up

Updated 2026-09-19. Read this section first, then STATUS.md (dated log, newest at top), then ToDoList.md. This is what the code and git history cannot tell you: why things are the way they are and where we are heading. The build reference (structure, phone numbers, outstanding items) is further down this file.

### The engagement in one paragraph

Symbios Health is a physician-led medical campus on Hilton Head Island (Dr. Stephen Luther, founder; Daniel Steere, operations and tech). Five brands: SymbiosHealth (campus), PrimaryCare, PhysioTherapy, SymbiosFit (formerly SymbiosEdge), SymbiosAria (med spa), plus two programs with logos and no pages, SymbiosAlign (concierge, 60 clients at $5,000 per 12-week cycle, fully booked) and SymbiosCare (membership). We rebuilt their five fragmented WordPress sites as one static site (this repo), delivered an SEO audit, a competitive market review, and a Website/SEO/Hosting proposal, and are building toward a business-automation proposal (email, social, reviews, intake) on top of Zenoti. All client-facing work is branded **Quantum Core MIP (Managed Information Provider)**, Scott Hoffman, 843.422.2201, info@quantumcoremip.com. Nick Hoffman runs the build; Scott is the client-facing contact.

### Where things live

| What | Where |
|---|---|
| The site | this repo, main branch. Push to main and Render redeploys staging at symbios.onrender.com within a minute or two. GitHub remote is `QuantumCoreMIP/Website-Symbios-` (the old `nicholasshoffman-ATL/Symbios` URL redirects). |
| Client deliverables (PDFs) | `Reports/Final Reports/` (three PDFs). HTML sources in `Reports/Proposal/`, `Reports/SEO-Audit/`, `Reports/Competitive-Market-Review/`. Edit the HTML, never the PDF. |
| Email drafts | `Reports/Proposal/*.txt`. See "Email status" below. |
| Brand material | `Brand/`: the client's brand guide PDF, the approved logo zip and its extracted PNGs, live-site logo pulls, the exported guide lockups, comparison sheets, and `Symbios-Logo-Decisions.pdf` (the checkbox document sent to Dr. Luther). |
| Automation research | `Reports/Automation/`: meeting notes (2026-09-10), the client's tech-stack sheet, the email/social execution plan, the inbox and social audit, and `symbios-email-samples/` (everything they have ever emailed or posted, with rendered PNGs). |
| Demo reels | Not in the repo. `C:\Users\JewFish\Desktop\MouseWithoutBorders\symbios-demo-pack\reel\` on Nick's machine, and inside `symbios-handoff-2026-09-17.zip` on the same share. Four watermarked demo reels built on the client's Higgsfield account (credits nearly exhausted, about 8 left). Build scripts are in the zip. |
| PDF rendering | `C:\Users\JewFish\.claude\skills\mip-proposal\scripts\render-pdf.sh <in.html> <out.pdf>` (headless Chrome, run from bash, not PowerShell). QA by rasterizing every page with PyMuPDF and looking at every one. |

### What we did and why (the parts that matter now)

**The rebuild (July to September).** Static HTML, clean URLs, root-absolute links, all images rehosted locally, one shared `assets/style.css` with per-brand CSS variables (`body.brand-fit`, `.brand-pc`, `.brand-physio`, `.brand-aria`). A persistent dark campus-switcher bar on every page fixes the live site's biggest usability hole (no way to get from one brand to another). Edge was rebranded to SymbiosFit throughout. Forms are still wired to ActiveCampaign embeds, which the client is retiring; they must move to Zenoti before launch. `robots.txt` blocks staging on purpose; `sitemap.xml` points at www.mysymbios.com on purpose. Do not flip either until DNS cutover.

**The logo revert (2026-09-18, commit 5ad5b9b).** In July we had redrawn the "Health" script in the SymbiosHealth logo (Yellowtail font, painted fully opaque from the alpha-unmixed red), which rendered fire-engine red instead of the brand coral. Nick caught it comparing our header to the live site. Every reference now points at the client's own `assets/wp/www.mysymbios.com/2021/12/symbiosmain_tagline.png`. Rule going forward: we do not redraw their marks. The one flaw in the original (the H tail dips into the tagline) is theirs to fix in the vector file.

**The brand guide pass (2026-09-18, commit cad317a).** Dr. Luther sent an 11-page brand guide. We aligned the site to it: exact hex values from its swatch page, SymbiosFit switched from the Edge-derived taupe to the guide's blue #2f6fa3 with the guide's own Fit artwork (`assets/symbiosfit_logo.png`), Zodiak (the guide's headline face, free on Fontshare) self-hosted in `assets/fonts/` as `--font-heading`, 15 leftover "MedSpa by Symbios" mentions changed to SymbiosAria, blog tagline casing fixed. Gotham (body face) is a paid license, so Montserrat stays as the stand-in.

**The correction we have not applied yet (2026-09-19).** Comparing the guide artwork, the approved logo zip Dr. Luther sent on 9/19, and the live site, all three agree on every color. Only the guide's typed swatch page disagrees, on two colors: PrimaryCare green is #4ea647 in every logo (swatch says #4fa317) and Aria cyan is #1bbed5 (swatch says #08bed5). Our original site values were sampled from the logos and were right; the 9/18 alignment made the PrimaryCare page accent yellower than the logo in its own header. **We have not flipped it back**, because the email Scott sent on 9/18 told the client the site now uses the guide values, and the decision is now formally in front of Dr. Luther as item 1 of `Brand/Symbios-Logo-Decisions.pdf`. When he answers (we recommended the artwork values), it is two lines in `assets/style.css` (`body.brand-pc` and `body.brand-aria`) plus the inline `--door` values on `index.html` and the buttons on `404.html`.

### Open decisions with the client (do not pre-empt these)

All nine are in `Brand/Symbios-Logo-Decisions.pdf`, with our recommendation on each:
1. Green and cyan: artwork values or swatch values (recommend artwork).
2. Web header lockup: with tagline (current) or bare (recommend with tagline).
3. SymbiosHealth: single line (current) or stacked (recommend single line).
4. Tagline size and alignment: standardize (Physio's is centered, the others are right-aligned; Health's is larger than Aria's) or leave.
5. Taglines for SymbiosCare and SymbiosAlign: none exists.
6. Do Align and Care get pages (recommend a page each; neither exists on live or here).
7. SymbiosEdge is still live on theedge.mysymbios.com; Fit everywhere (recommend yes).
8. The H tail: fix in vector or leave.
9. Vector masters: nothing supplied is vector. The 2000 px zip files cover cards, letterhead, and web; signage needs AI/EPS. A sign company (Sign D' Sign, Bluffton) appeared in the email thread, so signage may be in motion.

Also open from the 9/10 meeting: SymbiosFit hours at Port Royal Plaza, "Fit Rx" naming, new Fit social handles, Zenoti access for form wiring.

### Direction

**The immediate fork is Darla.** Darla (Kirchner Marketing) built the brand story and is delivering a WordPress reskin of the existing site around **2026-09-25**. Symbios's stated inclination is to see hers first, then decide. Our position, already in writing: if they prefer her look, we apply her design to the site we built; we cannot host, maintain, or do SEO on a WordPress site. Keep that line. Do not disparage her work; she also holds the vector logo files we need.

**Site work worth doing while we wait**, in order: (a) flip green and cyan when Dr. Luther answers; (b) swap the header logo files for the 2000 px zip versions for retina sharpness, once decision 2 confirms the tagline layout; (c) stub SymbiosAlign and SymbiosCare landing pages if decision 6 says yes, using the lockups in `Brand/approved-logos-darla-2026-09-19/`; (d) the launch-critical list in ToDoList.md, which is unchanged and still gated on Zenoti access.

**Beyond the site.** The comprehensive automation and insurance-analytics proposal is owed to the client roughly two weeks from 9/10. The email/social plan in `Reports/Automation/email-social-plan.md` is the researched basis: Zenoti for email (BAA, template import, no one-off send API), Ayrshare or Planable for social with approval gates, Higgsfield for video, "we draft, you send" for anything touching a patient. Darla's June 2026 draft for a women's health program, working name **SymbiosHer**, with a physician-approved "Women's Health Repository" (`Brand/SymbiosWomensHealth_Messaging.pdf`), is exactly the content pipeline that plan describes; expect it to become a page, a logo, and a content library.

### Email status

| Draft | Status |
|---|---|
| `meeting-followup-email.txt` (9/10 follow-up, Darla paragraph, Zenoti, automation bullets) | Sent; Symbios replied 9/17 asking how we would support email and social. |
| `reply-email-social-support.txt` | Drafted 9/17. Confirm with Nick whether it went out. |
| `revised-docs-email.txt` (re-send of the three PDFs after the MIP rebrand and terms page) | Drafted 9/17. Confirm with Nick. |
| `brand-guide-review-email.txt` | Sent 9/18. Dr. Luther replied 9/19 with the logo zip and "three months with Darla". |
| `reply-approved-logos.txt` | Drafted 9/19, not sent. Meant to go with `Brand/Symbios-Logo-Decisions.pdf` attached. |

Claude never sends. Drafts only; Scott or Nick send from their own mailbox.

### House rules (non-negotiable)

- No em dashes anywhere in client-facing text. No emoji. Verify with a search before delivering.
- Client documents are Quantum Core MIP. Georgia headings, Segoe UI body, teal accent #0f766e, every section starts on a fresh page, nothing cut by a page break. The `mip-proposal` skill encodes this.
- Symbios brand: use the exact values in `Brand/`; Fit is blue, not taupe; tagline is "Healthy, fit and beautiful for life" (lowercase fit, no Oxford comma); one-word brand names (SymbiosHealth, PrimaryCare, PhysioTherapy, SymbiosFit, SymbiosAria) except where "Symbios Health" is the legal entity or the "by Symbios Health" sub-line.
- We draft, they send, for anything that reaches a patient. No PHI in marketing. Consent for any patient photo or story. Demo reels stay watermarked and unpublished.
- Never infer Google Business Profile structure from an embedded map; verify in Google Maps.
- Git: commit to main, push, Render deploys. The LF/CRLF warnings on commit are harmless. Commit messages end with the Claude co-author line.

---

# Build reference


Static rebuild of mysymbios.com and its sub-brand sites, with the former
"SymbiosEdge / The Edge" brand renamed to **Symbios Fit**.

## Hosting
Deployed as a static site on Render. Clean URLs: every page lives in its own folder
(`about-us/index.html` → `/about-us/`); all internal links are root-absolute with no `.html`.

## Structure
- `/` — main Symbios Health site (home, about, blog listing, appointment, careers, privacy, email signup, advanced ED solutions)
- `/fit/` — Symbios Fit (formerly theedge.mysymbios.com), 11 pages
- `/primary-care/` — Symbios Primary Care, 10 pages
- `/physiotherapy/` — Symbios Physio Therapy, 9 pages
- `/medspa/` — Symbios Aria med spa, 6 pages
- `assets/style.css` — shared stylesheet (palette/type sourced from the live Impreza theme)
- `assets/wp/<host>/...` — all images (and the new-patient PDF) downloaded from the live wp-content uploads, mirrored per source host; nothing is hotlinked anymore

## Contact numbers (verified from live site)
| Brand | Phone |
|---|---|
| Symbios Health (main) | 843-738-4800 |
| Symbios Fit | 843-738-4600 |
| Physio Therapy | 843-738-4300 |
| Symbios Aria (med spa) | 843-738-4000 |
| Primary Care | 843-738-4800 |

Campus: 460 William Hilton Parkway, Hilton Head Island, SC 29926
Patient portal: https://25915.portal.athenahealth.com/

## Outstanding items (flagged in HTML comments in the pages)
- SymbiosFit logo: now the client's own artwork from the brand guide (assets/symbiosfit_logo.png, blue #2f6fa3). The earlier Edge-derived taupe versions (symbiosfit_tagline.png, _nocheck) are unreferenced. Vector masters for every lockup are still owed by the client's designer; see the Start here section above and Brand/Symbios-Logo-Decisions.pdf
- Social profiles still carry The Edge handles (facebook 61578321875531, instagram @theedgebysymbioshealth, linkedin the-edge-by-symbios-health)
- "Edge Rx" renamed to "Fit Rx" and "The Mobility Edge" program name kept — confirm with client
- Forms use the client's live ActiveCampaign embeds (mysymbios820.activehosted.com — ids 3/15/20/21) and careers uses the live Dover job-board iframe; confirm those accounts stay active through launch
- Blog: page 1 posts carded (linking to live posts); pages 2–17 not migrated; ED post's category sidebar not rebuilt
- Sexual Health: 4 women's treatment tiles (FemiLift, O-Shot, Alma Duo Enhanced Sexual Function, PRP Wing Lift) link to live pages not yet migrated
- Not carried over pending client decision: UserWay accessibility widget, GA4 analytics tag, header search overlay
