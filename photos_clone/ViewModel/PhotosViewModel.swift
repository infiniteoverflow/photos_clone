//
//  PhotosViewModel.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import Foundation

class PhotosViewModel: NSObject, URLSessionDelegate {
    func getPhoto(for category: String, 
                  onImageFetched: @escaping (_ data: Data) -> Void) {
        let urlString = "https://api.api-ninjas.com/v1/randomimage?category=\(category)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                 delegate: self,
                                 delegateQueue: nil)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(PhotosConstants.apiKey, forHTTPHeaderField: "X-Api-Key")
        urlRequest.addValue("image/jpg", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("Error : \(error.localizedDescription)")
            } else {
                guard let data else {
                    return
                }
                onImageFetched(data)
            }
        }
        
        dataTask.resume()
    }
}
