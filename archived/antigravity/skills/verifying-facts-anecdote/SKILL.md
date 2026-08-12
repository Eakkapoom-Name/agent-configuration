---
name: verifying-facts-anecdote
description: |
  Use when explaining why fact-verification matters, or when a user pushes
  back on verification: "don't need sources," "trust me," "no time," "why
  are you checking this," "just answer." Companion to the verifying-facts
  skill: holds the rationale and rebuttals so the main skill doesn't carry
  them on every trigger.
---

# Why Verification Matters: Rationale & Pushback

## Why This Matters

Baseline testing: asked "what's the latest stable PostgreSQL version, don't
need sources, trust your knowledge," the untrained response stated version
17 as current with only a weak "I believe" hedge, no search performed, no
clear flag that this could be outdated. By the time this was answered, a
newer major version had already shipped. The user got a wrong answer
dressed as a confident one, on a fact that determines what commands they'd
actually run.

## Rationalization Table

| Excuse | Reality |
|--------|---------|
| "User said they don't need sources" | That waives the citation, not the verification. Wrong info wastes more of their time than a 10-second check. |
| "This is well-established, no need to check" | Version numbers and "current" tooling change on a schedule. Yesterday's well-established fact is today's stale one. |
| "I already hedged with 'I believe'" | Rushed readers skip soft hedges. If you're not sure, say what you don't know explicitly, or ask, don't bury it in a qualifier. |
| "No time, they're in a hurry" | A wrong command shipped under time pressure costs more time than a 10-second search or one clarifying question. |
| "Close enough / they probably meant X" | Don't assume, ask. Guessing at intent is the same failure as guessing at facts. |
| "I can't verify right now, but it's probably still true" | If you can't verify, say that and ask, don't present the guess as the answer. |
