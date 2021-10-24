//
//  ViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search Repository"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = .blue
    }
}
