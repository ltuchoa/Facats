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
    var curiosityCard = CuriosityCard(frame: CGRect(x: 15, y: 374, width: 383, height: 148))
    let apiUrl = "https://cat-fact.herokuapp.com/facts"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setupBackground()
        
        setupCuriosityCard()
        
        DispatchQueue.main.async {
            self.getData(from: self.apiUrl)
        }
    }
    

    func setupBackground() {
        
        background = UIImageView(image: UIImage(named: "background"))
        
        self.view.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }

    func setupCuriosityCard() {
        background.addSubview(curiosityCard)
        
        curiosityCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            curiosityCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            curiosityCard.heightAnchor.constraint(equalToConstant: 145),
            curiosityCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            curiosityCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func getData(from apiUrl: String) -> Void {
        let task = URLSession.shared.dataTask(with: URL(string: apiUrl)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went Wrong")
                return
            }
            
            var facts: Facts?
            
            do {
                facts = try JSONDecoder().decode(Facts.self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }

            let size = facts?.all.count
            let random = Int.random(in: 0...size!)

            self.curiosityCard.set(text: facts?.all[random].text ?? "ih")
            
        })
        task.resume()
    }
    
}
