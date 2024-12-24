import Foundation
import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    private static let imageCache = NSCache<NSURL, UIImage>()
    
    /// Loads an image from the specified URL string.
    /// - Parameter urlString: The URL string of the image to load.
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }
        
        // Check if image is already cached
        if let cachedImage = ImageLoader.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        // Fetch image data
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self, let downloadedImage = downloadedImage else { return }
                ImageLoader.imageCache.setObject(downloadedImage, forKey: url as NSURL)
                self.image = downloadedImage
            }
    }
    
    /// Cancels the image loading task.
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancel()
    }
}
