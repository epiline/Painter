//
//  BitmapPainterImagesCreator.swift
//  Painter
//
//  Created by Женя on 20.12.2021.
//

import UIKit

protocol BitmapPainterImagesCreatable: AnyObject {
    
    func create(_ bitmaps: [BitmapPaintable]) -> [CIImage]
}

class BitmapPainterImagesCreator: BitmapPainterImagesCreatable {

    private let drawer: BitmapPainterImageCreatable
    
    init(drawer: BitmapPainterImageCreatable) {
        self.drawer = drawer
    }
    
    func create(_ bitmaps: [BitmapPaintable]) -> [CIImage] {
        let semaphore = DispatchSemaphore(value: 5)

        var images: [CIImage] = Array(repeating: CIImage(), count: bitmaps.count)
        
        let reversedBitmaps: [BitmapPaintable] = bitmaps.reversed()
        
        DispatchQueue.concurrentPerform(iterations: bitmaps.count) { [drawer] (index) in
            semaphore.wait()
            images[index] = drawer.draw(reversedBitmaps[index])
            semaphore.signal()
        }
        
        return images
    }
}
