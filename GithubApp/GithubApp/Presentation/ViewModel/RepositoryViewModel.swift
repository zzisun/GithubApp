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
//    var fetchRepositories: AnyObserver<Void> { get }
//
//    var activated: Observable<Bool> { get }
//    var errorMessage: Observable<NetworkError> { get }
    var repositories: BehaviorSubject<[Repository]> { get }
}

class RepositoryViewModel: RepositoryViewModelType {
let disposeBag = DisposeBag()
    var query: String
    // INPUT
//    let fetchRepositories: AnyObserver<Void>
//
//    // OUTPUT
//    let activated: Observable<Bool>
//    let errorMessage: Observable<NetworkError>
    let repositories = BehaviorSubject<[Repository]>(value: [])
    
    init(query: String, domain: RepositoryFetchable = RepositoryUsecase()) {
        self.query = query
//        let repositoriesSubject = BehaviorSubject<[Repository]>(value: [])
//        let activating = BehaviorSubject<Bool>(value: false)
//        let errorSubject = PublishSubject<NetworkError>()
//        repositories.onNext(domain.fetchRepositories(query: query))
        domain.fetchRepositories(query: query)
            .subscribe(onNext: {
                self.repositories.onNext($0)
            })

//        activated = activating.distinctUntilChanged()
//        errorMessage = errorSubject
    }
}
