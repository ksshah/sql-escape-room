# Design Decisions

---

## 2026-04-19 — Replace DB-Fiddle with embedded SQLite via sql.js

Removed the dependency on DB-Fiddle entirely. The MegaCorp database is now embedded directly in the page as a base64-encoded SQLite file, loaded at runtime by sql.js — a WebAssembly port of SQLite. Each room has a built-in SQL editor where players write and run queries locally in their browser.

**Why:** DB-Fiddle introduced friction — players had to open an external tab, figure out the interface, and avoid accidentally editing the Schema SQL panel. It was also a runtime dependency outside our control. Embedding the database makes the game fully self-contained: no external tools, no setup, no broken links. The experience is faster, simpler, and more beginner-friendly.

---

## 2026-04-19 — Add instructions screen before agent login

Added a dedicated mission briefing screen as the first thing players see, with a "Begin Investigating" button that leads to the login form.

**Why:** Players were landing straight on the login form with no context. A separate instructions screen gives beginners the onboarding they need — how the game works, how to use DB-Fiddle, and SQL tips — without cluttering the login itself.

---

## 2026-04-18 — Move room data to rooms.js

Extracted the `ROOMS` array (questions, answers, hints, stories) from `index.html` into a separate `rooms.js` file, loaded via `<script src="rooms.js">`.

**Why:** Keeps `index.html` focused on structure and game logic. With all question data in one place, adding, editing, or reordering rooms no longer requires touching the main HTML file. Easier to maintain as the question set grows.

---

## 2026-04-18 — Remove live leaderboard

Removed the leaderboard tab and all associated code from the game.

**Why:** The goal of this escape room is learning SQL, not competing. A live leaderboard showing everyone's real-time progress creates unnecessary pressure — beginners may feel anxious seeing others ahead of them and rush through questions instead of actually understanding the query. Removing it lets participants work at their own pace without fear of judgment.
