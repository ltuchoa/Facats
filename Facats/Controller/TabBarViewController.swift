//
//  TabBarViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 12/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let size = CGSize(width: 30, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curiosity = UINavigationController(rootViewController: CuriosityViewController())
        
        curiosity.tabBarItem = UITabBarItem(title: "Curiosity", image: UIImage(named: "curiosity"), tag: 0)
        
        let breeds = UINavigationController(rootViewController: BreedsViewController())
        breeds.tabBarItem = UITabBarItem(title: "Breeds", image: UIImage(named: "breeds"), tag: 1)
        
        let tabBarList = [curiosity, breeds]
        viewControllers = tabBarList
        
        setupStyle()
    }
    
    func setupStyle() {
        // general style
        tabBar.tintColor = .actionColor
        tabBar.unselectedItemTintColor = .unselectedColor
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white

        //shadow setup
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowRadius = 6
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowOpacity = 0.05
        
    }
}

