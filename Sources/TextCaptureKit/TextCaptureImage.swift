import Foundation

/// An encoded still image and its display orientation.
public struct TextCaptureImage: Sendable, Hashable {
    /// The encoded image bytes.
    public let data: Data

    /// The orientation required to present the image upright.
    public let orientation: TextCaptureImageOrientation

    /// Creates a still-image input.
    ///
    /// - Parameters:
    ///   - data: The encoded image bytes.
    ///   - orientation: The orientation required to present the image upright.
    public init(data: Data, orientation: TextCaptureImageOrientation = .up) {
        self.data = data
        self.orientation = orientation
    }
}

/// The orientation required to present an encoded still image upright.
public enum TextCaptureImageOrientation: Sendable, Hashable {
    case down
    case downMirrored
    case left
    case leftMirrored
    case right
    case rightMirrored
    case up
    case upMirrored
}
