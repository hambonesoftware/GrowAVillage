import UIKit

protocol ImageCacheType: AnyObject {
    subscript(_ url: URL) -> UIImage? { get set }
}

final class ImageCache: ImageCacheType {
    static let shared = ImageCache()
    
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return cache.object(forKey: key as NSURL)
        }
        set {
            if let image = newValue {
                cache.setObject(image, forKey: key as NSURL)
            } else {
                cache.removeObject(forKey: key as NSURL)
            }
        }
    }
}
