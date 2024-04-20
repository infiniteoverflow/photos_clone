//
//  PhotosHomeViewModel.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 20/04/24.
//

import Foundation

class PhotosHomeViewModel {
    var dispatchGroup = DispatchGroup()
    var collectionViewCells: [String: PhotoCollectionViewCell] = [:]
    var orderedUUIDs: [String] = []
    var photoImageDataModels: [PhotoImageDataModel] = []
    
    //MARK: Other methods
    func onImagesDownloaded(photosHomeViewModel: PhotosHomeViewModel?) {
        photosHomeViewModel?.dispatchGroup.notify(queue: .global()) { [weak self] in
            guard let self else {
                return
            }
            
            photosHomeViewModel?.orderedUUIDs.forEach { uuid in
                if let model = photosHomeViewModel?.photoImageDataModels.first(where: { model in
                    model.uuid == uuid
                }) {
                    let cell = photosHomeViewModel?.collectionViewCells[model.uuid]
                    
                    Thread.sleep(forTimeInterval: 0.1)
                    DispatchQueue.main.async {
                        cell?.setImage(data: model.imageData)
                    }
                }
            }
        }
    }
}
