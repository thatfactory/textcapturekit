import Testing
@testable import TextCaptureKit

@Test("The package namespace is available")
func packageNamespaceIsAvailable() {
    _ = TextCaptureKit.self
}
