//
//  ResultViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import RxCocoa
import RxSwift
import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    var query: String? // private로 변경필요, nil값 안오기에 optional일 필요없다

    var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = ResultViewModel()
    
    let repositories: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBinding()
        fetchResults()
    }
    
    // MARK: - UI
    private func configure() {
        setNavigationBar()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Repositories" 
        navigationController?.navigationBar.prefersLargeTitles = false
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 20, width: 20, height: 20))
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.isHidden = true
    }
    
    private func setTableView() {
        tableView = UITableView()
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
    
    func setupBinding() {
        repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.id,
                                         cellType: RepositoryCell.self)) { _, repository, cell in
                self.loadImage(repository.owner.avatarURL) { image in
                    cell.ownerImageView.image = image
                }
                cell.ownerNameLabel.text = repository.owner.name
                cell.repositoryNameLabel.text = repository.name
                cell.repositoryDescriptionLabel.text = repository.description
                cell.starCountLabel.text = RepositoryCell.starCount(with: repository.starCount)
                cell.languageLabel.text = repository.language
            }.disposed(by: disposeBag)
    }
}

extension ResultViewController {
    func fetchResults() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        NetworkManager.fetchResultsObservable(query: query!, decodingType: Results.self)
            .map { results in
                return results.items
            }
            .observe(on: MainScheduler.instance)
            .do(onError: { [weak self] error in
                self?.showAlert("Fetch Fail", "\(error)")
            }, onDispose: {
                self.activityIndicator.isHidden = true
            })
            .bind(to: repositories)
            .disposed(by: disposeBag)
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
