# Future Features

---

## Hash answers to prevent inspection via DevTools

Instead of storing plain-text answers in `rooms.js` (e.g. `answer: "HARLOW"`), store a SHA-256 hash of each answer. When a player submits, hash their input and compare against the stored hash — the original answer never appears in the source.

**Why:** Currently anyone can open DevTools, find `rooms.js`, and read every answer directly. Hashing stops casual cheating without requiring a backend. It's not unbreakable — someone determined could brute-force short answers — but it removes the trivial path.

**How:** Use the Web Crypto API (`crypto.subtle.digest`) to hash submissions at runtime. Pre-compute hashes for all answers and replace the plain-text values in `rooms.js`.

---

## Randomised question bank

Instead of a fixed sequence of 10 rooms, maintain a larger pool of questions in a separate config file (e.g. `question_bank.js`). Each session draws a random subset — say 10 from 20+ available questions.

**Why:** Players who replay the game, or groups running multiple sessions, won't get the same questions twice. It also makes it easier to add new questions over time without disrupting the existing set.

**How:** Organise questions by difficulty tier. When building a session, sample a fixed number from each tier to keep the difficulty curve consistent (e.g. 2 easy, 3 medium, 3 hard, 1 boss). The selected subset is shuffled into `ROOMS` at game start.

---

## Load room data from rooms.json via fetch()

Instead of a `rooms.js` script file, load room data from a `rooms.json` file using the `fetch()` API.

**Why:** Pure JSON is a cleaner data format with no JavaScript syntax — easier to edit, validate, and eventually swap out (e.g. loading different question sets for different difficulty levels or themes).

**Consideration:** Requires the page to be served over HTTP. Will not work when opening `index.html` directly from the filesystem (`file://` protocol) due to browser CORS restrictions. Fine for GitHub Pages.
