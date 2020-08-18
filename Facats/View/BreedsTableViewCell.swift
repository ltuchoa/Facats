//
//  BreedsTableViewCell.swift
//  Facats
//
//  Created by Larissa Uchoa on 17/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class BreedsTableViewCell: UITableViewCell {

    var catImage = UIImageView()
    var catName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(catImage)
        addSubview(catName)
        
        configureCatImage()
        configureCatName()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(breed: Breed) {
        catImage.image = UIImage(named: "abys")
        catName.text = breed.name
    }
    
    func configureCatImage() {
        catImage.layer.cornerRadius = 20
        catImage.clipsToBounds = true
    }
    
    func configureCatName() {
        catName.numberOfLines = 0
        catName.adjustsFontSizeToFitWidth = true
        
        catName.font = UIFont(name: "SF Pro Display", size: 17)
        catName.font = catName.font.withSize(17)
    }
    
    func setConstraints() {
        catImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            catImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            catImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            catImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            catImage.trailingAnchor.constraint(equalTo: catName.leadingAnchor, constant: -16)
        ])
            
        catName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            catName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            catName.leadingAnchor.constraint(equalTo: catImage.leadingAnchor, constant: 56),
            catName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            catName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
