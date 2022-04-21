//
//  BitmapPainterDrawer.swift
//  Painter
//
//  Created by Женя on 20.12.2021.
//

import UIKit

protocol BitmapPainterImageCreatable {
    
    func draw(_ bitmap: BitmapPaintable) -> CIImage
}

class BitmapPainterImageCreator: BitmapPainterImageCreatable {
    
    private let bitmapCache = Cache<Int, CIImage>()
    
    private let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    func draw(_ bitmap: BitmapPaintable) -> CIImage {
        let calculatedHash = bitmap.bitmapHash
        
        if let image = bitmapCache.object(forKey: calculatedHash) {
            return image
        }
        
        let size = bitmap.bitmapSize
        let bytesPerPixel = 4
        let bytesPerRow = size.width * bytesPerPixel
        
        let data = Data(bytes: bitmap.bitmapPixels, count: size.height * bytesPerRow)
        
        let drawedImage = CIImage(
            bitmapData: data,
            bytesPerRow: bytesPerRow,
            size: .init(width: size.width, height: size.height),
            format: .RGBA8,
            colorSpace: colorSpace
        )
        
        bitmapCache.setObject(drawedImage, forKey: calculatedHash)
        
        return drawedImage
    }
}


private class ObjectWrapper {
    
    let value: Any

    init(_ value: Any) {
        self.value = value
    }
}

private class KeyWrapper<KeyType: Hashable>: NSObject {
    
    let key: KeyType
    
    init(_ key: KeyType) {
        self.key = key
    }

    override var hash: Int {
        return key.hashValue
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? KeyWrapper<KeyType> else {
            return false
        }
        return key == other.key
    }
}

open class Cache<KeyType: Hashable, ObjectType> {

    private let cache: NSCache<KeyWrapper<KeyType>, ObjectWrapper> = NSCache()

    public init(lowMemoryAware: Bool = true) {
        guard lowMemoryAware else { return }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLowMemory),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func onLowMemory() {
        removeAllObjects()
    }

    open var name: String {
        get { return cache.name }
        set { cache.name = newValue }
    }

    weak open var delegate: NSCacheDelegate? {
        get { return cache.delegate }
        set { cache.delegate = newValue }
    }

    open func object(forKey key: KeyType) -> ObjectType? {
        return cache.object(forKey: KeyWrapper(key))?.value as? ObjectType
    }

    open func setObject(_ obj: ObjectType, forKey key: KeyType) { // 0 cost
        return cache.setObject(ObjectWrapper(obj), forKey: KeyWrapper(key))
    }

    open func setObject(_ obj: ObjectType, forKey key: KeyType, cost: Int) {
        return cache.setObject(ObjectWrapper(obj), forKey: KeyWrapper(key), cost: cost)
    }

    open func removeObject(forKey key: KeyType) {
        return cache.removeObject(forKey: KeyWrapper(key))
    }

    open func removeAllObjects() {
        return cache.removeAllObjects()
    }

    open var totalCostLimit: Int {
        get { return cache.totalCostLimit }
        set { cache.totalCostLimit = newValue }
    }

    open var countLimit: Int {
        get { return cache.countLimit }
        set { cache.countLimit = newValue }
    }

    open var evictsObjectsWithDiscardedContent: Bool {
        get { return cache.evictsObjectsWithDiscardedContent }
        set { cache.evictsObjectsWithDiscardedContent = newValue }
    }
}
