//
//  NetworkManager.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation
import Alamofire

struct NetworkManager: NetworkManagable {
    let requestManager = RequestManager()
    
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
                            guard let data = dataResponse.value else {
                                return completionHandler(.failure(NetworkError.noResult))
                            }
                            completionHandler(.success(data))
                        case 300..<400:
                            completionHandler(.failure(NetworkError.noResult))
                        case 400..<500:
                            completionHandler(.failure(NetworkError.notAllowed))
                        case 500...:
                            completionHandler(.failure(NetworkError.server))
                        default:
                            completionHandler(.failure(NetworkError.unknown))
                        }
        }
    }
}
