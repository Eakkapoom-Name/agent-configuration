---
name: security-scan
description: |
  Run this fixed 10-item vulnerability checklist (OWASP Top 10 / CWE style)
  whenever reviewing, auditing, or scanning code for security issues: PR
  reviews, pre-merge checks, "is this secure", "check for vulnerabilities",
  "security audit this file/diff/PR", "does this look safe to ship", or any
  request to look over code that mentions security, safety, or
  vulnerabilities. Use this even if the user doesn't name the checklist or
  ask for it by name, treat "review this for security issues" as an
  automatic trigger. Covers: SQL injection, exposed debug endpoints,
  hardcoded secrets, missing auth, ReDoS, stored XSS, error info leaks,
  missing input validation, missing enum validation, plaintext passwords.
  For the hardcoded-secrets check this skill delegates to the
  hardcode-secret skill rather than duplicating it, don't confuse the two.
---

# Security Scan: 10-Item Checklist

Fixed checklist run on every code review / security scan. Check each item
against the code in scope (diff, file, or directory named by the user, or
the current branch's changes if nothing specific was named).

| # | Vulnerability | Severity | What to look for |
|---|---|---|---|
| 1 | SQL injection | Critical | User input concatenated into a query instead of a parameterized/prepared statement |
| 2 | Debug endpoint in production | Critical | `/debug`, `/__debug__`, admin/test routes with no prod guard |
| 3 | Hardcoded secrets | High | **Delegate.** Invoke `hardcode-secret`; fold its verdict in, don't grep here. |
| 4 | Missing authentication | High | Data-mutating/sensitive-read routes with no auth/session/token check |
| 5 | Regex injection (ReDoS) | High | User input reaching a catastrophic-backtracking regex (`(a+)+`, `(a*)*`) |
| 6 | Stored XSS | High | Saved input rendered unescaped in HTML/JS (check write + render paths) |
| 7 | Error info leak | Medium | Stack traces/raw exceptions/internal paths in responses |
| 8 | No input validation | High | Request fields used without type/length/shape checks |
| 9 | No enum validation | Medium | Status/type/role fields accepted as free-form strings |
| 10 | Plaintext passwords | Critical | Passwords stored/logged/compared without hashing (bcrypt/argon2/scrypt) |

## Process

1. Identify scope: the diff, file(s), or directory the user pointed at.
2. Walk items 1, 2, 4-10 directly against the code in scope.
3. For item 3, invoke `hardcode-secret` and use its verdict,
   don't re-implement secret grepping here.
4. Report findings ranked most-severe first (Critical, High, Medium), each
   with a category slug and severity-prefixed summary, e.g.
   `[Critical] Raw SQL string built from req.params.id`. Use the
   `ReportFindings` tool if available; if not (check via ToolSearch first),
   fall back to the same structure as markdown.
5. If an item doesn't apply to the scope, skip it silently.
6. After the 10-item checklist, decide whether to also invoke the
   built-in `security-review` skill on the same scope for broader coverage
   beyond this fixed list. `security-review` is a heavier pass (its own
   multi-stage sub-task pipeline), don't auto-chain it by default.
   - If the user already said which they want (e.g. "full scan," "just the
     checklist," "quick check"), follow that without asking.
   - Otherwise, ask the user first: checklist-only, or also run
     `security-review` for a fuller pass.
   If running it, `security-review` returns its own native format (`# Vuln N: Category:
   file:line` headings with Severity/Description/Exploit Scenario/
   Recommendation bullets), don't pass that through as-is. Convert each of
   its findings into the same shape as the checklist findings before
   merging: a category slug and severity-prefixed one-line summary (e.g.
   `[High] Session token accepted without signature check,
   auth/session.py:42`), folding the exploit scenario/recommendation into
   the finding body the same way checklist items do. De-duplicate anything
   that overlaps an item already reported above, don't double-report the
   same issue under two labels.

See `references/remediation.md` for fix guidance per item when a one-line
recommendation in the finding isn't enough.
