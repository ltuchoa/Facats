//
//  CuriosityCard.swift
//  Facats
//
//  Created by Larissa Uchoa on 14/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class CuriosityCard: UIView {
    
    var fact = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(fact)
        
        setupBackground()
        setupFact()
        setupFactConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(text: String) {
        fact.text = text
    }
    
    func setupBackground() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = .unselectedColor
    }
    
    func setupFact() {
        fact.numberOfLines = 0
        fact.adjustsFontSizeToFitWidth = true
        
        fact.textColor = .white
        fact.textAlignment = .center
        fact.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    func setupFactConstraint() {
        fact.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fact.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            fact.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fact.topAnchor.constraint(equalTo: self.topAnchor),
            fact.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
