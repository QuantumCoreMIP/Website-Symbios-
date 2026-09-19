# Claude instructions for this repo

Read the "Start here" section at the top of README.md before doing anything. It explains what was built and why, which client decisions are open, and where the work is heading. Then read STATUS.md (newest entry first) and ToDoList.md.

Hard rules that apply to every task here:

- No em dashes and no emoji in anything client-facing (site copy, PDFs, emails). Search before delivering.
- Client-facing documents are branded Quantum Core MIP (Managed Information Provider), Scott Hoffman, 843.422.2201, info@quantumcoremip.com.
- Never send email. Draft to Reports/Proposal/*.txt; Scott or Nick sends.
- Do not redraw or recolor the client's logos. Use the files in Brand/ as supplied.
- Do not change PrimaryCare green, Aria cyan, the header logo layout, or add Align/Care pages until Dr. Luther answers Brand/Symbios-Logo-Decisions.pdf (see README).
- Do not flip robots.txt or the sitemap host until DNS cutover.
- Symbios tagline is "Healthy, fit and beautiful for life". Brand names are one word: SymbiosHealth, PrimaryCare, PhysioTherapy, SymbiosFit, SymbiosAria.
- Push to main deploys staging at symbios.onrender.com. LF/CRLF warnings on commit are harmless.
- Render PDFs with the render-pdf.sh script in the mip-proposal skill (run from bash, not PowerShell), then rasterize and look at every page before delivering.
