//
//  ChatTableViewCell.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 10.10.2021.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
    
    static let identifier = "ChatTableViewCell"
    
    // MARK: - Constants
    
    private struct Constants {
        static let dateTopTrailing: CGFloat = 24
        static let imageTopBottom: CGFloat = 26
        static let imageLeading: CGFloat = 24
        static let textTopBottom: CGFloat = 24
        static let textLeading: CGFloat = 8
        static let textTrailing: CGFloat = 43
        static let distanceBetweenLabel: CGFloat = 4
        static let imageHeightWidth: CGFloat = 40
    }
    
    // MARK: - UI
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Habibi-Regular", size: 14)!
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Habibi-Regular", size: 14)!
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Habibi-Regular", size: 12)!
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .backgroundMy
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    func setData(configuration: Chat) {
        avatarImageView.image = configuration.image
        descriptionLabel.text = configuration.description
        dateLabel.text = configuration.date
        usernameLabel.text = configuration.firstName + configuration.lastName
    }
    
    // MARK: - Private func
    
    private func addSubviews() {
        LayoutManager.addSubviewsTo(view: self, avatarImageView, dateLabel, usernameLabel, descriptionLabel)
    }
    
    private func setConstraints() {
        // LayoutManager.turnOffAutoresizingMaskTo(avatarImageView, stackView, dateLabel, usernameLabel, descriptionLabel)
        usernameLabel.snp.contentHuggingHorizontalPriority = 240
        usernameLabel.snp.contentHuggingVerticalPriority = 1000
        descriptionLabel.snp.contentHuggingVerticalPriority = 1000
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.imageLeading)
            make.top.equalToSuperview().inset(Constants.imageTopBottom)
            make.width.height.equalTo(Constants.imageHeightWidth)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.textTopBottom)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.textLeading)
            make.trailing.equalTo(dateLabel.snp.leading)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(Constants.distanceBetweenLabel)
            make.bottom.equalToSuperview().inset(Constants.textTopBottom).priority(999)
            make.leading.equalTo(usernameLabel)
            make.trailing.equalToSuperview().inset(Constants.textTrailing)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.dateTopTrailing)
            make.top.equalToSuperview().inset(Constants.dateTopTrailing)
        }
    }
}
