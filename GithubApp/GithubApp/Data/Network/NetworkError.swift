//
//  NetworkError.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/22.
//

import Foundation

enum NetworkError: Int, Error {
    case internet
    case notModified = 304
    case validationFailed = 422
    case serviceUnavailable = 503
    case unknown
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .internet:
            return "⚠️ 인터넷 연결을 확인해주세요"
        case .notModified:
            return "⚠️ 검색 결과를 찾을 수 없습니다"
        case .validationFailed:
            return "⚠️ 잘못된 접근입니다"
        case .serviceUnavailable:
            return "⚠️ 서버 상태가 불안정합니다"
        case .unknown:
            return "⚠️ 알 수 없는 문제가 발생했습니다"
        }
    }
}
