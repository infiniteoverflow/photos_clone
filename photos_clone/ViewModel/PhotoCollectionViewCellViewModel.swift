//
//  PhotoCollectionViewCellViewModel.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import Foundation

class PhotoCollectionViewCellViewModel {
    private var dispatchGroup: DispatchGroup
    
    init(dispatchGroup: DispatchGroup) {
        self.dispatchGroup = dispatchGroup
    }
    
    func getPhoto(for category: String,
                  uuid: String,
                  onImageDataFetched: ((String, Data) -> Void)?) {
        let urlString = "https://api.api-ninjas.com/v1/randomimage?category=\(category)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(PhotosConstants.apiKey, forHTTPHeaderField: "X-Api-Key")
        urlRequest.addValue("image/jpg", forHTTPHeaderField: "Accept")
        dispatchGroup.enter()
        
        let dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self else {
                return
            }
            if let error {
                print("Error : \(error.localizedDescription)")
                dispatchGroup.leave()
            } else {
                guard let data else {
                    return
                }
                onImageDataFetched?(uuid, data)
                dispatchGroup.leave()
            }
        }
        
        dataTask.resume()
    }
}
