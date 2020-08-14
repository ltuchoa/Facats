//
//  CuriosityViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 12/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class CuriosityViewController: UIViewController {

    var background = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupBackground()
    }
    

    func setupBackground() {
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        background = UIImageView(image: UIImage(named: "background"))
        
        self.view.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

}
