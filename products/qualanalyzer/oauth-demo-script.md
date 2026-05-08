# OAuth Verification Demo Video — Recording Script

Target: 3 minutes. Upload as **Unlisted** to YouTube. Paste the link in the verification form.

---

## Pre-recording setup (do once before pressing record)

### 1. Create a clean test environment
- Use a **test Google account** (not your real research account). Reason: Google reviewers may scrub the video; nothing real should leak.
- Spin up synthetic data:
  - **Google Doc**: paste a fake interview transcript (~300 words, 2 speakers). Title it `Demo Interview Transcript`.
  - **DOCX file** in Drive: a second fake transcript. Title `wave1-participant-03.docx`.
  - **Google Sheet**: column A = 5–10 short fake quotes ("I felt overwhelmed by the workload"). Title `Demo Coding Sheet`. Column B will hold codes after the run.
- **Folder structure** in test Drive — exactly match what the justification claims:
  ```
  Demo Project / Wave 1 / wave1-participant-01.docx
                         wave1-participant-02.docx
                         wave1-participant-03.docx
  Demo Project / Wave 2 / wave2-participant-01.docx
  ```
  This is what reviewers will see when you justify "researchers organize files in deep nested folders."

### 2. LLM API
- Use a cheap test API key (OpenRouter is fine). Don't show the key on screen — go to Settings *before* recording starts.

### 3. Extension build
- Make sure your test browser has the latest build with the new icon.
- Extension pinned to toolbar.

### 4. Other tabs to have open
- One tab: https://console.cloud.google.com/apis/credentials — to show OAuth client IDs at the start.
- One tab: https://max-lu.com/products/qualanalyzer/ — for the closing privacy shot.

### 5. Recording tool
- macOS: **Shift + Cmd + 5** → Record Selected Portion. Or QuickTime → New Screen Recording. Or Loom.
- 1920×1080. Narrate while you click.

### 6. Anti-leak checklist
- Test account (not real)
- Synthetic transcripts (no real participants)
- API key entered before recording starts; settings panel collapsed
- Email address visible? Use the test account's email, not your real one
- No Slack/Mail notifications popping up — turn on Do Not Disturb

---

## SCRIPT (read aloud while clicking)

### Scene 1 — Intro & OAuth clients (~25s)
**Show:** Google Cloud Console → APIs & Services → Credentials page (OAuth 2.0 client IDs section)

> "This is LLM QualAnalyzer, a free open-source Chrome extension for academic researchers running LLM-assisted qualitative coding. This project has two OAuth clients — one Chrome extension client for the manifest's `chrome.identity.getAuthToken` flow, and one Web application client for the `launchWebAuthFlow` fallback used on non-Chrome browsers. Both will use the same scope set I'm about to demonstrate."

**Visual:** briefly hover/highlight both client rows.

---

### Scene 2 — OAuth consent flow (~25s)
**Show:** Chrome browser, extension icon in toolbar (your new burgundy icon!)

> "I'll click the extension icon to open the side panel."

Click extension → side panel opens → "Connect Google Account" button visible.

> "I'm signed out. I'll click Connect Google Account."

Click the button. Google's OAuth consent screen appears.

> "The consent screen shows the app name 'LLM QualAnalyzer' and lists each requested scope. I'll approve."

**Visual:** Pause briefly so reviewers can read the scope list. Click Allow.

Side panel returns showing the function menu.

---

### Scene 3 — `documents.readonly` scope (~30s)
**Show:** Function menu → click **Doc Parser**

> "First scope: documents.readonly. Doc Parser imports a Google Doc the user already has — typically interview transcripts."

Paste the URL of `Demo Interview Transcript` into the URL field (or the Drive Browser — see Scene 4).

> "The extension calls the Google Docs API with documents.readonly to fetch the document content. It parses the transcript into rows ready for coding. We never modify the source Doc — readonly only."

**Visual:** transcript content rendered in the parsed-rows preview.

---

### Scene 4 — `drive.readonly` scope (~50s) — *the biggest one*
**Show:** still in Doc Parser, click the **Drive Browser** to import DOCX files

> "Second scope: drive.readonly. Researchers store transcripts across nested folder structures like the one shown here."

Navigate: `Demo Project` → `Wave 1`. Reviewers see the folder hierarchy.

> "drive.readonly lets the extension call files.list to enumerate folder contents and filenames. We don't read file contents under this scope — file contents are accessed under documents.readonly or drive.file once a file is selected."

> "The Google Picker doesn't fit this workflow for three reasons. First — it flattens nested folders. Researchers organize their data in deep project folders and need to navigate them, not see one flat list."

> "Second — researchers run batch coding jobs across dozens of transcripts. The extension supports select-all and multi-select inside a folder, like this."

Click **Select All** in the folder. All `.docx` files highlight.

> "Third — Picker has no memory between sessions. The extension remembers the user's last folder so they resume in place across multi-week studies."

---

### Scene 5 — `drive.file` scope (~25s)
**Show:** with the DOCX files selected from Scene 4, click **Import**

> "Third scope: drive.file. To convert a DOCX into a Google Doc the extension can read, we call Drive's files.copy with a target mime type of Google Doc. files.copy creates a new file, which is exactly what drive.file is scoped for — it grants access only to files the app creates or the user explicitly opens."

**Visual:** progress indicator → DOCX conversion completes → parsed rows appear.

---

### Scene 6 — `spreadsheets` scope (~45s) — *the core workflow*
**Show:** Back to function menu → click **Sheet Processor**

> "Fourth scope: spreadsheets. This is the central workflow — read a column of qualitative passages from the user's existing Sheet, send each to the LLM, and write codes back to the Sheet."

Paste the URL of `Demo Coding Sheet` into the Sheet Connector. Sheet metadata loads (read).

Configure: pick column A as input, column B as output, paste a short coding prompt, pick a model.

Click **Queue Job**.

**Visual:** job runs, codes populate column B in real time (or open the Sheet in another tab to show writeback).

> "The extension reads from the user's existing Google Sheet and writes the LLM-generated codes back to columns the user designated. This is the core function — it's why drive.file alone wouldn't work. Researchers iterate on the same Sheet over weeks."

---

### Scene 7 — Privacy & open source close (~15s)
**Show:** open the privacy policy at https://max-lu.com/products/qualanalyzer/privacy, scroll briefly

> "All processing is local to the user's browser. We operate no servers and collect no user data. The user's API keys, prompts, and analysis results never leave their browser. Source code is published at github.com/maxlvhao/llm_qual_analyzer for full audit. Thanks for reviewing."

---

## Total runtime: ~3:15

---

## Post-recording checklist

- [ ] Watch back at 1.5x — anything embarrassing or sensitive on screen?
- [ ] No real API keys, real participants, or real email addresses visible
- [ ] All four scopes (`documents.readonly`, `spreadsheets`, `drive.readonly`, `drive.file`) demonstrated in actual app use, not just described
- [ ] OAuth flow shown end-to-end (sign-in button → consent → success)
- [ ] Both OAuth clients mentioned (don't have to repeat the flow for each)
- [ ] Upload to YouTube as **Unlisted** (not Public, not Private)
- [ ] Copy YouTube link into the verification form's "YouTube link" field

## Things to skip / cut

- Don't show the IRR Calculator, JSON Parser, or Prompt Builder unless you want — they don't use the scopes under review.
- Don't explain what qualitative coding is in detail — reviewers don't care, they care about scope use.
- Don't show settings/API key entry — do it before recording.
