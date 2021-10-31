//
//  Usecase.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import Foundation
import RxSwift

protocol RepositoryFetchable {
    func fetchRepositories(query: String) -> Observable<[Repository]>
}

struct RepositoryUsecase: RepositoryFetchable {
    private let networkManager: NetworkManagable
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
    
    func fetchRepositories(query: String) -> Observable<[Repository]> {
        return networkManager.fetchDataObservable(query: query, decodingType: Results.self)
            .map { results in
                return results.repositories
            }
    }
}
