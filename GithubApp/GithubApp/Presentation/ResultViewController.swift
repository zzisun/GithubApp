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
        registerXib()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: RepositoryCell.id, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: RepositoryCell.id)
    }
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.id, for: indexPath) as! RepositoryCell
        let repository = repositories?[indexPath.row]
        
        cell.ownerImageView.image = RepositoryCell.image(with: repository?.owner.avatarURL)
        cell.ownerNameLabel.text = repository?.owner.name
        cell.repositoryNameLabel.text = repository?.name
        cell.repositoryDescriptionLabel.text = repository?.description
        cell.starCountLabel.text = RepositoryCell.starCount(with: repository?.starCount)
        cell.languageLabel.text = repository?.language
        
        return cell
    }
}
