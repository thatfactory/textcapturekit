import CoreGraphics
import Foundation
import ImageIO
import Testing
import UniformTypeIdentifiers

@testable import TextCaptureKit

struct TextCaptureImageTests {
    @Test func automaticOrientationReadsEncodedMetadata() throws {
        // Given
        let data = try encodedImage(orientation: .right)
        let image = TextCaptureImage(data: data)

        // When
        let orientation = image.orientation.imagePropertyOrientation(for: image.data)

        // Then
        #expect(orientation == .right)
    }

    @Test func explicitOrientationOverridesEncodedMetadata() throws {
        // Given
        let data = try encodedImage(orientation: .right)
        let image = TextCaptureImage(data: data, orientation: .left)

        // When
        let orientation = image.orientation.imagePropertyOrientation(for: image.data)

        // Then
        #expect(orientation == .left)
    }

    // MARK: - Private

    private func encodedImage(orientation: CGImagePropertyOrientation) throws -> Data {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = try #require(
            CGContext(
                data: nil,
                width: 1,
                height: 1,
                bitsPerComponent: 8,
                bytesPerRow: 4,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
        )
        let image = try #require(context.makeImage())
        let data = NSMutableData()
        let destination = try #require(
            CGImageDestinationCreateWithData(
                data,
                UTType.jpeg.identifier as CFString,
                1,
                nil
            )
        )
        CGImageDestinationAddImage(
            destination,
            image,
            [kCGImagePropertyOrientation: orientation.rawValue] as CFDictionary
        )
        try #require(CGImageDestinationFinalize(destination))
        return data as Data
    }
}
