//
//  ResultViewModel.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import Foundation
import RxSwift

protocol RepositoriesViewModelType {
    var fetchResults: AnyObserver<Void> { get }
    
    var activated: Observable<Bool> { get }
    var errorMessage: Observable<NSError> { get }
    var repositories: Observable<[Repository]> { get }
}

class RepositoriesViewModel: RepositoriesViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    let fetchResults: AnyObserver<Void>
    
    // OUTPUT
    let activated: Observable<Bool>
    let errorMessage: Observable<NSError>
    let repositories: Observable<[Repository]>
    
    init(domain: RepositoriesFetchable = RepositoriesUsecase()) {
        let fetching = PublishSubject<Void>()
    }
    
}
