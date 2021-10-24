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
//        let networkManager = NetworkManager()
//        networkManager.search(query: "WorldAfterCapital", decodingType: Results.self) { response in
//            print(response)
//        }
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

//class ViewController: UIViewController {
//    let tableView: UITableView = UITableView()
//    var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone" ]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupSearchController()
//        self.setupTableView()
//
//    }
//    func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Search Dj"
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.navigationItem.searchController = searchController
//        self.navigationItem.title = "Search"
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//
//    }
//    func setupTableView() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.view.addSubview(self.tableView)
//
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addConstraint(NSLayoutConstraint(item: self.tableView,
//                                                           attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top,
//                                                           multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.tableView,
//                                                           attribute: .bottom, relatedBy: .equal, toItem: self.view,
//                                                           attribute: .bottom, multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.tableView,
//                                                           attribute: .leading, relatedBy: .equal, toItem: self.view,
//                                                           attribute: .leading, multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.tableView,
//                                                           attribute: .trailing, relatedBy: .equal, toItem: self.view,
//                                                           attribute: .trailing, multiplier: 1.0, constant: 0))
//    }
//
//}
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.arr.count
//
//    }
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = self.arr[indexPath.row]
//        return cell
//    }
//}
//
