# Symbios 8x8 Greetings — Voice & TTS Settings (reference)

Reproducible recipe for regenerating any Symbios phone greeting via **ElevenLabs**.
Last used **2026-07-30** to produce all 77 files in `final/`.

---

## Quick reference

| Setting | Value |
|---|---|
| Provider | ElevenLabs REST API |
| Voice | **Sarah** — `EXAVITQu4vr4xnSDxMaL` |
| Model | **eleven_multilingual_v2** |
| stability | **0.50** |
| similarity_boost | **0.85** |
| style | **0.28** |
| use_speaker_boost | **true** |
| seed | **222** (default) — see *Long prompts* for exceptions |
| output_format | **mp3_44100_128** (mono, 8x8-ready) |
| Endpoint | `POST https://api.elevenlabs.io/v1/text-to-speech/{voice_id}?output_format=mp3_44100_128` |
| Auth header | `xi-api-key: <key>` |

Request body:
```json
{
  "text": "...",
  "model_id": "eleven_multilingual_v2",
  "voice_settings": { "stability": 0.50, "similarity_boost": 0.85, "style": 0.28, "use_speaker_boost": true },
  "seed": 222
}
```

---

## Why these choices

- **multilingual_v2, not turbo_v2.** Turbo respected phoneme tags but sounded robotic and hiccuped on longer clips. Multilingual is warm, clean, and glitch-free. The trade-off: it **ignores/deletes SSML `<phoneme>` tags**, so pronunciation is done with plain-text spelling instead (see below).
- **style 0.28 / stability 0.50 (nicknamed "CA").** Warm and approachable but consistent across scripts. Higher style (~0.55) sounded happier but drifted in tone and triggered artifacts; lower killed the warmth.

---

## Pronunciation rules — put these in the TEXT (never SSML)

- **Brand "Symbios" → type `Sim Bios`** (two words). Reads as **SIM-BY-ohs** (like a computer BIOS). The real spelling reads wrong on this model — always use `Sim Bios`.
- **Website mysymbios.com → `my Sim Bios dot com`**.
- **Titles:** spell out **`Doctor`** (not "Dr."). **Only Stephen Luther and Christopher Madison** get the title; every other provider is untitled.
- **Emergency number → `9 1 1`** (spaced) so it reads "nine one one".
- **Read numbers as digits:** zip `2 9 9 2 6`, fax `8 4 3, 7 3 8, 4 8 0 1`.
- **`$25`** already reads correctly as "twenty-five dollars".
- **`SC` → `South Carolina`** (letters read as "ess see" otherwise).
- **Hard names → phonetic respelling**, spoken only; the **filename keeps the real name**. Handled by the `$pronOverride` table in `build\generate.ps1` — see *Name pronunciation overrides* below for every name we tuned.

### Name pronunciation overrides (confirmed spellings)

Only the *spoken* text is respelled; the **filename keeps the real name**. All live in `$pronOverride` in `build\generate.ps1`.

| Mailbox (real name = filename) | Spoken first | Spoken last | Target sound |
|---|---|---|---|
| Shemika Chisolm | `Sha-meeka` | `Chizzum` | shuh-MEE-kuh · CHIZ-um |
| Vika Blintser | `Vee-ka` | `Blintser` | VEE-kah |
| Jean Magarelli | `Gene` | `Magarelli` | "Gene" (jeen) |

> **Shemika** also needed **per-file seed overrides** (see *Per-file seed overrides* below) — the same spelling rendered the two names differently between her External and Internal files, so each was pinned to a seed that got both right.

---

## Standard vs. long prompts  (important for re-runs)

Every file uses the **same voice_settings**. The only thing that changes is the **seed**, and only for long prompts.

- **Short / normal greetings** (all 70 user greetings + the shorter system prompts): **seed 222**, clean on the first try.
- **Long prompts (~30s+, e.g. the Auto Attendant main menu):** a fixed seed can land on a stochastic **hiccup**. Because the seed is fixed, re-running reproduces the *same* glitch — so the fix is to **re-roll the seed** (try a few) and pick the clean take.
  - Tip: a hiccup usually makes the file *longer*, so the **shortest take is often the clean one** — but confirm by ear.

### Per-file seeds used for the system prompts

| File | Seed |
|---|---|
| **AutoAttendant.mp3** (the long one) | **101** |
| AutoAttendant-GeneralInfo.mp3 | 222 |
| AutoAttendant-PrescriptionsAndAppointments.mp3 | 222 |
| AutoAttendant-Billing.mp3 | 222 |
| Initial_Call_Queue_Greeting-Std.mp3 | 222 |
| Initial_Call_Queue_Greeting-XMAS.mp3 | 222 |
| Repeating_Call_Queue_Greeting.mp3 | 222 |

`build\generate-system.ps1` bakes in seed **101** for AutoAttendant so a clean re-run reproduces the approved audio.

### Per-file seed overrides (user greetings)

A hard name can render *inconsistently between a mailbox's External and Internal file* on the same seed (e.g. first name right in one, last name right in the other). The approved clean takes use these seeds, baked into `generate.ps1`'s `$seedOverride`:

| File | Seed |
|---|---|
| Shemika_Chisolm-External.mp3 | 22 |
| Shemika_Chisolm-Internal.mp3 | 55 |

To fix a new case: generate a few seeds of each file, pick the take where **both** names are correct, and add `'<File>.mp3' = <seed>` to `$seedOverride`.

---

## How to regenerate

From `8x8-audio\build\`:

```powershell
# User greetings, one quarter (Q1-Q4):
.\generate.ps1 -Quarter 2

# One person only (e.g. after a name-pronunciation tweak):
.\generate.ps1 -Quarter 3 -Only Chisolm

# The 7 system prompts (Auto Attendant + Call Queue):
.\generate-system.ps1
```

- Output lands in `..\user-greetings\`; approved files are moved to `..\final\`.
- Keys **auto-rotate** on quota / 401 / 429 in the order given by `-KeyNames`
  (default `ELEVEN_LABS_API_KEY_4 -> ELEVEN_LABS_API_KEY -> _2 -> _3`).

---

## Keys & security

- ElevenLabs API keys live in **Bitwarden Secrets Manager** (project `HHICG-AI-Agents`):
  `ELEVEN_LABS_API_KEY` (primary) plus `_2` / `_3` / `_4` (extra free accounts used for the POC).
  Pulled at runtime through the DPAPI vault (`bitwarden-work`) — never printed, never committed.
- **Licensing:** free-tier ElevenLabs requires "Powered by ElevenLabs" attribution. For production, use a **paid (Starter, $5+) account** and re-cut on that key with the **same seeds** for identical, properly-licensed audio.
