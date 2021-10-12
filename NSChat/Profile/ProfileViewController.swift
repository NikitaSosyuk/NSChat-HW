//
//  ProfileViewController.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 10.10.2021.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private struct Constants {
        static let logoutButtonTop: CGFloat = 101
        static let cityLabelTop: CGFloat = 19
        static let logoutButtonInset: CGFloat = 9.5
        static let cityLabelLeftInset: CGFloat = 25
        static let logoutButtonBorderWidth: CGFloat = 1
        static let logoutButtonCornerRadius: CGFloat = 15
        static let logoutButtonBorder: CGFloat = 40
        static let logoutButtonTopOffset: CGFloat = 6
    }
    
    // MARK: - UI
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Habibi-Regular", size: 16)!
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        button.layer.cornerRadius = Constants.logoutButtonCornerRadius
        button.layer.borderWidth = Constants.logoutButtonBorderWidth
        button.layer.borderColor = UIColor.label.cgColor
        
        button.imageEdgeInsets = .init(
            top: Constants.logoutButtonTopOffset / 2,
            left: -Constants.logoutButtonInset,
            bottom: 0,
            right: Constants.logoutButtonInset
        )
        
        button.titleEdgeInsets = .init(
            top: Constants.logoutButtonTopOffset,
            left: Constants.logoutButtonInset,
            bottom: Constants.logoutButtonTopOffset,
            right: -Constants.logoutButtonInset
        )
        
        button.contentEdgeInsets = .init(
            top: Constants.logoutButtonTopOffset,
            left: Constants.logoutButtonBorder,
            bottom: Constants.logoutButtonTopOffset,
            right: Constants.logoutButtonBorder
        )
        
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        button.titleLabel?.font = UIFont(name: "Habibi-Regular", size: 16)!
        
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundMy
        self.cityLabel.text = "Brooklyn, NY"
        self.navigationItem.title = "Alex Tsimikas"
        self.logoutButton.addTarget(self, action: #selector(logoutTaped), for: .touchUpInside)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = .init(title: "Messages",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(messagesTaped))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: "Habibi-Regular", size: 16) ?? UIFont.systemFont(ofSize: 22)], for: .normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: "Habibi-Regular", size: 16) ?? UIFont.systemFont(ofSize: 22)], for: .highlighted)
        
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem?.tintColor = .label
        self.navigationItem.backBarButtonItem?.tintColor = .label
        
        addSubviews()
        setConstraints()
    }
    
    
    // MARK: - Internal func

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.userInterfaceStyle == .dark {
            logoutButton.layer.borderColor = UIColor.black.cgColor
        } else {
            logoutButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - Private func
    
    private func addSubviews() {
        view.addSubview(cityLabel)
        view.addSubview(logoutButton)
    }
    
    private func setConstraints() {
        // LayoutManager.turnOffAutoresizingMaskTo(cityLabel, logoutButton)
        
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(Constants.cityLabelLeftInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.cityLabelTop)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(Constants.logoutButtonTop)
        }
    }
    
    @objc private func messagesTaped() {
        navigationController?.pushViewController(ChatListViewController(), animated: true)
    }
    
    @objc private func logoutTaped() { }
    
}
