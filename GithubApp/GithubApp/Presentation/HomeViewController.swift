//
//  ViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/21.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setSearchController()        
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search Repository"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {return}
        let resultViewController = ResultViewController()
        resultViewController.query = query
        
        navigationController?.pushViewController(resultViewController, animated: false)
    }
}
