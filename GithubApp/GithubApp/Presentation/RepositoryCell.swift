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
    let ownerNameImage = UIImageView()
    let ownerNameLabel = UILabel()
    
    let repositoryNameLabel = UILabel()
    let repositoryDescriptionLabel = UILabel()
    
    let extraStackView = UIStackView()
    let starImage = UIImage(systemName: "star.fill")
    let starCountLabel = UILabel()
    let languageLabel = UILabel()
    
    func layout() {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
