//
//  MessageCell.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: PaddingLabel!
    @IBOutlet weak var postedDateLabel: UILabel!

    static var identifier: String {
        return String(describing: MessageCell.self)
    }

    var message: Message? {
        didSet {
            messageLabel.text = message?.message
            postedDateLabel.text = message?.postDate
        }
    }
}
