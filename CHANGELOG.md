# Changelog

All notable changes to TextCaptureKit are documented here.

## 0.1.2 — 2026-09-19

### Changed

- Adopted Agent Guidelines `0.0.33` and the Swift package compiler-settings baseline.
- Declared Swift 6, warnings as errors, and the required upcoming language features for every package target.
- Made imports and existential types explicit where required by the stricter compiler policy without intentionally changing runtime behavior.


## Unreleased

## 0.1.1 - 2026-09-13

### Added

- Added privacy-safe, emoji-prefixed recognition outcome logs through AppLogger.

## 0.1.0 - 2026-09-12

### Added

- Bootstrapped the Swift package, DocC catalog, CI/CD workflows, shared AgentGuidelines integration, and repository policy.
- Added configurable on-device Vision text recognition with structured candidates, confidence, and normalized bounds.
- Added deterministic plain-text projection and automatic encoded-image orientation handling.
