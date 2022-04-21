//
//  BitmapPainterImagesMerger.swift
//  Painter
//
//  Created by Женя on 20.12.2021.
//

import UIKit

protocol BitmapPainterImagesMergable: AnyObject {
    
    func merge(_ images: [CIImage]) -> UIImage?
}

class BitmapPainterImagesMerger: BitmapPainterImagesMergable {
    
    func merge(_ images: [CIImage]) -> UIImage? {
        let mergedImage = images.reduce(CIImage()) { partialResult, img in
            return img.composited(over: partialResult)
        }
        
        return UIImage(ciImage: mergedImage)
    }
}
