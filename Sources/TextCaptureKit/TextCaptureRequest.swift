import Foundation

/// Configuration for one still-image text-recognition operation.
public struct TextCaptureRequest: Sendable, Hashable {
    /// Whether Vision may infer languages not listed explicitly.
    public var automaticallyDetectsLanguage: Bool

    /// Words that may bias recognition when language correction is enabled.
    public var customWords: [String]

    /// Languages ordered from highest to lowest priority.
    public var recognitionLanguages: [String]

    /// The recognition speed and accuracy policy.
    public var recognitionLevel: TextCaptureRecognitionLevel

    /// Whether Vision applies language-aware correction.
    public var usesLanguageCorrection: Bool

    /// Creates text-recognition configuration.
    ///
    /// - Parameters:
    ///   - recognitionLevel: The recognition speed and accuracy policy.
    ///   - recognitionLanguages: Languages ordered from highest to lowest priority.
    ///   - automaticallyDetectsLanguage: Whether Vision may infer other languages.
    ///   - usesLanguageCorrection: Whether Vision applies language-aware correction.
    ///   - customWords: Words that may bias recognition.
    public init(
        recognitionLevel: TextCaptureRecognitionLevel = .accurate,
        recognitionLanguages: [String] = [],
        automaticallyDetectsLanguage: Bool = false,
        usesLanguageCorrection: Bool = true,
        customWords: [String] = []
    ) {
        self.automaticallyDetectsLanguage = automaticallyDetectsLanguage
        self.customWords = customWords
        self.recognitionLanguages = recognitionLanguages
        self.recognitionLevel = recognitionLevel
        self.usesLanguageCorrection = usesLanguageCorrection
    }
}

/// The recognition speed and accuracy policy.
public enum TextCaptureRecognitionLevel: Sendable, Hashable {
    case accurate
    case fast
}
