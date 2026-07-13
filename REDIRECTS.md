# 301 Redirect Map — old sites → new site

Apply at DNS cutover. Two layers are needed:

**Layer 1 — subdomain hosts (Render alone cannot do this).** The four old sub-sites
live on their own hostnames, so the redirects must happen wherever DNS/proxy is
handled (Cloudflare Redirect Rules / Bulk Redirects is the recommended home — add
each subdomain as a proxied DNS record and one dynamic rule per host):

| Old host | Rule |
|---|---|
| theedge.mysymbios.com/* | 301 → www.mysymbios.com/fit/:splat (see slug map below) |
| primarycare.mysymbios.com/* | 301 → www.mysymbios.com/primary-care/:splat |
| physiotherapy.mysymbios.com/* | 301 → www.mysymbios.com/physiotherapy/:splat |
| medspa.mysymbios.com/* | 301 → www.mysymbios.com/medspa/:splat |

Slug exceptions inside those hosts (renamed pages — exact rules BEFORE the wildcard):

| Old URL | New path |
|---|---|
| theedge.mysymbios.com/ | /fit/ |
| theedge.mysymbios.com/request-a-consultation/ | /fit/request-a-consultation/ |
| primarycare.mysymbios.com/priapus-toxin-for-erectile-dysfunction/ | /primary-care/priapus-toxin-for-erectile-dysfunction/ |
| primarycare.mysymbios.com/alma-duo-for-enhanced-sexual-function/ | /primary-care/sexual-health/ (page not migrated) |
| primarycare.mysymbios.com/femilift-vaginal-rejuvenation/ | /primary-care/sexual-health/ (not migrated) |
| primarycare.mysymbios.com/the-o-shot/ | /primary-care/sexual-health/ (not migrated) |
| primarycare.mysymbios.com/vampire-prp-winglift/ | /primary-care/sexual-health/ (not migrated) |
| physiotherapy.mysymbios.com/appointments/ | /physiotherapy/appointments/ |

**Layer 2 — same-host paths on www.mysymbios.com** (Render dashboard
"Redirects/Rewrites", or the same Cloudflare ruleset). Most core pages kept their
slugs (about-us, blog, careers, email-sign-up, privacy-policy,
request-an-appointment, advanced-ed-solutions) — no rules needed. Rules needed:

| Old path | New path | Why |
|---|---|---|
| /carbs-vs-fats-energy/ | /blog/ | post not migrated |
| /cholesterol-a-vital-ally-for-longevity-especially-in-later-years/ | /blog/ | post not migrated |
| /cholesterol-metabolic-health-heart-risk/ | /blog/ | post not migrated |
| /how-testosterone-replacement-therapy-reignites-mens-strength-and-confidence/ | /blog/ | post not migrated |
| /rewiring-your-mind-with-food-how-a-ketogenic-diet-could-boost-your-mental-health/ | /blog/ | post not migrated |
| /the-8-hour-sleep-myth-why-your-rhythm-might-need-a-rewire/ | /blog/ | post not migrated |
| /the-art-of-subtle-facial-rejuvenation-from-a-physicians-lens/ | /blog/ | post not migrated |
| /the-brains-silent-guardian-how-fatigue-shapes-exercise-and-safeguards-our-body/ | /blog/ | post not migrated |
| /the-hidden-risks-of-sleeping-pills-rethinking-the-path-to-restful-nights/ | /blog/ | post not migrated |
| /the-link-between-metabolic-disease-prediabetes-and-kidney-stone-formation/ | /blog/ | post not migrated |
| /the-real-story-on-glp-1-medications-why-holistic-care-delivers-the-best-results/ | /blog/ | post not migrated |
| /blog/page/* | /blog/ | pagination not migrated |
| /category/* | /blog/ | WP category archives |
| /event/ | /blog/ | deleted on live site already |
| /wp-content/uploads/* | (leave 404) | media files; do NOT redirect to pages |

NOTE: when blog posts are migrated later (ToDoList), replace their /blog/ rules
with exact post-to-post redirects — that recovers their individual rankings.

**Rules of thumb baked into this map**
- Redirect to the closest relevant page, never blanket-everything-to-homepage
  (Google treats mass redirects-to-home as soft 404s and drops the link equity).
- Exact rules before wildcards.
- Expect the unknown: this map covers every URL found by crawling the live sites,
  but Search Console + backlink exports (see ToDoList) will surface more. The
  custom 404.html catches whatever slips through.
