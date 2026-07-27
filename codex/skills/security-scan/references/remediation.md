# Remediation Guidance

## SQL injection

Use parameterized queries, prepared statements, or trusted ORM query builders. Do not concatenate untrusted input into SQL.

## Debug endpoints

Remove endpoint or require production-safe authorization and an explicit environment gate.

## Exposed secrets

Move credential to secret manager or environment variable. Revoke and rotate leaked credential. Removing it from current code does not remove exposure from history.

## Missing authentication

Apply existing application authentication and authorization middleware before sensitive route logic.

## ReDoS

Remove nested ambiguous quantifiers, cap input size, or use non-backtracking regex engine.

## Stored XSS

Encode output for exact render context. Avoid raw HTML APIs unless sanitized by trusted library.

## Error leaks

Log detailed error server-side. Return generic user-safe error plus opaque correlation ID.

## Input and enum validation

Validate request schemas at boundary. Allow-list finite values and reject unknown values.

## Plaintext passwords

Hash new passwords with bcrypt, Argon2, or scrypt. Treat existing plaintext credentials as incident requiring reset.
