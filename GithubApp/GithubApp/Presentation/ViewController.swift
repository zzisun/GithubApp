//
//  ViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.search(decodingType: Results.self) { response in
            print(response)
        }
    }
}
