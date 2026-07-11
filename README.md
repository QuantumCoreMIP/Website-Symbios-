# Symbios Health — Site Rebuild (Symbios Fit rebrand)

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
| Symbios Fit | 843-738-4604 |
| Physio Therapy | 843-738-4300 |
| Symbios Aria (med spa) | 843-738-4000 |
| Primary Care | 843-738-4800 |

Campus: 460 William Hilton Parkway, Hilton Head Island, SC 29926
Patient portal: https://25915.portal.athenahealth.com/

## Outstanding items (flagged in HTML comments in the pages)
- Symbios Fit logo: derived from the original Edge logo (assets/symbiosfit_tagline.png, transparent bg; _nocheck variant available) — "Fit" set in Allura script matched to the original color/size. Client should confirm or supply an official vector version
- Social profiles still carry The Edge handles (facebook 61578321875531, instagram @theedgebysymbioshealth, linkedin the-edge-by-symbios-health)
- "Edge Rx" renamed to "Fit Rx" and "The Mobility Edge" program name kept — confirm with client
- Forms use the client's live ActiveCampaign embeds (mysymbios820.activehosted.com — ids 3/15/20/21) and careers uses the live Dover job-board iframe; confirm those accounts stay active through launch
- Blog: page 1 posts carded (linking to live posts); pages 2–17 not migrated; ED post's category sidebar not rebuilt
- Sexual Health: 4 women's treatment tiles (FemiLift, O-Shot, Alma Duo Enhanced Sexual Function, PRP Wing Lift) link to live pages not yet migrated
- Not carried over pending client decision: UserWay accessibility widget, GA4 analytics tag, header search overlay
