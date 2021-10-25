//
//  ResultViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import UIKit
import SnapKit
import RxSwift

final class ResultViewController: UIViewController {
    
    var query: String? // private로 변경필요, nil값 안오기에 optional일 필요없다
    var totalCount: Int = 0
    var repositories: [Repository] = []
    var tableView: UITableView!
    
    let viewModel = ResultViewModel()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setTableView()
        fetchResults()
    }
    
    private func configure() {
        navigationItem.title = "Repositories"
        navigationItem.hidesBackButton = true
    }
    
    private func setTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        registerXib()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: RepositoryCell.id, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: RepositoryCell.id)
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.id, for: indexPath) as! RepositoryCell
        let repository = repositories[indexPath.row]
        loadImage(repository.owner.avatarURL) { image in
            cell.ownerImageView.image = image
        }
        cell.ownerNameLabel.text = repository.owner.name
        cell.repositoryNameLabel.text = repository.name
        cell.repositoryDescriptionLabel.text = repository.description
        cell.starCountLabel.text = RepositoryCell.starCount(with: repository.starCount)
        cell.languageLabel.text = repository.language
        
        return cell
    }
}

extension ResultViewController {
    func fetchResults() {
        let networkManager = NetworkManager()
        networkManager.search(query: query!, decodingType: Results.self) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert("Fetch Fail", "\(error)")
            case .success(let results):
                self?.totalCount = results.totalCount
                self?.repositories = results.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
                
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true, completion: nil)
    }
    
    func loadImage(_ url: String, _ completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: url)!
            let imageData = try? Data(contentsOf: url)
            let image = UIImage(data: imageData!)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
