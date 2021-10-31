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
        viewModel = RepositoryViewModel(query: " ") 
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
    var tableView: UITableView! // 이렇게 선언하면 위험하다 let으로 선언하고 인스턴스를 안전하게 생성하도록!
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
                // cell이 재사용되다보니 스크롤 하면서 이미지가 해당하는 위치에 표시되지 않는 오류가 발생할 수 있다.
                // 해결방법: 이미지 url과함께 이미지 id를 저장시킨 후 cell이 표시하는 repo의 id와 같은지 표시
                // 화면이 넘어가면 이미지로드를 cancel하는 경우
                ImageLoadManager.load(from: repository.owner.avatarURL)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { image in
                        cell.ownerImageView.image = image
                    })
                    .disposed(by: self.disposeBag)
                
                // cell에 repository넘겨서 처리하기
                cell.ownerNameLabel.text = repository.owner.name
                cell.repositoryNameLabel.text = repository.name
                cell.repositoryDescriptionLabel.text = repository.description
                cell.starCountLabel.text = RepositoryCell.starCount(with: repository.starCount)
                cell.languageLabel.text = repository.language
            }.disposed(by: disposeBag)
    }
}
