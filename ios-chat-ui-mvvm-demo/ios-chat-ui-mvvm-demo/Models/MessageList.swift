//
//  MessageList.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/23.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class MessageList: NSObject {

    init(messageGroups: [String] = [], messages: [[Message]] = []) {
        self.messageGroups = messageGroups
        self.messages = messages
    }

    var messageGroups = [String]()
    var messages = [[Message]]()
}
