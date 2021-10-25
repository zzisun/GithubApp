//
//  ResultViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import RxCocoa
import RxSwift
import RxViewController
import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    var query: String? // private로 변경필요, nil값 안오기에 optional일 필요없다
    let viewModel: RepositoryViewModelType
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    init(viewModel: RepositoryViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = RepositoryViewModel(query: query ?? " ") // required init 어떤애인지 - 여기 언제 실행되는지
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
    }
    
    // MARK: - UI
    var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView!
    private func configure() {
        setNavigationBar()
        setTableView()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Repositories"
        navigationController?.navigationBar.prefersLargeTitles = false
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
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
        viewModel.repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.id,
                                         cellType: RepositoryCell.self)) { _, repository, cell in
                self.loadImage(from: repository.owner.avatarURL)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { image in
                        cell.ownerImageView.image = image
                    })
                    .disposed(by: self.disposeBag)
                
                cell.ownerNameLabel.text = repository.owner.name
                cell.repositoryNameLabel.text = repository.name
                cell.repositoryDescriptionLabel.text = repository.description
                cell.starCountLabel.text = RepositoryCell.starCount(with: repository.starCount)
                cell.languageLabel.text = repository.language
            }.disposed(by: disposeBag)
        
//        viewModel.activated
//            .map { !$0 }
//            .do(onNext: { [weak self] finished in
//                if finished {
//                    self?.tableView.refreshControl?.endRefreshing()
//                }
//            })
//            .bind(to: activityIndicator.rx.isHidden)
//            .disposed(by: disposeBag)
                
    }
}

extension ResultViewController {
    func loadImage(from imageURL: String) -> Observable<UIImage?> {
        return Observable.just(imageURL)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { try Data(contentsOf: $0!) }
            .map { UIImage(data: $0) }
    }
}
