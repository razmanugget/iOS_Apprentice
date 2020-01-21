//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Rami on 1/21/20.
//  Copyright © 2020 Lyfebug. All rights reserved.
//

import UIKit

extension UIImageView {
   func loadImage(url: URL) -> URLSessionDownloadTask {
      let session = URLSession.shared
      // save the downloaded file to a temp location
      let downloadTask = session.downloadTask(
         with: url, completionHandler: { [weak self] url, response, error in
            if error == nil,
               let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
               DispatchQueue.main.async {
                  if let weakSelf = self {
                     weakSelf.image = image
                  }
               }
            }
      })
      // start with resume gives opportunity to call cancel
      downloadTask.resume()
      return downloadTask
   }
}
