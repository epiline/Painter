//
//  MocksForTests.swift
//  PainterTests
//
//  Created by Женя on 20.12.2021.
//

import Foundation
import UIKit

class RandomColorGetter {
    
    static let m1 = MockRGBA(r: 255, g: 0, b: 0, a: 255)
    
    static let m2 = MockRGBA(r: 0, g: 255, b: 0, a: 255)
    
    static func get() -> BitmapPaintableColor {
        return Bool.random() ? m1 : m2
    }
}

struct RandomColorsBitmap: BitmapPaintable {

    var bitmapSize: PainterBitmapSize
    
    var bitmapPixels: [BitmapPaintableColor]
    
    var bitmapHash: Int
    
    init(size: PainterBitmapSize) {
        self.bitmapSize = size
        
        self.bitmapPixels = (0..<size.width * size.height).map({ _ in
            return RandomColorGetter.get()
        })
        
        var hasher = Hasher()
//        hasher.combine(bitmapPixels)
        hasher.combine(bitmapSize)
        bitmapHash = hasher.finalize()
    }
}

struct MockBitmap: BitmapPaintable {
    
    var bitmapSize: PainterBitmapSize
    
    var bitmapPixels: [BitmapPaintableColor]
    
    var bitmapHash: Int {
        return 0
    }
    
    init(colors: [BitmapPaintableColor]) {
        bitmapPixels = colors
        bitmapSize = .init(width: colors.count, height: 1)
    }
}

class Datasource {
    
    static let instace = Datasource()
    
    let layers = Array(repeating: RandomColorsBitmap(size: .init(width: 1024, height: 1024)),
                       count: 1000)
//    
//    var randomLayers: [RandomColorsBitmap] = []
//    
//    init() {
//        for i in 0..<1000 {
//            print(i, "999")
//            randomLayers.append(RandomColorsBitmap(size: .init(width: 1024, height: 1024)))
//        }
//    }
    
//    let colorsTest = Array(repeating: MockBlueBitmap(size: .init(width: 4, height: 4)),
    //                           count: 3)
}

struct ColorExtractor {
    
    typealias ExtractedImage = (r: UInt8, g: UInt8, b: UInt8, a: UInt8)
    
    private let image: CGImage
 
    init(_ image: CGImage) {
        self.image = image
    }
    
    func extract(position: CGPoint) -> ExtractedImage {
        let pixelData = image.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(image.width) * Int(position.y)) + Int(position.x)) * 4
        
        let r = UInt8(data[pixelInfo])
        let g = UInt8(data[pixelInfo+1])
        let b = UInt8(data[pixelInfo+2])
        let a = UInt8(data[pixelInfo+3])
        
        return (r, g, b, a)
    }
}
