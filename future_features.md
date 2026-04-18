# Future Features

---

## Load room data from rooms.json via fetch()

Instead of a `rooms.js` script file, load room data from a `rooms.json` file using the `fetch()` API.

**Why:** Pure JSON is a cleaner data format with no JavaScript syntax — easier to edit, validate, and eventually swap out (e.g. loading different question sets for different difficulty levels or themes).

**Consideration:** Requires the page to be served over HTTP. Will not work when opening `index.html` directly from the filesystem (`file://` protocol) due to browser CORS restrictions. Fine for GitHub Pages.
