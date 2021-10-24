//
//  ResultViewController.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import UIKit

final class ResultViewController: UIViewController {
    
    var query: String? // private로 변경필요, nil값 안오기에 optional일 필요없다
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager()
        networkManager.search(query: query!, decodingType: Results.self) { (response, error) in
            print(response.items)
        }
    }
}
