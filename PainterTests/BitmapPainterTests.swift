//
//  BitmapPainterTests.swift
//  Painter
//
//  Created by Женя on 20.12.2021.
//

import XCTest
@testable import Painter
//
//class BitmapPainterTests: XCTestCase {
//    
//    let painter = BitmapPainter()
//    
//    let merger: BitmapPainterImagesMergable = BitmapPainterImagesMerger()
//    let creator = BitmapPainterImagesCreator(drawer: BitmapPainterDrawer())
//    
//    func testMainPainter() {
//        let bitmaps = Datasource.instace.layers
//        
//        self.measure {
//            let res = painter.stacksImage(bitmaps)
//            print(res!)
//        }
//    }
//    
//    func testExp1Painter() {
//        let bitmaps = Datasource.instace.layers
//        
//        self.measure {
//            let res = merger.exp1_common(creator.exp1_common(bitmaps))
//            print(res!)
//        }
//    }
//    
//    func testExp2Painter() {
//        let bitmaps = Datasource.instace.layers
//        
//        self.measure {
//            let res = merger.exp2_coreImage(creator.exp2_concurrentPerform(bitmaps))
//            print(res!)
//        }
//    }
//    
//    func testExp3Painter() {
//        let bitmaps = Datasource.instace.layers
//        
//        self.measure {
//            let res = merger.exp3_coreImageInput(creator.exp3_concurrentPerform_coreImage(bitmaps))
//            print(res!)
//        }
//    }
//    
//    func testExp4Painter() {
//        let bitmaps = Datasource.instace.layers
//        
//        self.measure {
//            let res = merger.exp3_coreImageInput(creator.exp4_concurrentPerform_coreImage_semaphore(bitmaps))
//            print(res!)
//        }
//    }
//}
