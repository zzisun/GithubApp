//
//  TableViewCell.swift
//  GithubApp
//
//  Created by 김지선 on 2021/10/24.
//

import UIKit

final class RepositoryCell: UITableViewCell {
    
    static let id = "RepositoryCell"
    
    let ownerStackView = UIStackView()
    let repositoryName = UILabel()
    let repositoryDescription = UILabel()
    let extraStackView = UIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
