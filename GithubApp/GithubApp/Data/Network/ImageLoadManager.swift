//
//  ImageLoadManager.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/26.
//

import Foundation
import RxSwift

final class ImageLoadManager {
    static func load(from imageURL: String) -> Observable<UIImage?> {
        return Observable.just(imageURL)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { try Data(contentsOf: $0!) }
            .map { UIImage(data: $0) }
    }
}
