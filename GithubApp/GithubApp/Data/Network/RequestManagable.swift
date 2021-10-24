//
//  RequestManagable.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import Foundation
import Alamofire

protocol RequestManagable {
    func request(for method: HTTPMethod, query: String) -> DataRequest 
}
