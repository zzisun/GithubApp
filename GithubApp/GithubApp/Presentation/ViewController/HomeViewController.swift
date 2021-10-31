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
        // 여기서 usecase networkmanager 생성해서 의존성 주입
        let requestManager = RequestManager()
        let networkManager = NetworkManager(requestManager: requestManager)
        let repositoryUsecase = RepositoryUsecase(networkManager: networkManager)
        let repositoryViewModel = RepositoryViewModel(query: query, repositoryUsecase: repositoryUsecase)
        let resultViewController = ResultViewController(viewModel: repositoryViewModel) 
        navigationController?.pushViewController(resultViewController, animated: false)
    }
}
