//
//  ViewController.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 16/04/24.
//

import UIKit

class PhotosHomeViewController: UIViewController {
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewController()
    }
    
    //MARK: View setup methods
    private func setupViewController() {
        title = "Photos"
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
        ]
    }
}

