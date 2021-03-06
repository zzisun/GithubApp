//
//  Request.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation
import Alamofire

struct RequestManager: RequestManagable {
    private let headers: HTTPHeaders = ["Authorization": "token \(Token.data)"]
    
    func request(for method: HTTPMethod, query: String) -> DataRequest {
        let endpoint = Endpoint.search(query: query)
        return AF.request(endpoint.url!, method: method, headers: headers)
    }
}
