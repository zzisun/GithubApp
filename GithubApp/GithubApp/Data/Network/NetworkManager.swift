//
//  NetworkManager.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation
import Alamofire
import RxSwift

struct NetworkManager: NetworkManagable {
    static let requestManager = RequestManager() // static이 어색한데,,ㅠ
    
    static func search<T: Decodable>(query: String,
                              decodingType: T.Type,
                             completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let request = requestManager.request(for: .get, query: query)
        request.responseDecodable(of: decodingType) { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else {
                            return completionHandler(.failure(NetworkError.internet))
                        }
            switch statusCode {
            case 200..<300:
                guard let data = dataResponse.value else { return }
                completionHandler(.success(data))
            case 300..<400:
                completionHandler(.failure(NetworkError.notModified))
            case 400..<500:
                completionHandler(.failure(NetworkError.validationFailed))
            case 500...:
                completionHandler(.failure(NetworkError.serviceUnavailable))
            default:
                completionHandler(.failure(NetworkError.unknown))
            }
        }
    }
    
    static func fetchResultsObservable(query: String) -> Observable<Results> {
        return Observable.create { emitter in
            NetworkManager.search(query: query, decodingType: Results.self) { result in
                switch result {
                case .success(let results):
                    emitter.onNext(results)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
