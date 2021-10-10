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
        static let labelLeading: CGFloat = 8
        static let imageWidthHeight: CGFloat = 40
        static let descriptionLabelTop: CGFloat = 4
        static let contentTopLeadingBottomTrailing: CGFloat = 24
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.descriptionLabelTop
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.addSubview(avatarImageView)
        self.addSubview(stackView)
        self.addSubview(dateLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setConstraints() {
        LayoutManager.turnOffAutoresizingMaskTo(avatarImageView, stackView, dateLabel, usernameLabel, descriptionLabel)
        
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.labelLeading).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        stackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -Constants.contentTopLeadingBottomTrailing).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentTopLeadingBottomTrailing).isActive = true
    }
}
