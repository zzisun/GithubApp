//
//  TableViewCell.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import UIKit
import RxSwift

final class RepositoryCell: UITableViewCell {
    static let id = "RepositoryCell"

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func starCount(with starCount: Int?) -> String {
        guard let starCount = starCount else {return "?"}
        return "\(starCount)"
    }
}
