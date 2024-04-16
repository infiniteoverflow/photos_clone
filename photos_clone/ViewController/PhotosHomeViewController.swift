//
//  ViewController.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import UIKit

class PhotosHomeViewController: UIViewController {
    //MARK: View variables
    private lazy var image = UIImageView()
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewController()
        setupImage()
        
        PhotosViewModel().getPhoto(for: PhotosConstants.Categories.nature) { [weak self] data in
            guard let self else {
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image.image = image
                }
            }
        }
    }
    
    //MARK: View setup methods
    private func setupViewController() {
        title = "Photos"
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
        ]
    }
    
    private func setupImage() {
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        
        view.addConstraints([
            NSLayoutConstraint(item: image, 
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: image, 
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view.safeAreaLayoutGuide,
                               attribute: .top,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: image, 
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: image, 
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 0)
        ])
    }
}

