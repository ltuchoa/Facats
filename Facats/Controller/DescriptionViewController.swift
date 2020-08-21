//
//  DescriptionViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 17/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class DescriptionViewController: UIViewController, TTGTextTagCollectionViewDelegate {

    var breedId = String()
    var breedElement: [BreedElement] = []
    var catImage = UIImageView()
    var temperament = String()
    var temperamentArray: [String] = []
    var config = TTGTextTagConfig()
    let collectionView = TTGTextTagCollectionView()
    let tableView = UITableView()
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTagConfig()

        manager.fetchBreedId(id: breedId) {
            (breedElement) in
            DispatchQueue.main.sync {
                self.breedElement = breedElement
                self.title = self.breedElement[0].breeds[0].name
                self.catImage.load(url: URL(string: self.breedElement[0].url)!)
                self.temperament = self.breedElement[0].breeds[0].temperament
                self.temperamentArray = self.temperament.components(separatedBy: ", ")
                self.collectionView.addTags(self.temperamentArray, with: self.config)
                self.view.reloadInputViews()
                self.tableView.reloadData()
            }
        }

        view.backgroundColor = .white
        setupNavBar()
        setupCatImage()
        setupTags()
        setupTableView()
    }
    
    func setupNavBar(){
        self.navigationController?.navigationBar.tintColor = .actionColor
        
        let defaults = UserDefaults.standard
        var myarray = defaults.stringArray(forKey: "Favorites") ?? [String]()
        var barButton = UIBarButtonItem()
        
        var isFavorite = false
        if !myarray.isEmpty {
            for index in 0..<myarray.count {
                if breedId == myarray[index] {
                    isFavorite = true
                }
            }
        }
        
        if isFavorite {
            barButton = changeFavoriteImg(favorite: isFavorite)
        } else {
            barButton = changeFavoriteImg(favorite: isFavorite)
        }
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func favoriteCat() {
        
        // LOAD FAVORITES
        let defaults = UserDefaults.standard
        var myarray = defaults.stringArray(forKey: "Favorites") ?? [String]()
        
        // ADD FAVORITE OR REMOVE FAVORITE
        var isFavorite = false
        var position: Int?
        var barButton = UIBarButtonItem()
        
        if !myarray.isEmpty {
            for index in 0..<myarray.count {
                print(index)
                print(myarray)
                if breedId == myarray[index] {
                    isFavorite = true
                    position = index
                    
                }
            }
        }
        
        if isFavorite {
            if position != nil {
                myarray.remove(at: position!)
            }
            barButton = changeFavoriteImg(favorite: !isFavorite)
        } else {
            myarray.append(breedId)
            barButton = changeFavoriteImg(favorite: !isFavorite)
        }
        
        defaults.set(myarray, forKey: "Favorites")
        self.navigationItem.rightBarButtonItem = barButton
        print(myarray)
    }
    
    func changeFavoriteImg(favorite: Bool) -> UIBarButtonItem {
        var barButton = UIBarButtonItem()
        if favorite {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            button.setImage(UIImage(named: "star"), for: .normal)
            button.addTarget(self, action: #selector(favoriteCat), for: .touchUpInside)
            
            barButton = UIBarButtonItem(customView: button)
            barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                barButton.customView!.widthAnchor.constraint(equalToConstant: 30),
                barButton.customView!.heightAnchor.constraint(equalToConstant: 30)
            ])

        } else {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            button.setImage(UIImage(named: "star1"), for: .normal)
            button.addTarget(self, action: #selector(favoriteCat), for: .touchUpInside)
            
            barButton = UIBarButtonItem(customView: button)
            barButton.customView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                barButton.customView!.widthAnchor.constraint(equalToConstant: 30),
                barButton.customView!.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        return barButton
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
    
    func createTagConfig() {
        config.backgroundColor = .actionColor
        config.textColor = .white
        config.borderColor = .none
        config.cornerRadius = 8
    }
    
    func setupTags() {
        collectionView.alignment = .center
        collectionView.delegate = self
        collectionView.enableTagSelection = false
        
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 16, y: 312, width: Int(view.frame.size.width), height: 25)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: catImage.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if !breedElement.isEmpty {
            switch indexPath.row {
            case 0:
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                cell.textLabel?.text = "Description"
            case 1:
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = breedElement[0].breeds[0].breedDescription
            case 2:
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                cell.textLabel?.text = "Origin"
            case 3:
                cell.textLabel?.text = breedElement[0].breeds[0].origin
            case 4:
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                cell.textLabel?.text = "Life Span"
            case 5:
                cell.textLabel?.text = breedElement[0].breeds[0].lifeSpan
            default:
                cell.textLabel?.text = "pensando"
            }
            
        }
        
        return cell
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
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
