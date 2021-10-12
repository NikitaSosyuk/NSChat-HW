//
//  ViewController.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var sectionData: [MessageSection] = []
    private let service: ChatNetworkService = ChatNetworkServiceImpl()
    
    // MARK: - Constants
    
    private enum Constants {
        static let textViewTrailingOffset: CGFloat = 16
        static let textViewLeadingOffset: CGFloat = 16
        static let textViewTopOffset: CGFloat = 12
        static let textViewHeight: CGFloat = 40
        static let textViewCornerRadius: CGFloat = 20
        static let placeholderInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 40)
        static let sendButtonInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 0)
        static let sendButtonSize = CGSize(width: 32, height: 32)
        static let lineHeight: CGFloat = 1
    }
    
    // MARK: - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(RightMessageTableViewCell.self, forCellReuseIdentifier: RightMessageTableViewCell.identifier)
        tableView.register(LeftMessageTableViewCell.self, forCellReuseIdentifier: LeftMessageTableViewCell.identifier)
        tableView.register(HeaderView.self,forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.backgroundColor = .backgroundMy
        return tableView
    }()

    private let inputTextField: SuperTextField = {
        let inputTextField = SuperTextField()
        inputTextField.backgroundColor = .placeholderBackground
        inputTextField.font = UIFont(name: "Habibi-Regular", size: 16)
        inputTextField.layer.cornerRadius = Constants.textViewCornerRadius
        inputTextField.padding = Constants.placeholderInsets
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont(name: "Habibi-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        ]
        inputTextField.attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes:attributes)
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor.borderColor.cgColor
        return inputTextField
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send"), for: .normal)
        button.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorColor
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundViewPlaceholder
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setConstraints()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "Jessica Thompson"
        self.view.backgroundColor = .backgroundMy

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        service.getMessages { [unowned self] messages in
            self.sectionData = messages
            self.tableView.reloadData()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.userInterfaceStyle == .dark {
            self.inputTextField.layer.borderColor = UIColor.borderColor.cgColor
        } else {
            self.inputTextField.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - Private func
    
    private func addSubviews() {
        LayoutManager.addSubviewsTo(view: bottomView, inputTextField, sendButton)
        LayoutManager.addSubviewsTo(view: view, tableView, bottomView)
        LayoutManager.addSubviewsTo(view: bottomView, borderView)
    }
    
    private func setConstraints() {
        LayoutManager.turnOffAutoresizingMaskTo(tableView, bottomView, sendButton, inputTextField, borderView)
        
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
//
//            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//
//            inputTextField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: Constants.textViewLeadingOffset),
//            inputTextField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -Constants.textViewTrailingOffset),
//            inputTextField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: Constants.textViewTopOffset),
//            inputTextField.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
//            inputTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.placeholderInsets.bottom),
//
//            borderView.topAnchor.constraint(equalTo: bottomView.topAnchor),
//            borderView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
//            borderView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
//            borderView.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
//
//            sendButton.topAnchor.constraint(equalTo: inputTextField.topAnchor, constant: Constants.sendButtonInsets.top),
//            sendButton.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: -Constants.sendButtonInsets.left),
//            sendButton.widthAnchor.constraint(equalToConstant: Constants.sendButtonSize.width),
//            sendButton.heightAnchor.constraint(equalToConstant: Constants.sendButtonSize.height)
//        ])
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.lineHeight)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(bottomView).offset(Constants.textViewTopOffset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.placeholderInsets.bottom)
            make.leading.equalTo(bottomView).offset(Constants.textViewLeadingOffset)
            make.trailing.equalTo(bottomView).inset(Constants.textViewTrailingOffset)
            make.height.equalTo(Constants.textViewHeight)
        }
        
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(Constants.sendButtonSize)
            make.top.equalTo(inputTextField).inset(Constants.sendButtonInsets.top)
            make.trailing.equalTo(inputTextField).inset(Constants.sendButtonInsets.left)
        }
    }
    
    // MARK: - Objc
    
    @objc private func sendButtonAction() {
        if let text = inputTextField.text, !text.isEmpty {
            inputTextField.text = ""
            
            sectionData[sectionData.count - 1].messages.append(Message(text: text, date: Date(), isExternalMessage: false))
            let indexPath = IndexPath(
                row: self.tableView.numberOfRows(inSection: sectionData.count - 1),
                section: sectionData.count - 1
            )
            
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardSize.height - view.safeAreaInsets.bottom
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionData[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configuration = sectionData[indexPath.section].messages[indexPath.row]
        if configuration.isExternalMessage {
            guard let leftCell = tableView.dequeueReusableCell(withIdentifier: LeftMessageTableViewCell.identifier, for: indexPath) as? LeftMessageTableViewCell else {
                return UITableViewCell()
            }
            leftCell.setData(configuration: configuration)
            return leftCell
        } else {
            guard let rightCell = tableView.dequeueReusableCell(withIdentifier: RightMessageTableViewCell.identifier, for: indexPath) as? RightMessageTableViewCell else {
                return UITableViewCell()
            }
            // TODO: - не успел сделать адекватно(((
            if configuration.text == "Sure. Let’s aim for saturday" {
                rightCell.undoContraint(type: .bottom)
            }
            if configuration.text == "I’m visiting mom this sunday 👻" {
                rightCell.undoContraint(type: .top)
            }
            rightCell.setData(configuration: configuration)
            return rightCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView else {
            return UIView()
        }
        header.setTitle(text: sectionData[section].date)
        return header
    }
}
