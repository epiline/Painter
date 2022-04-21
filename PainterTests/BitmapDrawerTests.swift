//
//  BitmapDrawerTests.swift
//  PainterTests
//
//  Created by Женя on 26.12.2021.
//

import Foundation
import CoreGraphics

import XCTest
@testable import Painter

class BitmapDrawerTests: XCTestCase {
    
    private let drawer: BitmapPainterImageCreatable = BitmapPainterImageCreator()
    
    func test_speed_measure() {
        let bitmaps = Datasource.instace.layers
        
        self.measure {
            let res = bitmaps.map({ drawer.draw($0) })
            print(res.count)
        }
    }
    
    func test_color_identity() {
        let pixels: [BitmapPaintableColor] = [
            MockRGBA(r: 255, g: 0, b: 255, a: 255),
            MockRGBA(r: 255, g: 255, b: 0, a: 255),
            MockRGBA(r: 255, g: 0, b: 255, a: 255),
            MockRGBA(r: 0, g: 0, b: 0, a: 255),
            MockRGBA(r: 255, g: 255, b: 0, a: 255),
            MockRGBA(r: 1, g: 1, b: 1, a: 1),
            MockRGBA(r: 23, g: 0, b: 0, a: 255),
            MockRGBA(r: 55, g: 55, b: 55, a: 56),
            MockRGBA(r: 0, g: 0, b: 0, a: 255),
            MockRGBA(r: 123, g: 123, b: 123, a: 123),
            MockRGBA(r: 0, g: 0, b: 0, a: 0),
            MockRGBA(r: 92, g: 10, b: 10, a: 255),
            MockRGBA(r: 1, g: 2, b: 3, a: 4),
            MockRGBA(r: 44, g: 44, b: 44, a: 44),
        ]
        
        let layer = MockBitmap(colors: pixels)
        let image = drawer.draw(layer)

        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(image, from: image.extent)!
        let extractor = ColorExtractor(cgImage)
        
        for i in 0..<pixels.count {
            let extracted = extractor.extract(position: .init(x: i, y: 0))
            XCTAssertEqual(extracted.r, pixels[i].r)
            XCTAssertEqual(extracted.g, pixels[i].g)
            XCTAssertEqual(extracted.b, pixels[i].b)
            XCTAssertEqual(extracted.a, pixels[i].a)
            print("OK", i + 1, "/", pixels.count)
        }
    }
}
