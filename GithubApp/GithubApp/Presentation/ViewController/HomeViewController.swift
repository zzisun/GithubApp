//
//  ViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setSearchController()        
    }
    // MARK: - UI
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
        let repositoryViewModel = RepositoryViewModel(query: query)
        let resultViewController = ResultViewController(viewModel: repositoryViewModel) 
        navigationController?.pushViewController(resultViewController, animated: false)
    }
}
