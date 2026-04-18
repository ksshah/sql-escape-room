# Design Decisions

---

## 2026-04-18 — Move room data to rooms.js

Extracted the `ROOMS` array (questions, answers, hints, stories) from `index.html` into a separate `rooms.js` file, loaded via `<script src="rooms.js">`.

**Why:** Keeps `index.html` focused on structure and game logic. With all question data in one place, adding, editing, or reordering rooms no longer requires touching the main HTML file. Easier to maintain as the question set grows.

---

## 2026-04-18 — Remove live leaderboard

Removed the leaderboard tab and all associated code from the game.

**Why:** The goal of this escape room is learning SQL, not competing. A live leaderboard showing everyone's real-time progress creates unnecessary pressure — beginners may feel anxious seeing others ahead of them and rush through questions instead of actually understanding the query. Removing it lets participants work at their own pace without fear of judgment.
