const ROOMS = [
  {
    title: "Headcount Report",
    difficulty: 1,
    story: "Welcome to MegaCorp Industries. It's your first day in the Investigations Unit. Before anything else, your manager needs a quick sanity check — <strong>how many employees</strong> are currently in the system? Simple question. Prove you know how to query a database.",
    question: "How many employees are in the employees table? Your answer is the number.",
    tables: ["employees"],
    answer: "40",
    hint: "SELECT COUNT(*) FROM employees"
  },
  {
    title: "Engineering Roll Call",
    difficulty: 1,
    story: "The Security team is doing a building access audit. They need a count of all <strong>active employees in Engineering</strong> (dept_id = 1) to cross-check against their badge records. How many are there?",
    question: "How many employees have a status of 'active' and a dept_id of 1? Your answer is the number.",
    tables: ["employees"],
    answer: "6",
    hint: "Use WHERE with two conditions joined by AND"
  },
  {
    title: "The Big Department",
    difficulty: 2,
    story: "HR is restructuring the org chart and needs to know which department has the <strong>most headcount</strong>. They want the dept_id of the largest department — not the name, just the ID number.",
    question: "Which dept_id has the most employees? Your answer is the dept_id number.",
    tables: ["employees"],
    answer: "1",
    hint: "GROUP BY dept_id, then ORDER BY count maybe"
  },
  {
    title: "The Big Spender",
    difficulty: 2,
    story: "The CFO is reviewing department budgets before the board meeting. She wants to know which department was allocated the <strong>highest budget</strong> of all. Find it fast — the meeting starts in 10 minutes.",
    question: "What is the name of the department with the highest budget?",
    tables: ["departments"],
    answer: "EXECUTIVE",
    hint: "ORDER BY budget DESC, LIMIT 1 — no JOIN needed"
  },
  {
    title: "The Ghost Payroll",
    difficulty: 3,
    story: "Security has discovered something alarming — a <strong>terminated employee</strong> is still receiving payments and has been accessing company systems. This is a serious breach. Find the ghost.",
    question: "Find the last name of the employee whose status is 'terminated' and appears in the access_log. Your answer is their last name.",
    tables: ["access_log", "employees"],
    answer: "WERNER",
    hint: "JOIN access_log to employees and filter WHERE status = 'terminated'"
  },
  {
    title: "The Resource Hoarder",
    difficulty: 3,
    story: "One employee has been quietly accumulating hours across multiple projects — far more than anyone else at MegaCorp. The ops team suspects <strong>timesheet inflation</strong>. Find the culprit.",
    question: "Find the name of the employee with the highest total assigned hours across all projects. Your answer is their last name.",
    tables: ["assignments","employees"],
    answer: "CHEN",
    hint: "SUM(hours), GROUP BY employee, ORDER BY DESC, LIMIT 1"
  },
  {
    title: "The Expense Scandal",
    difficulty: 4,
    story: "MegaCorp has a strict rule: <strong>no expense over $10,000 can be self-approved</strong>. Someone shattered this rule — and the amount is staggering. The amount itself is your next key.",
    question: "Find the employee who submitted an expense over $10,000 where approved_by equals their own employee_id. Your answer is the transaction amount.",
    tables: ["transactions", "employees"],
    answer: "48000",
    hint: "Filter: type = 'expense', amount > 10000, approved_by = employee_id"
  },
  {
    title: "Ghosts of Projects Past",
    difficulty: 4,
    story: "The ops team has flagged a resource allocation concern — some employees are still listed as assigned to projects that are no longer active (either completed or cancelled). Until they're formally reassigned, MegaCorp is carrying a liability. Find out how many people are affected.",
    question: "How many unique employees are currently assigned to projects that are no longer active (status is either 'completed' or 'cancelled')? Your answer is the number.",
    tables: ["assignments", "projects"],
    answer: "18",
    hint: "COUNT(DISTINCT ...), JOIN assignments to projects, filter WHERE status != 'active'"
  },
  {
    title: "The Double Agent",
    difficulty: 3,
    story: "The Legal team is under scrutiny. Intelligence suggests one of their employees was assigned to a <strong>cancelled project</strong> AND also accessed the LEGAL_VAULT system — a combination that points to an inside leak.",
    question: "Find the last name of the Legal department employee assigned to a cancelled project who also has a 'download' action in the access_log. Answer with their last name.",
    tables: ["employees", "departments", "assignments", "projects", "access_log"],
    answer: "MARSH",
    hint: "You need 5 JOINs. Filter: dept name = 'Legal', project status = 'cancelled', action = 'download'"
  },
  {
    title: "BOSS: The Mastermind",
    difficulty: 5,
    story: "You've uncovered fraud, ghost employees, a saboteur, and a terminated spy. But someone is orchestrating it all. Intelligence points to a <strong>manager</strong> whose direct reports collectively received the highest total in salary and bonus payments. Find the Mastermind.",
    question: "Find the manager whose direct reports have the highest combined salary + bonus transaction total. Answer with their last name.",
    tables: ["employees", "transactions"],
    answer: "HARLOW",
    hint: "JOIN employees to themselves on manager_id, JOIN to transactions, filter type IN ('salary','bonus'), GROUP BY manager"
  }
];
