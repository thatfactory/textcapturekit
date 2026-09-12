import Foundation
import ImageIO
import Vision

/// Recognizes text in encoded still images with Apple's on-device Vision framework.
public struct TextCaptureRecognizer: Sendable {
    /// Creates a text recognizer.
    public init() {}

    /// Recognizes structured text in an encoded still image.
    ///
    /// Cancellation propagates as `CancellationError`; other Vision failures are normalized.
    ///
    /// - Parameters:
    ///   - image: The encoded still image to recognize.
    ///   - configuration: Recognition policy selected by the host.
    /// - Returns: Structured observations in deterministic reading order.
    /// - Throws: `TextCaptureError.recognitionFailed` when Vision cannot process the image.
    public func recognize(
        image: TextCaptureImage,
        configuration: TextCaptureRequest = TextCaptureRequest()
    ) async throws -> TextCaptureResult {
        var request = RecognizeTextRequest()
        request.automaticallyDetectsLanguage = configuration.automaticallyDetectsLanguage
        request.customWords = configuration.customWords
        request.recognitionLanguages = configuration.recognitionLanguages.map(Locale.Language.init(identifier:))
        request.recognitionLevel = configuration.recognitionLevel.visionRecognitionLevel
        request.usesLanguageCorrection = configuration.usesLanguageCorrection

        do {
            let observations = try await request.perform(
                on: image.data,
                orientation: image.orientation.imagePropertyOrientation
            )
            return TextCaptureResult(observations: observations.map(Self.mapObservation))
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            throw TextCaptureError.recognitionFailed
        }
    }

    // MARK: - Private

    /// Maps a Vision observation into package-owned values.
    private static func mapObservation(_ observation: RecognizedTextObservation) -> TextCaptureObservation {
        let bounds = observation.boundingBox.cgRect
        let candidates = observation.topCandidates(3).map {
            TextCaptureCandidate(text: $0.string, confidence: $0.confidence)
        }

        return TextCaptureObservation(
            candidates: candidates,
            boundingBox: TextCaptureBoundingBox(
                x: bounds.origin.x,
                y: bounds.origin.y,
                width: bounds.width,
                height: bounds.height
            )
        )
    }
}

/// Stable failures produced by TextCaptureKit.
public enum TextCaptureError: Error, Sendable, Equatable {
    case recognitionFailed
}

// MARK: - Vision mappings

extension TextCaptureImageOrientation {
    /// The corresponding Image I/O orientation used by Vision.
    fileprivate var imagePropertyOrientation: CGImagePropertyOrientation {
        switch self {
        case .down:
            .down
        case .downMirrored:
            .downMirrored
        case .left:
            .left
        case .leftMirrored:
            .leftMirrored
        case .right:
            .right
        case .rightMirrored:
            .rightMirrored
        case .up:
            .up
        case .upMirrored:
            .upMirrored
        }
    }
}

extension TextCaptureRecognitionLevel {
    /// The corresponding Vision recognition policy.
    fileprivate var visionRecognitionLevel: RecognizeTextRequest.RecognitionLevel {
        switch self {
        case .accurate:
            .accurate
        case .fast:
            .fast
        }
    }
}
