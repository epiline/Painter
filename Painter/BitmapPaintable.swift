//
//  Paintable.swift
//  Painter
//
//  Created by Женя on 19.12.2021.
//
struct PainterBitmapSize: Hashable {
    
    let width: Int
    
    let height: Int
}

struct MockRGBA: BitmapPaintableColor {
    
    var r: UInt8
    
    var g: UInt8
    
    var b: UInt8
    
    var a: UInt8
}

protocol BitmapPaintableColor {
    
    var r: UInt8 { get }
    
    var g: UInt8 { get }
    
    var b: UInt8 { get }
    
    var a: UInt8 { get }
}

//typealias BitmapPaintableColor = BitmapPaintableColorZZZ & Hashable

protocol BitmapPaintable {
    
    var bitmapSize: PainterBitmapSize { get }
    
    var bitmapPixels: [BitmapPaintableColor] { get }
    
    var bitmapHash: Int { get }
}
