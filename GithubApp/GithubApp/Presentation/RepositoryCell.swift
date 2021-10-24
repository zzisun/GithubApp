//
//  TableViewCell.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import UIKit

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
    
    static func image(with urlString: String?) -> UIImage? {
        let urlString = urlString ?? "https://avatars.githubusercontent.com/u/60323625?v=4"
        guard let url = URL(string: urlString) else {return nil}
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: imageData)
    }
    
    static func starCount(with starCount: Int?) -> String {
        guard let starCount = starCount else {return "?"}
        return "\(starCount)"
    }
}
