# Remediation Guidance

Deeper fix guidance per checklist item, for when a one-line recommendation
in a `ReportFindings` entry isn't enough.

## 1. SQL injection
Use parameterized/prepared statements or an ORM's query builder, never
string-concatenate or template user input into SQL. `db.query('SELECT * FROM users WHERE id = ?', [id])`,
not `` `SELECT * FROM users WHERE id = ${id}` ``.

## 2. Debug endpoint in production
Gate the route behind an environment check (`if (process.env.NODE_ENV !== 'production')`)
or remove it before merging. Never rely on "nobody will guess the URL."

## 3. Hardcoded secrets
Scan method: see [secret-scanning.md](secret-scanning.md). Fix is always: move
the value to an env var / secret manager, rotate the exposed credential
(it's compromised the moment it hit version control, even after removal).

## 4. Missing authentication
Add the same auth/session/token middleware used by the app's other
protected routes. If unsure what pattern the codebase uses, check a
neighboring route that is already protected and mirror it.

## 5. Regex injection (ReDoS)
Rewrite nested quantifiers to remove ambiguity (`(a+)+` → `a+`), or bound
input length before the regex runs, or use a non-backtracking engine.
Test with a pathological input (e.g. `"a".repeat(30) + "!"`) and confirm
it doesn't hang.

## 6. Stored XSS
Escape on output, not just on input. Encode for the context you're
rendering into (HTML entity encoding for HTML bodies, JS string escaping
for inline scripts). Most frameworks auto-escape by default; check
whether the code opted out (`dangerouslySetInnerHTML`, `| safe`, raw
template interpolation) and whether that opt-out is actually necessary.

## 7. Error info leak
Log the full error server-side; return a generic message and an opaque
error ID to the client. Never forward `err.stack`, `traceback.format_exc()`,
or raw driver error messages in an API response.

## 8. No input validation
Validate type, length, and shape at the boundary before the value is
used. A schema validator (zod, joi, pydantic, etc.) is usually less
error-prone than hand-rolled checks.

## 9. No enum validation
Validate against the allowed set explicitly (`status in ['active', 'closed', 'pending']`)
rather than accepting any string. Reject unknown values instead of
silently storing them.

## 10. Plaintext passwords
Hash with bcrypt, argon2, or scrypt before storing, never store, log, or
compare raw passwords. If existing plaintext passwords are found in a
data store, treat it as an incident: force a reset, don't just add
hashing going forward.
