//
//  BitmapPainter.swift
//  Painter
//
//  Created by Женя on 20.12.2021.
//

import UIKit

protocol BitmapPainterProtocol: AnyObject {

    func createImage(_ data: BitmapPaintable) -> UIImage?
    
    func createImages(_ data: [BitmapPaintable]) -> [UIImage?]
    
    func stacksImage(_ data: [BitmapPaintable]) -> UIImage?
    
    func stacksImage(_ data: [BitmapPaintable], onComplete: @escaping (UIImage?) -> Void)
}

class BitmapPainter: BitmapPainterProtocol {

    private let merger: BitmapPainterImagesMergable = BitmapPainterImagesMerger()
    
    private let creator: BitmapPainterImagesCreator
    
    private let drawer: BitmapPainterImageCreatable
    
    init() {
        drawer = BitmapPainterImageCreator()
        creator = BitmapPainterImagesCreator(drawer: drawer)
    }
    
    func createImage(_ bitmap: BitmapPaintable) -> UIImage? {
        return UIImage(ciImage: drawer.draw(bitmap))
    }
    
    func createImages(_ bitmaps: [BitmapPaintable]) -> [UIImage?] {
        return creator.create(bitmaps).map({ UIImage(ciImage: $0) })
    }
    
    func stacksImage(_ bitmaps: [BitmapPaintable]) -> UIImage? {
        return merger.merge(creator.create(bitmaps))
    }
    
    func stacksImage(_ bitmaps: [BitmapPaintable], onComplete: @escaping (UIImage?) -> Void) {
        let drawQueue = DispatchQueue(label: "123", qos: .userInitiated)
        drawQueue.async { [merger, creator] in
            DispatchQueue.main.async {
                onComplete(merger.merge(creator.create(bitmaps)))
            }
        }
    }
}
