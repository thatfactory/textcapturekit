# ``TextCaptureKit``

Recognize text in host-supplied images with Apple's Vision framework while preserving uncertainty for host-owned correction.

## Overview

WortJagd is the first concrete consumer. It supplies encoded still-image data, selects an accuracy and language policy, and receives deterministic plain text together with the candidates, confidence, and normalized bounds that led to it.

By default, ``TextCaptureImage`` reads the encoded image's orientation metadata before recognition. Hosts can provide an explicit orientation when the encoded data has no suitable metadata.

Camera acquisition, correction UI, parsing, and persistence remain host responsibilities. `TextCaptureRecognizer` performs no network requests and retains neither the source image nor its result.

## Recognizing a German notebook capture

```swift
let image = TextCaptureImage(data: encodedImageData)
let request = TextCaptureRequest(
    recognitionLevel: .accurate,
    recognitionLanguages: ["de-DE"],
    automaticallyDetectsLanguage: true,
    usesLanguageCorrection: true
)
let result = try await TextCaptureRecognizer().recognize(
    image: image,
    configuration: request
)
```

The convenience `text` projection uses the leading candidate from each observation in deterministic reading order. Hosts that need richer review can inspect all observations and candidates instead.
