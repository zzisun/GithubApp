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
        // cell이 재사용되다보니 스크롤 하면서 이미지가 해당하는 위치에 표시되지 않는 오류가 발생할 수 있다.
        // 해결방법: 이미지 url과함께 이미지 id를 저장시킨 후 cell이 표시하는 repo의 id와 같은지 표시
        // 화면이 넘어가면 이미지로드를 cancel하는 경우
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
}
