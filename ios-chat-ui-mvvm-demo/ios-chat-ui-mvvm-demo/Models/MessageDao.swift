//
//  MessageDao.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation
import RealmSwift

final class MessageDao {

    static let dao = RealmDaoHelper<Message>()

    /// メッセージを追加する
    ///
    /// - Parameters:
    ///   - message: メッセージ
    ///   - postedDate: 投稿日
    static func add(message: String, postedDate: Date? = nil) {

        let object = Message()
        object.messageID = dao.newId()!
        object.message = message
        object.postedDate = postedDate ?? Date().now()
        dao.add(d: object)
    }

    /// 投稿日で検索する
    ///
    /// - Parameter postedDate: 日付
    /// - Returns: メッセージ一覧
    static func findBy(postedDate: String) -> [Message] {

        let fromDate = "\(postedDate) 00:00:00".toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        let toDate = "\(postedDate) 23:59:59".toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        return dao.findAll().filter("postedDate >= %@ AND postedDate <= %@", fromDate, toDate)
            .map { Message(value: $0) }
    }

    /// 投稿日ごとに集計する
    ///
    /// - Returns: メッセージ一覧
    static func groupByPostedDate() -> [String] {

        let messages = MessageDao.dao.findAll()
        var results = [String]()

        for message in messages {

            guard let postedDate = message.postedDate
                .description.components(separatedBy: " ").first else {
                    continue
            }

            if (results.filter { $0 == postedDate }.count > 0) {
                continue
            }
            results.append(postedDate)
        }
        return results
    }
}
