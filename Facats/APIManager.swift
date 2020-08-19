//
//  APIManager.swift
//  Facats
//
//  Created by Larissa Uchoa on 17/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import Foundation

class APIManager {
    
    let breedsUrl = URL(string: "https://api.thecatapi.com/v1/breeds")
    let session = URLSession.shared
    
    func fetchBreeds(completionHandler: @escaping ([Breed]) -> Void) {
        
        let task = session.dataTask(with: breedsUrl!) { (data, response, error) in
            
            if error != nil {
                print("Error: \(String(describing: error))")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            if let data = data,
                let breeds = try? JSONDecoder().decode([Breed].self, from: data) {
                completionHandler(breeds)
            }
        }
        task.resume()
    }
    
    func fetchBreedId(id: String,completionHandler: @escaping ([BreedElement]) -> Void) {
        let task = session.dataTask(with: URL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(id)")!) { (data, response, error) in
            
            if error != nil {
                print("Error: \(String(describing: error))")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(String(describing: response))")
              return
            }
            if let data = data,
                let breedElement = try? JSONDecoder().decode([BreedElement].self, from: data) {
                completionHandler(breedElement)
            }
        }
        task.resume()
    }
}
