import Foundation

/// Structured text recognized from one still image.
public struct TextCaptureResult: Sendable, Hashable {
    /// Observations in deterministic reading order.
    public let observations: [TextCaptureObservation]

    /// The leading candidate from each observation, joined as lines.
    public var text: String {
        observations.compactMap { $0.candidates.first?.text }.joined(separator: "\n")
    }

    /// Creates a recognition result and normalizes its reading order.
    ///
    /// - Parameter observations: The recognized observations in any order.
    public init(observations: [TextCaptureObservation]) {
        self.observations = observations.sorted(by: Self.precedesInReadingOrder)
    }

    /// Orders observations from top to bottom and then leading to trailing.
    private static func precedesInReadingOrder(
        _ left: TextCaptureObservation,
        _ right: TextCaptureObservation
    ) -> Bool {
        let leftLine = lineIdentifier(for: left)
        let rightLine = lineIdentifier(for: right)

        if leftLine != rightLine {
            return leftLine > rightLine
        }

        if left.boundingBox.x != right.boundingBox.x {
            return left.boundingBox.x < right.boundingBox.x
        }

        if left.boundingBox.y != right.boundingBox.y {
            return left.boundingBox.y > right.boundingBox.y
        }

        return left.candidates.first?.text ?? "" < right.candidates.first?.text ?? ""
    }

    /// Groups nearby vertical centers into deterministic one-percent image bands.
    private static func lineIdentifier(for observation: TextCaptureObservation) -> Int {
        let verticalCenter = observation.boundingBox.y + observation.boundingBox.height / 2
        return Int((verticalCenter * 100).rounded())
    }
}
