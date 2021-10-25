//
//  Usecase.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import Foundation
import RxSwift

protocol RepositoriesFetchable {
    func fetchRepositories(query: String) -> Observable<[Repository]>
}

struct RepositoriesUsecase: RepositoriesFetchable {
    func fetchRepositories(query: String) -> Observable<[Repository]> {
        return NetworkManager.fetchDataObservable(query: query, decodingType: Results.self)
            .map { results in
                return results.repositories
            }
    }
}
