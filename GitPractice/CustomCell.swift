//
//  CustomCell.swift
//  GitPractice
//
//  Created by tobihige on 2024/01/09.
//

import UIKit

class CustomCell: UITableViewCell {
    static var identifier: String = "customCell"
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
    }
    
    func configure(githubModel: GithubModel) {
        self.titleLabel.text = githubModel.name
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
