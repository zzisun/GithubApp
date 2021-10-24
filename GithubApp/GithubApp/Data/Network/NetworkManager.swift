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
            print(dataResponse)
        }
    }
}
