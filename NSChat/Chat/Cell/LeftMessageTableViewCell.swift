//
//  LeftMessageTableViewCell.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//


import UIKit

class LeftMessageTableViewCell: UITableViewCell {

    static let identifier = "LeftMessageTableViewCell"
    
    // MARK: - Constants
    
    private enum Constants {
        static let avatarHeight: CGFloat = 12
        static let leadingOffset: CGFloat = 16
        static let trailingOffset: CGFloat = 59
        static let cornerRadius: CGFloat = 12
        static let textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        static let avatarSize = CGSize(width: 32, height: 32)
        static let bottomOffset: CGFloat = 6
        static let topOffset: CGFloat = 18
    }

    // MARK: - UI
    
    private let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .leftCellBackground
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()

    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "Habibi-Regular", size: 14)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Habibi-Regular", size: 14)
        return label
    }()
    
    private let avatarView = UIImageView()
    
    // MARK: - Private properties
    
    private let dateFormatter = DateFormatter()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .backgroundMy
        addSubviews()
        dateFormatter.dateFormat = "HH:mm a"
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
    }

    // MARK: - Internal Methods
    
    func setData(configuration: Message) {
        avatarView.image = #imageLiteral(resourceName: "Profile Photo")
        messageTextLabel.text = configuration.text
        dateLabel.text = dateFormatter.string(from: configuration.date)
    }

    // MARK: - Private Methods
    private func addSubviews() {
        LayoutManager.addSubviewsTo(view: contentView, dateLabel, messageView, avatarView)
        LayoutManager.addSubviewsTo(view: messageView, messageTextLabel)
    }

    private func makeConstraints() {
        LayoutManager.turnOffAutoresizingMaskTo(messageTextLabel, dateLabel, messageView, avatarView)
        
        dateLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        messageTextLabel.setContentCompressionResistancePriority(UILayoutPriority(752), for: .vertical)
        
//        NSLayoutConstraint.activate([
//            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topOffset),
//            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
//            avatarView.heightAnchor.constraint(equalToConstant: Constants.avatarSize.height),
//            avatarView.widthAnchor.constraint(equalToConstant: Constants.avatarSize.width),
//
//            messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topOffset),
//            messageView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: Constants.textInsets.top),
//            messageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.trailingOffset),
//
//            messageTextLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: Constants.textInsets.top),
//            messageTextLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -Constants.textInsets.right),
//            messageTextLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: Constants.textInsets.left),
//            messageTextLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -Constants.textInsets.bottom),
//
//            dateLabel.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: Constants.textInsets.bottom),
//            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomOffset),
//            dateLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor),
//        ])
        
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topOffset)
            make.leading.equalToSuperview().inset(Constants.leadingOffset)
            make.size.equalTo(Constants.avatarSize)
        }
        
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topOffset)
            make.leading.equalTo(avatarView.snp.trailing).offset(Constants.textInsets.top)
            make.trailing.lessThanOrEqualToSuperview().inset(Constants.trailingOffset)
        }
        
        messageTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.textInsets)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(Constants.textInsets.bottom)
            make.bottom.equalToSuperview().inset(Constants.bottomOffset)
            make.trailing.equalTo(messageView.snp.trailing)
        }
    }

}
