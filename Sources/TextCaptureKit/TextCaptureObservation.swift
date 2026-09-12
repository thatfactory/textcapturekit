import Foundation

/// A normalized region containing recognized text candidates.
public struct TextCaptureObservation: Sendable, Hashable {
    /// Candidates ordered from most to least likely.
    public let candidates: [TextCaptureCandidate]

    /// The observation's normalized image bounds.
    public let boundingBox: TextCaptureBoundingBox

    /// Creates a recognized text observation.
    ///
    /// - Parameters:
    ///   - candidates: Candidates ordered from most to least likely.
    ///   - boundingBox: The observation's normalized image bounds.
    public init(candidates: [TextCaptureCandidate], boundingBox: TextCaptureBoundingBox) {
        self.candidates = candidates
        self.boundingBox = boundingBox
    }
}

/// A rectangle in Vision's normalized lower-left coordinate space.
public struct TextCaptureBoundingBox: Sendable, Hashable {
    /// The rectangle height from zero through one.
    public let height: Double

    /// The rectangle width from zero through one.
    public let width: Double

    /// The horizontal origin from zero through one.
    public let x: Double

    /// The vertical origin from zero through one.
    public let y: Double

    /// Creates a normalized bounding box.
    ///
    /// - Parameters:
    ///   - x: The horizontal origin.
    ///   - y: The vertical origin.
    ///   - width: The rectangle width.
    ///   - height: The rectangle height.
    public init(x: Double, y: Double, width: Double, height: Double) {
        self.height = height
        self.width = width
        self.x = x
        self.y = y
    }
}
