//
//  RightMessageTableViewCell.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//

import UIKit

final class RightMessageTableViewCell: UITableViewCell {

    static let identifier = "RightMessageTableViewCell"
    
    public enum ConstType {
        case top
        case bottom
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let leadingOffset: CGFloat = 59
        static let trailingOffset: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        static let bottomOffset: CGFloat = 6
        static let topOffset: CGFloat = 18
        static let newTopOffset: CGFloat = 4
    }

    // MARK: - UI
    
    private let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .rightCellBackground
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()

    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .rightMessageTextColor
        label.numberOfLines = 0
        label.font = UIFont(name: "Habibi-Regular", size: 14)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        label.font = UIFont(name: "Habibi-Regular", size: 14)
        return label
    }()
    
    // MARK: - Private properties
    
    private let dateFormatter = DateFormatter()
    private var topConstraint: NSLayoutConstraint?

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .backgroundMy
        addSubviews()
        makeConstraints()
        dateFormatter.dateFormat = "HH:mm a"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods
    
    func setData(configuration: Message) {
        messageTextLabel.text = configuration.text
        dateLabel.text = dateFormatter.string(from: configuration.date)
    }
    
    // TODO: - не успел сделать адекватно(((
    func undoContraint(type: ConstType) {
        switch type {
        case .top:
            messageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(Constants.newTopOffset)
            }
        case .bottom:
            dateLabel.removeFromSuperview()
            messageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(Constants.topOffset)
                make.trailing.equalToSuperview().inset(Constants.trailingOffset)
                make.leading.greaterThanOrEqualToSuperview().offset(Constants.leadingOffset)
                make.bottom.equalToSuperview()
            }
        }
    }

    // MARK: - Private Methods
    private func addSubviews() {
        LayoutManager.addSubviewsTo(view: contentView, dateLabel, messageView)
        LayoutManager.addSubviewsTo(view: messageView, messageTextLabel)
    }

    private func makeConstraints() {
        LayoutManager.turnOffAutoresizingMaskTo(messageTextLabel, dateLabel, messageView)
        
        dateLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        messageTextLabel.setContentCompressionResistancePriority(UILayoutPriority(752), for: .vertical)
        
//        NSLayoutConstraint.activate([
//
//            messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.trailingOffset),
//            messageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
//            messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topOffset),
//
//            messageTextLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: Constants.textInsets.top),
//            messageTextLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -Constants.textInsets.right),
//            messageTextLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: Constants.textInsets.left),
//            messageTextLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -Constants.textInsets.bottom),
//
//            dateLabel.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: Constants.textInsets.bottom),
//            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomOffset),
//            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.trailingOffset),
//            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
//        ])
        
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topOffset)
            make.trailing.equalToSuperview().inset(Constants.trailingOffset)
            make.leading.greaterThanOrEqualToSuperview().offset(Constants.leadingOffset)
        }
        
        messageTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.textInsets)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(Constants.textInsets.bottom)
            make.bottom.equalToSuperview().inset(Constants.bottomOffset)
            make.trailing.equalToSuperview().inset(Constants.trailingOffset)
            make.leading.greaterThanOrEqualToSuperview().offset(Constants.leadingOffset)
        }
    }

}
