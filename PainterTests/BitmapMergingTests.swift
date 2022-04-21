//
//  BitmapMergingTests.swift
//  PainterTests
//
//  Created by Женя on 20.12.2021.
//

import Foundation

import XCTest
@testable import Painter
//
//class BitmapMergingTests: XCTestCase {
//    
//    let merger: BitmapPainterImagesMergable = BitmapPainterImagesMerger()
//    let creator = BitmapPainterImagesCreator(drawer: BitmapPainterDrawer())
//    
//    func testCommon() {
//        let images = creator.exp1_common(Datasource.instace.layers)
//        
//        self.measure {
//            let res = merger.exp1_common(images)
//            print(res!)
//        }
//    }
//    
//    func testCoreImage() {
//        let images = creator.exp1_common(Datasource.instace.layers)
//        
//        self.measure {
//            let res = merger.exp2_coreImage(images)
//            print(res!)
//        }
//    }
//    
//    func testCoreImageInput() {
//        let images = creator.exp1_common(Datasource.instace.layers).compactMap({ CIImage(image: $0) })
//        
//        self.measure {
//            let res = merger.exp3_coreImageInput(images)
//            print(res!)
//        }
//    }
//    
////    func testColor() {
////        let z = Datasource.instace.colorsTest
////        let res = merger.exp1_common(creator.exp1_common(z))
////
////        for i in 0..<4 {
////            print(z[0].bitmapPixels[i], res!.cgImage!.pixel(x: i, y: 0))
////        }
////    }
//}
