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
    private var disposeBag = DisposeBag()

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func starCount(with starCount: Int?) -> String {
        guard let starCount = starCount else {return "?"}
        return "\(starCount)"
    }
    
    func configure(repository: Repository) {
        ImageLoadManager.load(from: repository.owner.avatarURL)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { image in
                self.ownerImageView.image = image
            })
            .disposed(by: self.disposeBag)
        
        self.ownerNameLabel.text = repository.owner.name
        self.repositoryNameLabel.text = repository.name
        self.repositoryDescriptionLabel.text = repository.description
        self.starCountLabel.text = starCount(with: repository.starCount)
        self.languageLabel.text = repository.language
    }
    
    override func prepareForReuse() {
        self.ownerImageView.image = UIImage(named: "placeholderImage")
    }
}
