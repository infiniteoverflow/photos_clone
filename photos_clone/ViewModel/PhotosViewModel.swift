//
//  PhotosViewModel.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import Foundation

class PhotosViewModel: NSObject, URLSessionDelegate {
    
    private override init() {
        super.init()
    }
    
    static let shared = PhotosViewModel()
    
    var imageData: [Data] = []

    func getPhoto(for category: String) {
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
        DispatchClass.shared.dispatchGroup.enter()
        
        let dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self else {
                return
            }
            if let error {
                print("Error : \(error.localizedDescription)")
                DispatchClass.shared.dispatchGroup.leave()
            } else {
                guard let data else {
                    return
                }
                imageData.append(data)
                DispatchClass.shared.dispatchGroup.leave()
            }
        }
        
        dataTask.resume()
    }
}
