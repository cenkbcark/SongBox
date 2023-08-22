//
//  ImageManager.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

final class ImageDownloader {
    static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            // Return cached image if available
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let downloadedImage = UIImage(data: data) {
                ImageCache.shared.setImage(downloadedImage, forKey: urlString)
                completion(downloadedImage)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
