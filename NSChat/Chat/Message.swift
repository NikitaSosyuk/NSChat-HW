//
//  Message.swift
//  NSChat
//
//  Created by Nikita Sosyuk on 03.10.2021.
//

import Foundation

struct Message {
    let text: String
    let date: Date
    let isExternalMessage: Bool
}

struct MessageSection {
    var messages: [Message]
    let date: String
}
