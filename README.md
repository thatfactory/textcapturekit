<p align="center">
  <a href="https://developer.apple.com/swift/"><img alt="Swift Version" src="https://img.shields.io/badge/Swift-6.4-ea7a50.svg?logo=swift&logoColor=white"></a>
  <a href="https://developer.apple.com/xcode/"><img alt="Xcode Version" src="https://img.shields.io/badge/Xcode-27-50ace8.svg?logo=xcode&logoColor=white"></a>
  <a href="https://developer.apple.com/documentation/vision/recognizetextrequest"><img alt="Platforms" src="https://img.shields.io/badge/iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20visionOS-26%2B-lightgrey.svg?logo=apple&logoColor=white"></a>
  <a href="https://developer.apple.com/documentation/xcode/swift-packages"><img alt="SPM" src="https://img.shields.io/badge/SPM-ready-b68f6a.svg?logo=gitlfs&logoColor=white"></a>
  <a href="https://thatfactory.github.io/textcapturekit/documentation/textcapturekit/"><img alt="DocC" src="https://img.shields.io/badge/DocC-documentation-0288D1.svg?logo=bookstack&logoColor=white"></a>
  <a href="https://en.wikipedia.org/wiki/MIT_License"><img alt="License" src="https://img.shields.io/badge/License-MIT-67ac5b.svg?logo=googledocs&logoColor=white"></a>
  <a href="https://github.com/thatfactory/textcapturekit/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/thatfactory/textcapturekit/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://github.com/thatfactory/textcapturekit/actions/workflows/release.yml"><img alt="Release" src="https://github.com/thatfactory/textcapturekit/actions/workflows/release.yml/badge.svg"></a>
</p>

# TextCaptureKit

TextCaptureKit is a reusable, UI-agnostic wrapper around Apple's Vision text-recognition APIs. It converts host-supplied still images into structured recognized text while preserving encoded orientation, candidates, confidence, and layout for application-owned review and correction.

Camera capture, scanner UI, parsing, persistence, and product presentation remain host responsibilities.

## Documentation

API documentation is published with DocC after a GitHub release. See the [TextCaptureKit documentation](https://thatfactory.github.io/textcapturekit/documentation/textcapturekit/).

TextCaptureKit emits privacy-safe recognition outcomes through AppLogger with subsystem `com.thatfactory.textcapturekit`, category `recognition`, and the canonical 👁️ prefix. It never logs image data or recognized text.

## Requirements

- Swift 6.4
- Xcode 27
- Apple platform versions shown in the badge above
- Swift Package Manager
