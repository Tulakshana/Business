//
//  ImageView.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-03.
//

import UIKit

class ImageView: UIImageView {
    static let placeholder = UIImage.init(named: "image_placeholder")
    
    var task: URLSessionDataTask?
    
    func loadImage(url: URL) {
        image = ImageView.placeholder
        
        var request = URLRequest(url: url, timeoutInterval: API.timeOutInterval)
        request.httpMethod = API.Method.GET.rawValue
        
        cancelLoad()
        task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
          if let data = data {
            DispatchQueue.main.async {
                self?.image = UIImage.init(data: data)
            }
          }
        }
        task?.resume()
    }
    
    func cancelLoad() {
        task?.cancel()
        task = nil
    }
}
