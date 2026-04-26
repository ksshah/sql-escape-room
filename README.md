# MegaCorp SQL Escape Room

A browser-based SQL learning game where players take on the role of an investigator uncovering fraud, ghost employees, and corporate conspiracies at MegaCorp Industries — one SQL query at a time.

**Live site:** https://ksshah.github.io/sql-escape-room/

---

## What is this?

The SQL Escape Room is a 10-room investigation game where each room presents a story-driven scenario and a SQL challenge. Players query a real database in [DB-Fiddle](https://www.db-fiddle.com/f/tzyrRvSjUuK6WwnfJZpnKC/2) and submit their answer to unlock the next room.

It's designed for **SQL beginners** — no setup, no installation, just open the link and start querying.

---

## How to play

1. Open the live site
2. Read the mission briefing and click **Begin Investigating**
3. Enter your name and the DB-Fiddle URL provided by the host
4. For each room, read the story, open DB-Fiddle, write your SQL query, and submit the result
5. Wrong answers unlock progressive hints — the more you try, the more guidance you get

**Answers are not case-sensitive** — `harlow`, `HARLOW`, and `Harlow` all work.

---

## The database

The MegaCorp database has 6 tables:

| Table | Description |
|---|---|
| `employees` | All MegaCorp staff — name, department, manager, salary, status |
| `departments` | Department names, locations, and budgets |
| `projects` | Active, completed, and cancelled projects |
| `assignments` | Which employees are assigned to which projects, and for how many hours |
| `transactions` | Salary, bonus, expense, and penalty payments |
| `access_log` | System access records — logins, downloads, deletions, modifications |

---

## The rooms

| # | Title | Difficulty |
|---|---|---|
| 1 | Headcount Report | ★☆☆☆☆ |
| 2 | Engineering Roll Call | ★☆☆☆☆ |
| 3 | The Big Department | ★★☆☆☆ |
| 4 | The Big Spender | ★★☆☆☆ |
| 5 | The Ghost Payroll | ★★★☆☆ |
| 6 | The Resource Hoarder | ★★★☆☆ |
| 7 | The Expense Scandal | ★★★★☆ |
| 8 | Ghosts of Projects Past | ★★★★☆ |
| 9 | The Double Agent | ★★★☆☆ |
| 10 | BOSS: The Mastermind | ★★★★★ |

Rooms cover: `SELECT`, `WHERE`, `COUNT`, `GROUP BY`, `ORDER BY`, `JOIN`, `SUM`, `DISTINCT`, and self-joins.

---

## Running it as a host

This game is designed to be run as a **facilitated session** — a workshop, meetup, or classroom.

1. Set up the database in [DB-Fiddle](https://www.db-fiddle.com) using `sql_schema.sql`
2. Share the DB-Fiddle URL with participants at the start of the session
3. Participants enter the URL on the login screen — this is how everyone queries the same database
4. No server or backend required — everything runs in the browser

---

## Project structure

```
index.html               — game UI and logic
rooms.js                 — all 10 rooms (questions, answers, hints, stories)
db.js                    — MegaCorp database encoded as base64 (used by sql.js at runtime)
sql_schema.sql           — source of truth for the database schema and seed data
wid_sql_escape_room.db   — compiled SQLite binary, used to generate db.js
design_decisions.md      — log of key decisions and the reasoning behind them
future_features.md       — ideas for future improvements
```

### How the database works

The game runs entirely in the browser using [sql.js](https://sql.js.org), a WebAssembly port of SQLite. The database is embedded in `db.js` as a base64 string — no external database or server needed.

`wid_sql_escape_room.db` and `db.js` are both generated from `sql_schema.sql`, which is the source of truth. If you ever need to update the database (e.g. add new data for new questions), here's how to rebuild:

```bash
# 1. Recreate the .db file from the schema
sqlite3 wid_sql_escape_room.db < sql_schema.sql

# 2. Regenerate db.js from the new .db file
echo "const DB_BASE64 = \"$(base64 -i wid_sql_escape_room.db)\";" > db.js
```

`wid_sql_escape_room.db` is not used at runtime — only `db.js` is. But keep it in the repo as it makes rebuilding straightforward.

---

## Tech stack

- Plain HTML, CSS, and JavaScript — no frameworks, no build step
- [DB-Fiddle](https://www.db-fiddle.com) for in-browser SQL querying
- GitHub Pages for hosting
- Player progress is saved in `localStorage`

---

## Inspiration

This project was created for the **Women in Data Boston** chapter as part of their April 2026 event, where the theme was learning SQL. The goal was to make SQL approachable and fun through a story-driven format — rather than dry exercises, players uncover a corporate conspiracy using real queries against a real database.

---

## Contributing

If you'd like to suggest new rooms, report a bug, or improve the UI, feel free to open an issue or a PR.
