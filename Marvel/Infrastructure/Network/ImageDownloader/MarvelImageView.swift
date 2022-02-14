//
//  MarvelImageView.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation
import UIKit


class MarvelImageView: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    // Method to load image from url
    func loadRemoteImageFrom(urlString: String) {
      image = nil
      activityView.center = self.center
      self.addSubview(activityView)
      activityView.startAnimating()
      activityView.color = .darkGray
      if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
          self.image = imageFromCache
          activityView.stopAnimating()
          activityView.removeFromSuperview()
          return
      }
        
      guard let url = URL(string: urlString) else {
          print("image urlString is empty")
          return
      }
        
      URLSession.shared.dataTask(with: url) {
          data, response, error in
          DispatchQueue.main.async {
              self.activityView.stopAnimating()
              self.activityView.removeFromSuperview()
          }
            if let response = data {
                DispatchQueue.main.async {
                  if let imageToCache = UIImage(data: response) {
                      self.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                      self.image = imageToCache
                  }else{
                      self.loadRemoteImageFrom(urlString: "noImage")
                  }
                }
            }
       }.resume()
    }
}
