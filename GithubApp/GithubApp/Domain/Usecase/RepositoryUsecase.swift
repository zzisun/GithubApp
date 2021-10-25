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
    func fetchRepositories(query: String) -> Observable<[Repository]> {
        return NetworkManager.shared.fetchDataObservable(query: query, decodingType: Results.self)
            .map { results in
                return results.repositories
            }
    }
}
