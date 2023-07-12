//
//  ImageCache.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 12.07.23.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache()

    private var cache: NSCache<NSString, UIImage>

    private init() {
        cache = NSCache<NSString, UIImage>()
    }

    private func setImage(_ image: UIImage, forURL url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }

    private func image(forURL url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func loadImage(fromURL url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.image(forURL: url) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    ImageCache.shared.setImage(image, forURL: url)
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }

}
