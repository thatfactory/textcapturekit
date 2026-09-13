import AppLogger

/// Owns TextCaptureKit's unified-log identity and message rendering.
enum TextCaptureLogging {
    static let category = "recognition"
    static let emoji = "👁️"
    static let subsystem = "com.thatfactory.textcapturekit"

    enum Event: Equatable {
        case recognitionCancelled
        case recognitionFailed
        case recognitionSucceeded(hasObservations: Bool, level: TextCaptureRecognitionLevel)

        var level: AppLogLevel {
            switch self {
            case .recognitionCancelled, .recognitionSucceeded:
                .debug
            case .recognitionFailed:
                .error
            }
        }

        var message: String {
            switch self {
            case .recognitionCancelled:
                "\(emoji) recognize | result=cancelled"
            case .recognitionFailed:
                "\(emoji) recognize | result=failure, reason=vision"
            case .recognitionSucceeded(let hasObservations, let level):
                "\(emoji) recognize | result=success, observations=\(hasObservations ? "present" : "none"), level=\(level.logValue)"
            }
        }

        var isPrivate: Bool { false }
    }

    static func emit(_ event: Event) {
        AppLogger(subsystem: subsystem, category: category)
            .log(level: event.level, event.message, isPrivate: event.isPrivate)
    }
}

extension TextCaptureRecognitionLevel {
    fileprivate var logValue: String {
        switch self {
        case .accurate:
            "accurate"
        case .fast:
            "fast"
        }
    }
}
