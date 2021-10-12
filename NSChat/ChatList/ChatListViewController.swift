//
//  ChatListViewController.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 10.10.2021.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    private var chatData: [Chat] = [
        Chat(
            image: UIImage(named: "ProfilePhoto-1"),
            firstName: "Jessica",
            lastName: "Thompson",
            description: "Hey you! Are u there?",
            date: "4h ago"
        ),
        Chat(
            image: UIImage(named: "ProfilePhoto-2"),
            firstName: "Kat",
            lastName: "Williams",
            description: "OMG! OMG! OMG!",
            date: "5h ago"
        ),
        Chat(
            image: UIImage(named: "ProfilePhoto-3"),
            firstName: "Jacob",
            lastName: "Washington",
            description: "Sure. Sunday works for me!",
            date: "20/9/21"
        ),
        Chat(
            image: UIImage(named: "Profile"),
            firstName: "Leslie",
            lastName: "Alexander",
            description: "Sent you an invite for next monday.",
            date: "19/9/21"
        ),
        Chat(
            image: UIImage(named: "ProfilePhoto-4"),
            firstName: "Tony",
            lastName: "Monta",
            description: "How’s Alicia doing? Ask her to give m...",
            date: "19/9/21"
        )
    ]
    
    // MARK: - Constants
    
    private struct Constants {
        static let leadingTrailing: CGFloat = 8
        static let collectionHeight: CGFloat = 142
        static let collectionItemWidth: CGFloat = 80
        static let collectionItemHeight: CGFloat = 108
        static let forCellReuseIdentifier = "MessageCell"
        static let forHeaderFooterViewReuseIdentifier = "MessageHeader"
    }
    
    // MARK: - UI

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        tableView.backgroundColor = .backgroundMy
        return tableView
    }()

    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundMy
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "MESSAGES"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        
        let searchPlaceholderMutableString = NSMutableAttributedString(
            string: "Who do you want to chat with?",
            attributes: [
                .font : UIFont(name: "Habibi-Regular", size: 17)!,
                .foregroundColor: UIColor.gray
            ]
        )
        self.searchController.searchBar.searchTextField.attributedPlaceholder = searchPlaceholderMutableString
    
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Private func
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(configuration: chatData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(ChatViewController(), animated: true)
    }
}
