//
//  ResultViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    
//    var query: String? // private로 변경필요, nil값 안오기에 optional일 필요없다
    var totalCount: Int?
    var repositories: [Repository]?
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let networkManager = NetworkManager()
//        networkManager.search(query: query!, decodingType: Results.self) { [self] data in
//            do {
//                try self.totalCount = data.get().totalCount
//                try self.repositories = data.get().items
//                print(totalCount, repositories)
//            } catch {
//                print("error")
//            }
//        }
        configure()
        setTableView()
    }
    
    private func configure() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = repositories?[indexPath.row].name
        return cell
    }
}
