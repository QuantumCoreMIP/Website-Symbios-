# Symbios Fit Site Rebuild — Build Spec

Static rebuild of mysymbios.com + its 4 sub-brand sites, with the "SymbiosEdge / The Edge" brand renamed to **Symbios Fit**.

## Source material
- Extracted page text: `C:\Users\Nick\AppData\Local\Temp\symbios\<site>\<page>.txt` (format: `[H1]/[H2]` heading markers, `[LINK:url]`, `[IMG:src|alt]`)
- Raw HTML (for <title> tags etc.): same folders, `.html`
- Sites: `main`, `theedge` (→ becomes `fit`), `primarycare`, `physiotherapy`, `medspa`

## Output structure (this folder)
```
symbios-fit-site/
  assets/style.css          (shared — DO NOT EDIT)
  index.html, about-us.html, blog.html, email-sign-up.html,
  privacy-policy.html, request-an-appointment.html, careers.html
  fit/            index.html (DONE — the exemplar) + all theedge pages
  primary-care/   index.html + service pages
  physiotherapy/  index.html + service pages
  medspa/         index.html + service pages
```

## THE EXEMPLAR
`fit/index.html` is the reference implementation. Read it first and copy its
structure exactly: topbar → header/nav → hero → sections → newsletter band → footer.
Same class names, same fonts link, same patterns (.split, .card grid, .checklist, .btn).

## Rebrand rules (apply everywhere)
- "SymbiosEdge", "The Edge", "the Edge by Symbios Health" → **"Symbios Fit"** / "Symbios Fit by Symbios Health"
- "Edge Rx" → **"Fit Rx"** (program name; flagged for client review)
- The old Edge logo PNG (`symbiosedge_tagline.png`) is NOT used. Use the text lockup instead:
  `<span class="logo-lockup"><span class="brand-top">SYMBIOS <em>FIT</em></span><br><span class="brand-sub">by Symbios Health</span></span>`
- Nav label "SymbiosEdge" → "Symbios Fit"; "Recreational Sports Health" service label stays.

## Link mapping (all internal links must resolve locally — no 404s)
| Live URL | Local href (adjust ../ per folder depth) |
|---|---|
| https://www.mysymbios.com/ or `/` on main | `index.html` |
| main `/about-us/`, `/blog/`, `/careers/`, `/email-sign-up/`, `/privacy-policy/`, `/request-an-appointment/` | matching root `.html` |
| https://theedge.mysymbios.com/[page] | `fit/[page].html` (home → `fit/index.html`) |
| https://primarycare.mysymbios.com/[page] | `primary-care/[page].html` |
| https://physiotherapy.mysymbios.com/[page] | `physiotherapy/[page].html` |
| https://medspa.mysymbios.com/[page] | `medspa/[page].html` |
| https://25915.portal.athenahealth.com/ | keep as-is (Patient Portal), target=_blank |
| Social URLs | keep as-is, target=_blank |
| Blog post permalinks | keep live URL, target=_blank (posts not rebuilt) |

Sub-sites (primary-care, physiotherapy, medspa): their `/request-a-consultation/`,
`/email-sign-up/`, `/privacy-policy/`, `/about-us/` links point to the MAIN site pages
(`../request-an-appointment.html`, `../email-sign-up.html`, `../privacy-policy.html`,
`../about-us.html`). Only `fit/` gets its own local copies of those pages.

## Contact info (verified from live site)
- Campus address (all brands): 460 William Hilton Parkway, Hilton Head Island, SC 29926
- Main / Symbios Health: 843-738-4800
- Symbios Fit (was Edge): (843) 738-4600
- Other sub-sites: use the tel: number found in THEIR OWN .txt files; if none, use 843-738-4800
- Patient Portal: https://25915.portal.athenahealth.com/
- Hours (from request-a-consultation page): Mon–Thu 8:00 AM–4:30 PM, Fri 8:00 AM–4:00 PM, Sat–Sun closed

## Images
Hotlink the original `wp-content/uploads` URLs found in the .txt/.html files
(full absolute URLs). Always add meaningful alt text. Hero sections use
`style="background-image:url('…')"` like the exemplar.

## Forms (request appointment / email signup)
Build a static `<form class="contact-form" action="#" method="post">` with the fields
implied by the live page (typically: first/last name in a .row2, email, phone,
service-interest select listing the brands/services, message textarea, submit .btn).
Add an HTML comment: `<!-- TODO: wire to form handler (live site uses WordPress forms) -->`

## Titles
- Main pages: `<Page Name> - Symbios Health`
- Fit pages: `<Page Name> - Symbios Fit by Symbios Health`
- Others: match live title but keep their brand (e.g. `- Symbios Primary Care`)

## Faithfulness
Use the page copy from the .txt files verbatim (it is the client's own content) —
apply only the rebrand renames. Keep heading hierarchy. Keep testimonials, program
details, checklists ("What's Included" lists use `ul.checklist`).
CSS path from root pages: `assets/style.css`; from subfolders: `../assets/style.css`.
Every page keeps the topbar CTAs: tel link, "Schedule a Consultation", "Patient Portal".
