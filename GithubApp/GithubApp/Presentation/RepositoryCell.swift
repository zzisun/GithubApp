//
//  TableViewCell.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/25.
//

import UIKit

class RepositoryCell: UITableViewCell {
    static let id = "RepositoryCell"

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
