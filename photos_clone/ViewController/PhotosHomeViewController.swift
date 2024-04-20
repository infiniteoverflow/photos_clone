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
    
    private var photoCollectionViewCellViewModel: PhotoCollectionViewCellViewModel?
    private var photosHomeViewModel: PhotosHomeViewModel?
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewController()
        setupNavigationBar()
        setupCollectionView()
        
        photosHomeViewModel = PhotosHomeViewModel()
        guard let dispatchGroup = photosHomeViewModel?.dispatchGroup else {
            return
        }
        photoCollectionViewCellViewModel = PhotoCollectionViewCellViewModel(dispatchGroup: dispatchGroup)
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
            photosHomeViewModel?.collectionViewCells = [:]
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
}

extension PhotosHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let uuid = UUID().uuidString
        photosHomeViewModel?.onImagesDownloaded(photosHomeViewModel: photosHomeViewModel)
        photoCell.setup(with: currentPhotoType,
                        uuid: uuid,
                        photoCollectionViewCellViewModel: photoCollectionViewCellViewModel) { [weak self] uuid, data in
            guard let self else {
                return
            }
            let photoImageDataModel = PhotoImageDataModel(uuid: uuid, imageData: data)
            photosHomeViewModel?.photoImageDataModels.append(photoImageDataModel)
        }
        photosHomeViewModel?.collectionViewCells[uuid] = photoCell
        photosHomeViewModel?.orderedUUIDs.append(uuid)
        return photoCell
    }
}
