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
    private let viewModel: RepositoryViewModelType
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    init(viewModel: RepositoryViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        let requestManager = RequestManager()
        let networkManager = NetworkManager(requestManager: requestManager)
        let repositoryUsecase = RepositoryUsecase(networkManager: networkManager)
        viewModel = RepositoryViewModel(query: " ", repositoryUsecase: repositoryUsecase)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        disposeBag = DisposeBag()
    }
    // MARK: - UI
    private let tableView =  UITableView()
    private let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    private func configure() {
        setNavigationBar()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.isHidden = true
    }
    
    private func setTableView() {
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
    
    private func setupBinding() {
        viewModel.errorMessage
            .map { "\($0)" }
            .subscribe(onNext: {[weak self] message in
                self?.showAlert( message)
            })
            .disposed(by: disposeBag)
        
        viewModel.activated
            .map { !$0 }
            .do(onNext: { [weak self] finished in
                if finished {
                    self?.tableView.refreshControl?.endRefreshing()
                }
            })
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
                
        viewModel.repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.id,
                                         cellType: RepositoryCell.self)) { _, repository, cell in
                cell.configure(repository: repository)
            }.disposed(by: disposeBag)
    }
}
