import Testing

@testable import TextCaptureKit

struct TextCaptureResultTests {
    @Test func emptyObservationsProduceEmptyText() {
        let result = TextCaptureResult(observations: [])

        #expect(result.text.isEmpty)
    }

    @Test func observationsAreProjectedInReadingOrder() {
        // Given
        let lower = observation(text: "unten", x: 0.1, y: 0.2)
        let upperTrailing = observation(text: "Welt", x: 0.6, y: 0.8)
        let upperLeading = observation(text: "Hallo", x: 0.1, y: 0.8)

        // When
        let result = TextCaptureResult(observations: [lower, upperTrailing, upperLeading])

        // Then
        #expect(result.text == "Hallo\nWelt\nunten")
        #expect(result.observations.map { $0.candidates.first?.text } == ["Hallo", "Welt", "unten"])
    }

    @Test func alternateCandidatesRemainOrdered() throws {
        // Given
        let observation = TextCaptureObservation(
            candidates: [
                TextCaptureCandidate(text: "Haus", confidence: 0.9),
                TextCaptureCandidate(text: "Maus", confidence: 0.5),
            ],
            boundingBox: TextCaptureBoundingBox(x: 0, y: 0, width: 1, height: 1)
        )

        // When
        let result = TextCaptureResult(observations: [observation])

        // Then
        let candidates = try #require(result.observations.first?.candidates)
        #expect(candidates.map(\.text) == ["Haus", "Maus"])
        #expect(candidates.map(\.confidence) == [0.9, 0.5])
    }

    // MARK: - Private

    private func observation(text: String, x: Double, y: Double) -> TextCaptureObservation {
        TextCaptureObservation(
            candidates: [TextCaptureCandidate(text: text, confidence: 1)],
            boundingBox: TextCaptureBoundingBox(x: x, y: y, width: 0.2, height: 0.1)
        )
    }
}
