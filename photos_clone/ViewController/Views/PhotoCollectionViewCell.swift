//
//  PhotoCollectionViewCell.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    //MARK: View variables
    private lazy var image = UIImageView()
    
    //MARK: Other variables
    static let identifier = String(describing: PhotoCollectionViewCell.self)
    private var keyword = ""
    private var uuid: String = ""

    private var onImageDataFetched: ((String, Data) -> Void)?
    private var photoCollectionViewCellViewModel: PhotoCollectionViewCellViewModel?
    
    //MARK: View setup methods
    private func setupImage() {
        image.image = nil
        image.backgroundColor = AppColors.lightGrayBackgroundColor
        
        image.add(to: contentView)
            .enableAutoLayout()
            .pinAllSides(to: contentView,
                         includeSafeArea: true)
    }
    
    //MARK: Other methods
    private func fetchImage() {
        photoCollectionViewCellViewModel?.getPhoto(for: keyword,
                                                   uuid: uuid,
                                                   onImageDataFetched: onImageDataFetched)
    }
    
    func setImage(data: Data) {
        if let image = UIImage(data: data) {
            self.image.image = image
        }
    }
    
    func setup(with keyword: String, 
               uuid: String,
               photoCollectionViewCellViewModel: PhotoCollectionViewCellViewModel?,
               onImageDataFetched: ((String, Data) -> Void)?) {
        self.keyword = keyword
        self.uuid = uuid
        self.photoCollectionViewCellViewModel = photoCollectionViewCellViewModel
        self.onImageDataFetched = onImageDataFetched
        
        // Setup the imageview with a placeholder
        setupImage()
        // Fetch the image from network
        fetchImage()
    }
}
