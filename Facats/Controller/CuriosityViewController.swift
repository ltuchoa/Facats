//
//  CuriosityViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 12/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class CuriosityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupBackground()
    }
    

    func setupBackground() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
    }

}
