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
        static let textViewTrailingOffset: CGFloat = -16
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
        return tableView
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.textViewCornerRadius
        view.backgroundColor = .blue
        return view
    }()
    
    private let inputTextField: SuperTextField = {
        let inputTexField = SuperTextField()
        inputTexField.backgroundColor = .textViewBackground
        inputTexField.font = UIFont(name: "Habibi-Regular", size: 16)
        inputTexField.layer.cornerRadius = Constants.textViewCornerRadius
        inputTexField.padding = Constants.placeholderInsets
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont(name: "Habibi-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        ]
        inputTexField.attributedPlaceholder = NSAttributedString(string: "Type your message here...", attributes:attributes)
        inputTexField.layer.borderWidth = 1
        inputTexField.layer.borderColor = UIColor.borderColor.cgColor
        return inputTexField
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send"), for: .normal)
        button.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .borderColor
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        self.view.backgroundColor = .white

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        service.getMessages { [unowned self] messages in
            self.sectionData = messages
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Private func
    
    private func addSubviews() {
        LayoutManager.addSubviewsTo(view: bottomView, inputTextField, sendButton, backgroundView, borderView)
        LayoutManager.addSubviewsTo(view: view, tableView, bottomView)
    }
    
    private func setConstraints() {
        LayoutManager.turnOffAutoresizingMaskTo(tableView, bottomView, sendButton, inputTextField, borderView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputTextField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: Constants.textViewLeadingOffset),
            inputTextField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: Constants.textViewTrailingOffset),
            inputTextField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: Constants.textViewTopOffset),
            inputTextField.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            inputTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.placeholderInsets.bottom),
            
            borderView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
            
            sendButton.topAnchor.constraint(equalTo: inputTextField.topAnchor, constant: Constants.sendButtonInsets.top),
            sendButton.trailingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: -Constants.sendButtonInsets.left),
            sendButton.widthAnchor.constraint(equalToConstant: Constants.sendButtonSize.width),
            sendButton.heightAnchor.constraint(equalToConstant: Constants.sendButtonSize.height)
        ])
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
