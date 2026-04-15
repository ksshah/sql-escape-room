-- ============================================================
--  MEGACORP INDUSTRIES — SQL ESCAPE ROOM DATABASE
-- ============================================================

-- ============================================================
--  SCHEMA
-- ============================================================

CREATE TABLE departments (
  id        INTEGER PRIMARY KEY,
  name      TEXT NOT NULL,
  location  TEXT NOT NULL,
  budget    REAL NOT NULL
);

CREATE TABLE employees (
  id          INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,
  dept_id     INTEGER REFERENCES departments(id),
  manager_id  INTEGER REFERENCES employees(id),
  salary      REAL NOT NULL,
  hire_date   TEXT NOT NULL,
  status      TEXT NOT NULL DEFAULT 'active'  -- 'active' | 'terminated'
);

CREATE TABLE projects (
  id          INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,
  dept_id     INTEGER REFERENCES departments(id),
  budget      REAL NOT NULL,
  start_date  TEXT NOT NULL,
  end_date    TEXT,
  status      TEXT NOT NULL  -- 'active' | 'completed' | 'cancelled'
);

CREATE TABLE assignments (
  employee_id  INTEGER REFERENCES employees(id),
  project_id   INTEGER REFERENCES projects(id),
  hours        REAL NOT NULL,
  role         TEXT NOT NULL,
  PRIMARY KEY (employee_id, project_id)
);

CREATE TABLE transactions (
  id           INTEGER PRIMARY KEY,
  employee_id  INTEGER REFERENCES employees(id),
  amount       REAL NOT NULL,
  type         TEXT NOT NULL,  -- 'salary' | 'bonus' | 'expense' | 'penalty'
  tx_date      TEXT NOT NULL,
  approved_by  INTEGER REFERENCES employees(id)
);

CREATE TABLE access_log (
  id           INTEGER PRIMARY KEY,
  employee_id  INTEGER REFERENCES employees(id),
  system_name  TEXT NOT NULL,
  action       TEXT NOT NULL,  -- 'login' | 'download' | 'delete' | 'modify'
  log_date     TEXT NOT NULL
);

-- ============================================================
--  DEPARTMENTS  (10 rows)
-- ============================================================
INSERT INTO departments VALUES
  (1,  'Engineering',       'Floor 3',  1200000),
  (2,  'Finance',           'Floor 1',   800000),
  (3,  'Marketing',         'Floor 2',   600000),
  (4,  'HR',                'Floor 1',   400000),
  (5,  'Legal',             'Floor 4',   500000),
  (6,  'Operations',        'Floor 2',   900000),
  (7,  'Sales',             'Floor 3',   700000),
  (8,  'Data Science',      'Floor 3',  1100000),
  (9,  'Security',          'Floor 4',   450000),
  (10, 'Executive',         'Floor 5',  2000000);

-- ============================================================
--  EMPLOYEES  (40 rows)
-- ============================================================
INSERT INTO employees VALUES
-- Executive
  (1,  'Victoria Harlow',   10, NULL, 210000, '2015-03-01', 'active'),
  (2,  'Marcus Dean',       10,    1, 195000, '2016-06-15', 'active'),
-- Engineering
  (3,  'Priya Nair',         1,    1,  98000, '2018-07-01', 'active'),
  (4,  'Leon Fischer',       1,    3,  87000, '2019-02-14', 'active'),
  (5,  'Aisha Okonkwo',      1,    3,  91000, '2020-05-20', 'active'),
  (6,  'Tom Reyes',          1,    3,  76000, '2021-11-01', 'active'),
  (7,  'Dana Bloom',         1,    3,  72000, '2022-03-15', 'active'),
  (8,  'Chris Lam',          1,    3,  68000, '2023-01-10', 'active'),
-- Finance
  (9,  'Sandra Cole',        2,    1,  95000, '2017-04-01', 'active'),
  (10, 'Derek Voss',         2,    9,  82000, '2018-09-01', 'active'),
  (11, 'Yuki Tanaka',        2,    9,  78000, '2020-01-15', 'active'),
  (12, 'Omar Farouk',        2,    9,  75000, '2021-07-01', 'active'),
  (13, 'Bella Grant',        2,    9,  69000, '2022-10-01', 'active'),
-- Marketing
  (14, 'James Whitfield',    3,    1,  88000, '2017-08-01', 'active'),
  (15, 'Carla Mendez',       3,   14,  74000, '2019-06-01', 'active'),
  (16, 'Finn O''Brien',      3,   14,  70000, '2020-09-01', 'active'),
  (17, 'Zoe Park',           3,   14,  67000, '2022-02-01', 'active'),
-- HR
  (18, 'Ruth Adeyemi',       4,    1,  82000, '2016-11-01', 'active'),
  (19, 'George Papas',       4,   18,  71000, '2019-04-01', 'active'),
  (20, 'Nina Sousa',         4,   18,  66000, '2021-08-01', 'active'),
-- Legal
  (21, 'Howard Kim',         5,    1,  99000, '2017-01-01', 'active'),
  (22, 'Lydia Marsh',        5,   21,  85000, '2018-05-01', 'active'),
  (23, 'Patrick Eze',        5,   21,  81000, '2020-03-01', 'active'),
-- Operations
  (24, 'Denise Ruiz',        6,    1,  90000, '2016-07-01', 'active'),
  (25, 'Walt Huang',         6,   24,  77000, '2018-12-01', 'active'),
  (26, 'Fatima Al-Amin',     6,   24,  73000, '2020-06-15', 'active'),
  (27, 'Raj Patel',          6,   24,  71000, '2021-01-01', 'active'),
-- Sales
  (28, 'Nancy Osei',         7,    1,  93000, '2017-03-01', 'active'),
  (29, 'Luca Bianchi',       7,   28,  80000, '2019-10-01', 'active'),
  (30, 'Tara Flynn',         7,   28,  76000, '2020-07-01', 'active'),
  (31, 'Ben Nakamura',       7,   28,  74000, '2021-05-01', 'active'),
-- Data Science
  (32, 'Iris Chen',          8,    1, 105000, '2018-02-01', 'active'),
  (33, 'Kwame Asante',       8,   32,  94000, '2019-07-01', 'active'),
  (34, 'Sofia Reyes',        8,   32,  89000, '2020-11-01', 'active'),
  (35, 'Nico Dubois',        8,   32,  86000, '2021-09-01', 'active'),
-- Security
  (36, 'Hank Morrison',      9,    1,  91000, '2016-05-01', 'active'),
  (37, 'Leila Nassir',       9,   36,  79000, '2019-08-01', 'active'),
  (38, 'Darius Cole',        9,   36,  77000, '2021-03-01', 'active'),
-- Terminated / ghost employees  (key for several puzzles)
  (39, 'Jordan Blake',    NULL, NULL,  55000, '2023-06-01', 'active'),   -- no dept
  (40, 'Felix Werner',       1,    3,  65000, '2020-04-01', 'terminated');

-- ============================================================
--  PROJECTS  (12 rows)
-- ============================================================
INSERT INTO projects VALUES
  (1,  'ATLAS',       8,  980000, '2022-01-01', '2023-06-30', 'completed'),
  (2,  'TITAN',       1, 1500000, '2023-03-01', NULL,         'active'),
  (3,  'NOVA',        3,  430000, '2022-06-01', '2023-01-31', 'completed'),
  (4,  'PHANTOM',     9,  670000, '2023-01-01', NULL,         'active'),
  (5,  'HORIZON',     6,  820000, '2021-09-01', '2022-12-31', 'completed'),
  (6,  'CIPHER',      8, 1200000, '2023-05-01', NULL,         'active'),
  (7,  'MERCURY',     2,  350000, '2022-03-01', '2022-11-30', 'completed'),
  (8,  'SENTINEL',    9,  540000, '2023-02-01', NULL,         'active'),
  (9,  'ECHO',        7,  290000, '2022-07-01', '2023-03-31', 'completed'),
  (10, 'MIRAGE',      3,  610000, '2023-06-01', NULL,         'active'),
  (11, 'BLACKOUT',    1,  750000, '2023-08-01', NULL,         'active'),
  (12, 'ORPHAN',      5,  480000, '2022-10-01', '2023-04-30', 'cancelled');

-- ============================================================
--  ASSIGNMENTS
-- ============================================================
INSERT INTO assignments VALUES
-- ATLAS (data science project)
  (32, 1, 480, 'lead'),
  (33, 1, 320, 'analyst'),
  (34, 1, 290, 'analyst'),
  (3,  1, 150, 'engineer'),
-- TITAN (engineering — intentionally NO assignments yet, used in room 2)
-- NOVA (marketing)
  (14, 3, 200, 'lead'),
  (15, 3, 180, 'contributor'),
  (16, 3, 160, 'contributor'),
-- PHANTOM (security)
  (36, 4, 300, 'lead'),
  (37, 4, 250, 'analyst'),
  (38, 4, 220, 'analyst'),
-- HORIZON (operations)
  (24, 5, 400, 'lead'),
  (25, 5, 350, 'engineer'),
  (26, 5, 310, 'engineer'),
-- CIPHER (data science)
  (32, 6, 200, 'lead'),
  (33, 6, 180, 'analyst'),
  (35, 6, 170, 'analyst'),
  (4,  6, 140, 'engineer'),
-- MERCURY (finance)
  (9,  7, 220, 'lead'),
  (10, 7, 190, 'analyst'),
  (11, 7, 170, 'analyst'),
-- SENTINEL (security)
  (36, 8, 260, 'lead'),
  (37, 8, 200, 'analyst'),
-- ECHO (sales)
  (28, 9, 180, 'lead'),
  (29, 9, 150, 'contributor'),
  (30, 9, 140, 'contributor'),
-- MIRAGE (marketing)
  (14, 10, 220, 'lead'),
  (17, 10, 190, 'contributor'),
-- BLACKOUT (engineering — Felix Werner also assigned even though terminated)
  (3,  11, 200, 'lead'),
  (4,  11, 180, 'engineer'),
  (5,  11, 160, 'engineer'),
  (40, 11, 120, 'engineer'),  -- terminated employee still on project!
-- ORPHAN (legal — cancelled, used in room 6)
  (21, 12, 100, 'lead'),
  (22, 12,  80, 'analyst');

-- ============================================================
--  TRANSACTIONS  (carefully crafted for puzzles)
-- ============================================================
INSERT INTO transactions VALUES
-- Normal salary payments (just a few examples)
  (1,  3,  98000, 'salary',  '2024-01-31', 1),
  (2,  9,  95000, 'salary',  '2024-01-31', 1),
  (3, 32, 105000, 'salary',  '2024-01-31', 1),
-- Bonuses for top performers
  (4,  3,   5000, 'bonus',   '2024-01-15', 2),
  (5, 32,   8000, 'bonus',   '2024-01-15', 2),
  (6, 33,   6000, 'bonus',   '2024-01-15', 2),
  (7, 28,   7000, 'bonus',   '2024-01-15', 2),
-- Suspicious: Derek Voss (id=10) approved 5 bonuses for himself in Jan 2024
  (8,  10,  4000, 'bonus',   '2024-01-03', 10),
  (9,  10,  4000, 'bonus',   '2024-01-09', 10),
  (10, 10,  4000, 'bonus',   '2024-01-14', 10),
  (11, 10,  4000, 'bonus',   '2024-01-20', 10),
  (12, 10,  4000, 'bonus',   '2024-01-27', 10),
-- Expense claims
  (13, 14,  1200, 'expense', '2024-01-10', 9),
  (14, 15,   890, 'expense', '2024-01-12', 14),
  (15, 21,  2200, 'expense', '2024-01-08', 1),
  (16, 36,  3100, 'expense', '2024-01-18', 1),
  (17, 24,  1500, 'expense', '2024-01-22', 1),
-- Penalty
  (18, 40,  2000, 'penalty', '2024-01-05', 1),
-- Large suspicious expense by Sandra Cole (Finance head) approved by herself
  (19,  9, 48000, 'expense', '2024-02-01',  9),
-- Jordan Blake (no dept) received a salary payment — ghost employee
  (20, 39, 55000, 'salary',  '2024-01-31',  2);

-- ============================================================
--  ACCESS LOG  (for security / data exfil puzzles)
-- ============================================================
INSERT INTO access_log VALUES
  (1,  36, 'PAYROLL',    'login',    '2024-01-15 09:00'),
  (2,  36, 'PAYROLL',    'download', '2024-01-15 09:04'),
  (3,  37, 'PAYROLL',    'login',    '2024-01-15 09:30'),
  (4,  10, 'PAYROLL',    'login',    '2024-01-20 08:55'),
  (5,  10, 'PAYROLL',    'modify',   '2024-01-20 08:58'),
  (6,  10, 'PAYROLL',    'download', '2024-01-20 09:02'),
  (7,  22, 'LEGAL_VAULT','login',    '2024-01-22 14:00'),
  (8,  22, 'LEGAL_VAULT','download', '2024-01-22 14:05'),
  (9,  33, 'MODEL_REPO', 'login',    '2024-01-25 11:00'),
  (10, 33, 'MODEL_REPO', 'download', '2024-01-25 11:03'),
  (11, 33, 'MODEL_REPO', 'delete',   '2024-01-25 11:07'),
  (12,  5, 'SOURCE_CODE','login',    '2024-01-28 16:00'),
  (13,  5, 'SOURCE_CODE','download', '2024-01-28 16:04'),
  (14, 40, 'SOURCE_CODE','login',    '2024-02-01 22:15'),  -- terminated employee!
  (15, 40, 'SOURCE_CODE','download', '2024-02-01 22:18'),
  (16, 39, 'HR_SYSTEM',  'login',    '2024-01-30 10:00'),  -- ghost employee
  (17, 39, 'HR_SYSTEM',  'modify',   '2024-01-30 10:05');


-- ============================================================
--  QUICK VERIFICATION QUERIES
--  Run these after pasting to confirm everything loaded.
-- ============================================================

-- Should return 10
SELECT COUNT(*) AS dept_count FROM departments;

-- Should return 40
SELECT COUNT(*) AS emp_count FROM employees;

-- Should return 12
SELECT COUNT(*) AS project_count FROM projects;

-- Should return 34
SELECT COUNT(*) AS assignment_count FROM assignments;

-- Should return 20
SELECT COUNT(*) AS transaction_count FROM transactions;

-- Should return 17
SELECT COUNT(*) AS log_count FROM access_log;
