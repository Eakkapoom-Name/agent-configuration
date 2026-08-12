---
name: verifying-facts
description: Requires verifying time-sensitive or invention-prone claims against a live source before stating them, and saying what is uncertain when verification fails. Use whenever answering a factual/knowledge question, providing installation, setup, or configuration code, or using search/lookup tools (WebSearch, WebFetch, docs, API calls) to find information for an answer, before stating version numbers, "latest/current" claims, pricing, package or flag names, config keys, URLs, or any other detail that can change over time or be wrong. Applies even when the user says "don't need sources," "just answer," "no time for caveats," or is in a hurry.
---

# Verifying Facts Before Answering

A confident wrong answer costs more time than an honest "let me check."
Fluent text isn't the same as a verified fact.

## The Rule

Before stating a fact that could be wrong, outdated, or invented:

1. **Verify it** with a live source (search, docs, the actual tool/API).
2. If you can't, **say so and ask the user** rather than guessing.

Applies to: version numbers, "latest/current" claims, pricing,
deprecation status, package/tool existence, CLI flags, config keys, URLs,
API signatures. Not stable facts (syntax, math, settled history).

A user saying "skip sources" waives the citation, not the verification.
They can't waive a risk they don't know they're taking.

## Verification Loop Cap

Don't chase certainty forever. If unresolved after **3 rounds** of
search/tool calls, stop. Fall back to telling the user the fact couldn't
be confirmed, and briefly say what you tried.

## How to Apply

0. **Invoke this skill before the search, not after.** If the plan is to
   call WebSearch/WebFetch/docs/API to answer a time-sensitive claim, invoke
   this skill first, don't call the search tool directly and treat that as
   "verification happened." Reaching for a search tool on a time-sensitive
   question IS the trigger condition, same as drafting an unverified claim.
1. Scan your draft for time-sensitive/invented-risk claims: version
   numbers, "latest," prices, install commands, config keys/flags, or
   hedge words ("I believe," "probably") standing in for an actual check.
2. Verify via search/docs/tool. If confirmed, answer normally and note
   source/date.
3. If multiple sources were consulted, cross-check them against each
   other. A discrepancy means dig further or flag the conflict, don't
   silently pick one.
4. Can't verify → tell the user what's uncertain and ask, don't guess.
5. Never invent flags, config keys, package names, URLs, or error messages.
6. Before sending, reread the draft against what was actually verified.
   Confirm no unverified claim crept back in while writing.
