//
//  NetworkManagable.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import Foundation
import RxSwift

protocol NetworkManagable {
    func search<T: Decodable>(query: String,
                              decodingType: T.Type,
                             completionHandler: @escaping (Result<T, NetworkError>) -> Void)
    func fetchDataObservable<T: Decodable>(query: String, decodingType: T.Type) -> Observable<T>
}
