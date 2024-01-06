import SwiftUI
import Combine
import Photos

final class ImageManager {
    
    // MARK: - Singleton
    static let shared = ImageManager()
    
    
    // MARK: - Value
    // MARK: Private
    private lazy var imageCache = NSCache<NSString, UIImage>()
    private var loadTasks = [PHAsset: PHImageRequestID]()
    
    private let queue = DispatchQueue(label: "ImageDataManagerQueue")
    
    private lazy var imageManager: PHCachingImageManager = {
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        return imageManager
    }()

    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 60
        configuration.timeoutIntervalForRequest     = 60
        configuration.timeoutIntervalForResource    = 60
        return URLSession(configuration: configuration)
    }()
    
    private var dataController = DataController.shared
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Function
    // MARK: Public
    func download(url: URL?) async throws -> Image {
        guard let url = url else { throw URLError(.badURL) }
        
        let images = dataController.getImages()
        if let cachedImage = images.first(where: { $0.imagePath == url.absoluteString })?.image {
            return Image(uiImage: UIImage(data: cachedImage)!)
        }
    
        let data = (try await downloadSession.data(from: url)).0
        
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
        queue.async {
            self.dataController.saveImage(image: data, imageUrl: url.absoluteString)
        }
    
        return Image(uiImage: image)
    }
}
