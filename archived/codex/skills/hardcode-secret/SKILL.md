---
name: hardcode-secret
description: Safely scan code, diffs, or repositories for hardcoded credentials, API keys, tokens, passwords, private keys, and connection strings. Use for secret-leak checks or when reviewing code for exposed credentials. Prevent secret values from entering command output or conversation history.
---

# Hardcoded Secret Scan

Identify requested scope. If scope missing, inspect current uncommitted diff first.

## Safety Rules

1. Never print raw matched lines, values, diffs, or patches that may contain credentials.
2. Use count-only or filename-only search output. Prefer `rg --count-matches` and `rg --files-with-matches`.
3. Use filename and line number only when line output can match identifier or key label without matching value.
4. For large generated output, store temporary data only under `/tmp`, scan it without printing content, then remove it.
5. Report verdict, scope, match count, file paths, safe line numbers, and credential class. Never report values or fragments.

## Detection

Look for assignments or literals that plausibly embed credentials: private-key headers, API key and token prefixes, passwords, secret environment-variable assignments, cloud access keys, bearer tokens, database connection strings, and high-entropy values attached to credential-like names.

Exclude known safe placeholders, test fixtures, redacted values, and public identifiers only after inspecting surrounding code safely. Do not mark unknown values safe merely because they are short.

## Response

If no plausible credential exists, report clean scope and method. If a match exists, treat it as exposed. Identify safe location and type, direct removal to a secret manager or environment variable, and recommend revoke or rotation. Explain that deleting from present code does not remove historical exposure.
