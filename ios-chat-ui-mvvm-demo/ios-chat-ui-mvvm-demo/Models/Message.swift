//
//  Message.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation
import RealmSwift

final class Message: Object {

    @objc dynamic var messageID = 0
    @objc dynamic var message = ""
    @objc dynamic var postedDate = Date().now()

    var postDate: String {
        return postedDate.dateStyleHHMM()
    }

    override static func primaryKey() -> String? {
        return "messageID"
    }  
}
