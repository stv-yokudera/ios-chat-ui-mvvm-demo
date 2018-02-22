//
//  MessageListProvider.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class MessageListProvider: NSObject {

    var messageList = MessageList()

    /// 該当のメッセージを取得する
    func message(section: Int, index: Int) -> Message {
        return messageList.messages[section][index]
    }
}

extension MessageListProvider: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return messageList.messageGroups.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return messageList.messages[section].count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return messageList.messageGroups[section]
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.identifier,
            for: indexPath
            ) as! MessageCell

        cell.message = message(section: indexPath.section,
                               index: indexPath.row)
        return cell
    }
}
