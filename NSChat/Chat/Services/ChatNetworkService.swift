//
//  ChatNetworkService.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//

import Foundation

protocol ChatNetworkService {
    func getMessages(completion: (([MessageSection]) -> Void))
}

final class ChatNetworkServiceImpl: ChatNetworkService {
    func getMessages(completion: (([MessageSection]) -> Void)) {
        let result: [MessageSection] = [
            MessageSection(
                messages: [
                    Message(
                        text: "Alex, let’s meet this weekend. I’ll check with Dave too 😎",
                        date: Date(timeIntervalSince1970: 1631651268000.0),
                        isExternalMessage: true
                    ),
                    Message(
                        text: "Sure. Let’s aim for saturday",
                        date: Date(timeIntervalSince1970: 1631653008000.0),
                        isExternalMessage: false
                    ),
                    Message(
                        text: "AI’m visiting mom this sunday 👻",
                        date: Date(timeIntervalSince1970: 1631653008000.0),
                        isExternalMessage: false
                    ),
                    Message(
                        text: "Alrighty! Will give you a call shortly 🤗",
                        date: Date(timeIntervalSince1970: 1631653308000.0),
                        isExternalMessage: true
                    ),
                    Message(
                        text: "❤️",
                        date: Date(timeIntervalSince1970: 1631653488000.0),
                        isExternalMessage: false
                    )
                ],
                date: "Sep 14, 2021"
            ),
            MessageSection(
                messages: [
                    Message(
                        text: "Hey you! Are you there?",
                        date: Date(timeIntervalSince1970: 1631706828000.0),
                        isExternalMessage: true
                    ),
                    Message(
                        text: "👋 Hi Jess! What’s up?",
                        date: Date(timeIntervalSince1970: 1631708088000.0),
                        isExternalMessage: false
                    )
                ],
                date: "Today"
            )
        ]
        completion(result)
    }
}
