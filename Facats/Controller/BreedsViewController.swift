//
//  BreedsViewController.swift
//  Facats
//
//  Created by Larissa Uchoa on 12/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController {

    var segmentedControl = UISegmentedControl()
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var breeds: [Breed] = []
    var filteredBreeds: [Breed] = []
    var section: Int?
    var breedsData: [Breed] = []
    
    let manager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Breeds"
        
        //tableView.keyboardDismissMode = .onDrag
        
        manager.fetchBreeds() {
            (breeds) in
            DispatchQueue.main.async {
                self.breeds = breeds
                if self.searchBar.selectedScopeButtonIndex == 0 {
                    self.breedsData = breeds
                }
                self.tableView.reloadData()
            }
        }
        
        setupSegmentedControl()
        setupSearchBar()
        setupTableView()
        loadSection()
    }
    
    func setupSegmentedControl() {
        let items = ["All", "Favorites"]
        segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentTintColor = .actionColor
        segmentedControl.backgroundColor = .segmentedColor
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedButtonTapped), for: .valueChanged)
    }
    
    @objc func segmentedButtonTapped (sender: UISegmentedControl) {
        if section == 0 {
            section = 1
            loadSection()
        } else {
            section = 0
            loadSection()
        }
    }
    
    func setupSearchBar() {
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(BreedsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 55
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}


extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            return filteredBreeds.count
        }
        return breedsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let breed: Breed
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BreedsTableViewCell
        if searchBar.text != "" {
            breed = filteredBreeds[indexPath.row]
        } else {
            breed = breedsData[indexPath.row]
        }
        cell.set(breed: breed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DescriptionViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(nextViewController, animated: true)
        if searchBar.searchTextField.text!.isEmpty {
            nextViewController.breedId = breedsData[indexPath.row].id
        } else {
            nextViewController.breedId = filteredBreeds[indexPath.row].id
        }
        
    }
    
}

extension BreedsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchBar(searchBar, selectedScopeButtonIndexDidChange: section!)
            filteredBreeds = breedsData
            tableView.reloadData()
        } else {
            self.searchBar(searchBar, selectedScopeButtonIndexDidChange: section!)
            filteredBreeds = breedsData.filter({ breed -> Bool in
                breed.name.lowercased().contains(searchText.lowercased())
            })
        }

        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            breedsData = breeds
        case 1:
            let defaults = UserDefaults.standard
            let myarray = defaults.stringArray(forKey: "Favorites") ?? [String]()
            breedsData = breeds.filter({ myarray.contains($0.id) })
        default:
            break
        }
        section = selectedScope
        tableView.reloadData()
    }

    func loadSection() {
        self.searchBar(searchBar, selectedScopeButtonIndexDidChange: section ?? 0)
        searchBar.selectedScopeButtonIndex = section ?? 0
        tableView.reloadData()
    }
}
