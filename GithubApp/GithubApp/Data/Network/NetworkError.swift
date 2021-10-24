//
//  NetworkError.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation

enum NetworkError: Int, Error {
    case notModified = 304
    case validationFailed = 422
    case serviceUnavailable = 503
}
