# Symbios Site — To-Do List

## Tabled / awaiting client input
- [ ] **SymbiosFit hours** — schema and Fit pages currently show the campus-wide
      Mon–Thu 8:00–4:30 / Fri 8:00–4:00 schedule. Confirm the actual hours for the
      Port Royal Plaza space (95 Mathews Dr, Suite D3) and update fit pages + JSON-LD.
- [ ] "Fit Rx" program name (was "Edge Rx") — confirm with client
- [ ] "PhysioTherapy" vs "SymbiosTherapy" — Dad's text said one word; logo reads
      PhysioTherapy. Confirm whether the brand itself is being renamed.
- [ ] New SymbiosFit social profiles (current links still point to old Edge handles)
- [ ] Vector versions of the SymbiosFit + fixed SymbiosHealth logos from designer

## Launch-critical (before DNS cutover to www.mysymbios.com)
- [ ] Enter the 301 redirect rules from REDIRECTS.md (Render dashboard rules, or
      Cloudflare Bulk Redirects if DNS moves there — Cloudflare handles the
      subdomain redirects too, Render alone cannot)
- [ ] Keep theedge/primarycare/physiotherapy/medspa subdomains resolving with 301s
      to their new sections for at least 12 months
- [ ] Flip robots.txt from `Disallow: /` to `Allow: /`
- [ ] Verify all 5 old properties + new domain in Google Search Console; submit sitemap
- [ ] Export GSC "Pages" + Performance URL lists and backlink targets (Ahrefs/Semrush
      free tier or Bing Webmaster) → add any URL we missed to the redirect map
- [ ] Separate ActiveCampaign forms per brand so leads route correctly (all four
      consultation pages currently share form id=20)

## Post-launch (first 90 days)
- [ ] Watch GSC crawl errors + 404 reports weekly; append redirects for real traffic
- [ ] Google Business Profiles: one per brand per SEO-REVIEW.md plan (SymbiosFit gets
      its own at Port Royal Plaza; consider distinct phone line for PrimaryCare)
- [ ] Migrate blog posts (pages 2–17 on live, ~150 posts) — the long-tail SEO engine

## Content / quality backlog
- [ ] Advanced-ED page: stale June 2025 webinar section — remove or update
- [ ] Live-site copy issues flagged in HTML comments (Daniel Steere empty bio, etc.)
- [ ] Image optimization: WebP conversion, lazy loading, 3 files >300KB
- [ ] Consider trimming topbar on mobile (Patient Portal into hamburger)
