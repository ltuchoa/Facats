//
//  DescriptionViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 17/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    var breedId = String()
    var breedElement: [BreedElement] = []
    var catImage = UIImageView()
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.fetchBreedId(id: breedId) {
            (breedElement) in
            DispatchQueue.main.sync {
                self.breedElement = breedElement
                self.title = self.breedElement[0].breeds[0].name
                self.catImage.load(url: URL(string: self.breedElement[0].url)!)
                self.view.reloadInputViews()
            }
        }
        
        view.backgroundColor = .white
        setupNavBar()
        setupCatImage()
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.tintColor = .actionColor
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(UIImage(named: "star1"), for: .normal)
        button.addTarget(self, action: #selector(favoriteCat), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barButton.customView!.widthAnchor.constraint(equalToConstant: 30),
            barButton.customView!.heightAnchor.constraint(equalToConstant: 30)
        ])
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func favoriteCat() {
        
    }
    
    func setupCatImage() {
        catImage.layer.cornerRadius = 20
        catImage.clipsToBounds = true
        
        catImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(catImage)
        
        NSLayoutConstraint.activate([
            catImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            catImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            catImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            catImage.heightAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
