//
//  NetworkManager.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager: NetworkManagable {
    private let requestManager: RequestManagable
    
    init(requestManager: RequestManagable) {
        self.requestManager = requestManager
    }
    
    func search<T: Decodable>(query: String,
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
    
    func fetchDataObservable<T: Decodable>(query: String, decodingType: T.Type) -> Observable<T> {
        return Observable.create { emitter in
            self.search(query: query, decodingType: T.self) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
