//
//  ViewController.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import UIKit

class PhotosHomeViewController: UIViewController {
    
    //MARK: Views
    private lazy var photosCollectionView = UICollectionView()
    
    //MARK: Variables
    private let initialRowSize: CGFloat = 4
    private let minimumInterItemSpacing: CGFloat = 2
    private var currentPhotoType = PhotosConstants.Categories.nature
    private var cells = 0
    private var collectionViewCells: [Int: PhotoCollectionViewCell] = [:]
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewController()
        setupNavigationBar()
        setupCollectionView()
    }
    
    //MARK: View setup methods
    private func setupViewController() {
        title = "Photos"
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
        ]
    }
    
    private func setupNavigationBar() {
        let menuHandler: UIActionHandler = { [weak self] action in
            guard let self else {
                return
            }
            currentPhotoType = action.title.lowercased()
            cells = 0
            photosCollectionView.reloadData()
        }
        
        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Nature", comment: ""), image: UIImage(systemName: "tree"), handler: menuHandler),
            UIAction(title: NSLocalizedString("City", comment: ""), image: UIImage(systemName: "building.2"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Technology", comment: ""), image: UIImage(systemName: "iphone"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Food", comment: ""), image: UIImage(systemName: "takeoutbag.and.cup.and.straw"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Still_Life", comment: ""), image: UIImage(systemName: "staroflife.shield"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Abstract", comment: ""), image: UIImage(systemName: "gear"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Wildlife", comment: ""), image: UIImage(systemName: "teddybear"), handler: menuHandler)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", image: nil, primaryAction: nil, menu: barButtonMenu)
    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = (self.view.frame.width/initialRowSize - minimumInterItemSpacing)
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = minimumInterItemSpacing
        layout.minimumLineSpacing = minimumInterItemSpacing
        
        photosCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        photosCollectionView
            .add(to: view)
            .enableAutoLayout()
            .pinAllSides(to: view,
                         includeSafeArea: true)
    }
    
    //MARK: Other methods
    private func onImagesDownloaded() {
        DispatchClass.shared.dispatchGroup.notify(queue: .global()) { [weak self] in
            guard let self else {
                return
            }
            
            var counter = 1
            PhotosViewModel.shared.imageData.forEach { [weak self] data in
                guard let self else {
                    return
                }
                let cell = collectionViewCells[counter]
                
                Thread.sleep(forTimeInterval: 0.1)
                DispatchQueue.main.async {
                    cell?.setImage(data: data)
                }
                counter+=1
            }
        }
    }
}

extension PhotosHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cells+=1
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        photoCell.setup(with: currentPhotoType)
        collectionViewCells[cells] = photoCell
        
        if cells == 20 {
            onImagesDownloaded()
        }
        return photoCell
    }
}
