import AppLogger
import Testing

@testable import TextCaptureKit

struct TextCaptureLogTests {
    @Test func eventsUseCanonicalEmojiAndStableMetadata() {
        #expect(TextCaptureLogging.Event.recognitionCancelled.message == "👁️ recognize | result=cancelled")
        #expect(
            TextCaptureLogging.Event.recognitionFailed.message
                == "👁️ recognize | result=failure, reason=vision"
        )
        #expect(
            TextCaptureLogging.Event.recognitionSucceeded(hasObservations: true, level: .accurate).message
                == "👁️ recognize | result=success, observations=present, level=accurate"
        )
        #expect(
            TextCaptureLogging.Event.recognitionSucceeded(hasObservations: false, level: .fast).message
                == "👁️ recognize | result=success, observations=none, level=fast"
        )
    }

    @Test func loggingIdentityIsStable() {
        #expect(TextCaptureLogging.category == "recognition")
        #expect(TextCaptureLogging.emoji == "👁️")
        #expect(TextCaptureLogging.subsystem == "com.thatfactory.textcapturekit")
    }

    @Test func eventsUsePurposefulLevels() {
        if case .debug = TextCaptureLogging.Event.recognitionCancelled.level {
        } else {
            Issue.record("Cancellation should be a debug event.")
        }
        if case .error = TextCaptureLogging.Event.recognitionFailed.level {
        } else {
            Issue.record("Failure should be an error event.")
        }
        if case .debug = TextCaptureLogging.Event.recognitionSucceeded(hasObservations: true, level: .accurate).level {
        } else {
            Issue.record("Success should be a debug event.")
        }

        #expect(TextCaptureLogging.Event.recognitionCancelled.isPrivate == false)
        #expect(TextCaptureLogging.Event.recognitionFailed.isPrivate == false)
    }
}
