---
name: security-scan
description: Scan code, diffs, pull requests, or repositories for common application-security flaws. Use for security reviews, vulnerability audits, pre-merge security checks, or requests such as "is this secure?", "check for vulnerabilities", and "security scan". Covers SQL injection, debug endpoints, exposed secrets, authentication, ReDoS, stored XSS, error leaks, input and enum validation, and plaintext passwords.
---

# Security Scan

Review requested scope. If scope missing, inspect current uncommitted diff first. State scope and limits.

## Checklist

Check each applicable item:

1. SQL injection: parameterize queries. Never interpolate untrusted input into SQL.
2. Debug endpoints: block debug, test, or admin endpoints from production unless protected and intentional.
3. Exposed secrets: follow safe scan procedure below.
4. Authentication: protect sensitive reads and state-changing routes.
5. ReDoS: reject unsafe user-controlled regexes and nested quantifiers. Bound input.
6. Stored XSS: trace stored input through every render path. Require context-appropriate output encoding.
7. Error leaks: do not return stacks, internal paths, raw exceptions, or driver errors.
8. Input validation: validate type, length, shape, and constraints at boundary.
9. Enum validation: allow-list status, role, type, and similar finite values.
10. Password handling: hash with bcrypt, Argon2, or scrypt. Never log, store, or compare plaintext passwords.

## Safe Secret Scan

Never display secret values, matching lines, diffs containing matches, or raw command output that could contain a value.

Use count-only or filename-and-line-number scans. Limit patterns to requested scope. Prefer `rg --count-matches` for aggregate counts and `rg --files-with-matches` for affected files. If line numbers are needed, use a pattern that matches only variable name or key label, never its value.

Treat a likely credential as compromised. Report file, line number when safe, credential class, and remediation. Do not include value or partial value. Recommend moving it to a secret manager or environment variable and rotating it.

## Report

Report confirmed findings first, ranked Critical, High, Medium, Low. Include:

- Severity and category
- Safe location, such as `path:line`
- Impact and attack path
- Concrete remediation

State checklist items reviewed with no finding as "no issue found" only when evidence supports it. Otherwise state limitation. Read [remediation guidance](references/remediation.md) for detailed fixes.
