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

---

## Hint system after first wrong answer

After a player submits an incorrect answer for the first time on a room, reveal a hint — either inline below the query editor or via a dedicated "Show Hint" button that unlocks after the first failed attempt.

**Why:** A wrong answer with no feedback is frustrating and can stall a session completely. A hint nudges players in the right direction without giving the answer away, keeping the experience moving.

**How:** Track attempt count per room in state. On the second render of a wrong-answer state (or on button click), display a `hint` field sourced from each room's config in `rooms.js`. The hint should guide SQL reasoning (e.g. "Try filtering on the WHERE clause using a date range") rather than reveal the answer directly.

---

## Visit counter

Track and display how many times the page has been visited.

**Why:** Adds a social signal for players — knowing others have played creates a sense of shared experience. Also useful for understanding reach without setting up full analytics.

**How:** Use a lightweight third-party counter service (e.g. hits.seeyoufarm.com or a similar free badge provider) embedded as an `<img>` tag, or wire up a small serverless function (e.g. Cloudflare Worker or Vercel Edge Function) that increments a KV counter on each page load. Display the count somewhere unobtrusive, such as the footer.

---

## Sound effects with mute toggle

Add audio feedback to key game moments — correct answer, wrong answer, room transition, and game completion — with a persistent mute button.

**Why:** Sound makes the escape-room atmosphere more immersive. A mute toggle is essential so players in shared or quiet environments aren't disrupted.

**How:** Use the Web Audio API or short `.mp3`/`.ogg` files loaded via `<audio>` elements. Trigger sounds from the same event handlers that update game state. Store the mute preference in `localStorage` so it persists across rooms. Display a speaker icon (e.g. 🔊 / 🔇) in the UI corner that toggles the preference.
