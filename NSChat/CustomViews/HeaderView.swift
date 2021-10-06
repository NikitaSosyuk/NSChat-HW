//
//  HeaderView.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 04.10.2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "HeaderView"
    
    // MARK: - UI
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Habibi-Regular", size: 14)
        return label
    }()
    
    private enum Constants {
        static let offset: CGFloat = 6
    }
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.backgroundColor = .white
        dateLabel.textAlignment = .center
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods

    func setTitle(text: String) {
        dateLabel.text = text
    }
    
    // MARK: - Private Methods
    
    private func setConstraints() {
        self.contentView.autoresizingMask = .flexibleHeight
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.offset),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.offset),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
