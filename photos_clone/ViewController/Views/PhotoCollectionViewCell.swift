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
        PhotosViewModel.shared.getPhoto(for: keyword)
    }
    
    func setImage(data: Data) {
        if let image = UIImage(data: data) {
            UIView.transition(with: self.image, duration: 2, options: .curveEaseInOut) {
                self.image.image = image
            }
        }
    }
    
    func setup(with keyword: String) {
        self.keyword = keyword
        setupImage()
        
        // Fetch the image from network
        fetchImage()
    }
}
