import Foundation

/// One text candidate reported for a recognized region.
public struct TextCaptureCandidate: Sendable, Hashable {
    /// The recognized text.
    public let text: String

    /// Vision's confidence in the candidate, expressed from zero through one.
    public let confidence: Float

    /// Creates a recognized-text candidate.
    ///
    /// - Parameters:
    ///   - text: The recognized text.
    ///   - confidence: Vision's confidence in the candidate.
    public init(text: String, confidence: Float) {
        self.text = text
        self.confidence = confidence
    }
}
