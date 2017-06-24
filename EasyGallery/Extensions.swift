//
//  Extensions.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/6/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import Foundation
import UIKit

//Image Cache
public var imageCache = NSCache<NSString, UIImage>()

// Download Image Async, extension UIImageView
extension UIImageView {
    func downloadImageAsync(contentsOf url: String, withCompletion completion: @escaping (UIImage) -> Void) -> URLSessionDataTask? {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    
                    //Decompresses the image on this thread to increase performance on the main thread
                    UIGraphicsBeginImageContextWithOptions(image.size, true, 1)
                    image.draw(at: CGPoint.zero)
                    
                    if let decImage = UIGraphicsGetImageFromCurrentImageContext() {
                        UIGraphicsEndImageContext()
                        DispatchQueue.main.async {
                            completion(decImage)
                        }
                    }
                    UIGraphicsEndImageContext()
                }
            }
            task.resume()
            return task
        } else { return nil }
    }
    
    func downloadImageAsync(contentsOf url: String?, saveToCache imageCache: NSCache<NSString, UIImage>) -> URLSessionDataTask? {
        if let url = url {
            let encodedUrl = url.urlEncode()
            if let cachedImage = imageCache.object(forKey: encodedUrl as NSString) {
                self.image = cachedImage
            } else {
                return downloadImageAsync(contentsOf: encodedUrl) { image in
                    self.image = image
                    imageCache.setObject(image, forKey: encodedUrl as NSString, cost: 1)
                }
            }
        }
        return nil
    }
}

//String extension
extension String {
    
    func urlEncode() -> String {
        if self.contains("%") {
            return self
        }
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
