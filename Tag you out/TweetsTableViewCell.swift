//
//  TweetsTableViewCell.swift
//  Tag you out
//
//  Created by Ruizhe Wang on 11/08/2021.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.font = UIFont(name: "TimesNewRomanPS-BoldItalicMT", size: 24)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 12)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(bodyLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        bodyLabel.makeConstraints(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, bottom: nil, topMargin: 5, leftMargin: 5, rightMargin: 5, bottomMargin: 0, width: 0, height: 0)
        
        dateLabel.makeConstraints(top: bodyLabel.bottomAnchor, left: bodyLabel.leftAnchor, right: nil, bottom: contentView.bottomAnchor, topMargin: 5, leftMargin: 10, rightMargin: 0, bottomMargin: 5, width: 0, height: 0)
        
        nameLabel.makeConstraints(top: bodyLabel.bottomAnchor, left: nil, right: bodyLabel.rightAnchor, bottom: contentView.bottomAnchor, topMargin: 5, leftMargin: 5, rightMargin: 5, bottomMargin: 5, width: 0, height: 0)
    }
    
    func configure(with tweet: Tweet) {
        bodyLabel.text = """
                         "\(tweet.bodyText)"
                         """
        dateLabel.text = "\(tweet.dateText)"
        nameLabel.text = "From \(tweet.nameText)"
    }
}
