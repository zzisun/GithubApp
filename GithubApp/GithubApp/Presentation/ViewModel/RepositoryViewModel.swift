//
//  ResultViewModel.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import Foundation
import RxSwift

protocol RepositoryViewModelType {
    var query: String { get }
    var repositories: BehaviorSubject<[Repository]> { get }
    var activated: Observable<Bool> { get }
    var errorMessage: Observable<NetworkError> { get }
}

class RepositoryViewModel: RepositoryViewModelType {
    private let disposeBag = DisposeBag()
    var query: String
    
    let repositories: BehaviorSubject<[Repository]>
    let activated: Observable<Bool>
    let errorMessage: Observable<NetworkError>
    
    init(query: String, domain: RepositoryFetchable = RepositoryUsecase()) {
        self.query = query
        repositories = BehaviorSubject<[Repository]>(value: [])
        let activating = BehaviorSubject<Bool>(value: false)
        let errorSubject = PublishSubject<NetworkError>()
        
        activating.onNext(true)
        domain.fetchRepositories(query: query)
            .do(onNext: { _ in activating.onNext(false) })
                .do(onError: { error in errorSubject.onNext((error as? NetworkError) ?? NetworkError.unknown) })
            .subscribe(onNext: repositories.onNext)
            .disposed(by: disposeBag)
        
        activated = activating.distinctUntilChanged()
        errorMessage = errorSubject
    }
}
