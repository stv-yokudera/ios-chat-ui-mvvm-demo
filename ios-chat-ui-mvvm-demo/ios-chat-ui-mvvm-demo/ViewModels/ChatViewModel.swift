//
//  ChatViewModel.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/17.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let isSendEnabled = Notification.Name(rawValue: "isSendEnabled")
    static let messageListChanged = Notification.Name(rawValue: "messageListChanged")
}

final class ChatViewModel {

    private let center: NotificationCenter
    private var observers = [NSObjectProtocol]()
    var inputText = ""

    init(center: NotificationCenter = .init()) {
        self.center = center
        initialValue()
    }

    deinit {
        observers.forEach {
            center.removeObserver($0)
        }
    }

    func initialValue() {
        isSendEnabled = false
        let messageGroups = MessageDao.groupByPostedDate()
        let messages = messageGroups.map { MessageDao.findBy(postedDate: $0) }
        messageList = MessageList(messageGroups: messageGroups, messages: messages)
    }

    // MARK: - Output

    @objc dynamic private(set) var isSendEnabled: Bool = false {
        didSet {
            center.post(name: .isSendEnabled, object: nil)
        }
    }

    @objc dynamic private(set) var messageList: MessageList = MessageList() {
        didSet {
            center.post(name: .messageListChanged, object: nil)
        }
    }

    // MARK: - Event Input

    /// TextFieldの文字が変更されたとき
    @objc func inputTextChanged() {
        isSendEnabled = !inputText.isEmpty
    }

    /// 送信ボタンが押されたとき
    @objc func send() {
        MessageDao.add(message: inputText, postedDate: Date())
        let messageGroups = MessageDao.groupByPostedDate()
        let messages = messageGroups.map { MessageDao.findBy(postedDate: $0) }
        print(messages)
        messageList = MessageList(messageGroups: messageGroups, messages: messages)
    }
}

extension ChatViewModel: Observable {

    func observe<Value1, Target: AnyObject, Value2>(keyPath keyPath1: ReferenceWritableKeyPath<ChatViewModel, Value1>,
                                                    on queue: OperationQueue? = .main,
                                                    bindTo target: Target,
                                                    _ keyPath2: ReferenceWritableKeyPath<Target, Value2>) throws {
        let name: Notification.Name
        switch keyPath1 {
        case \ChatViewModel.isSendEnabled: name = .isSendEnabled
        case \ChatViewModel.messageList: name = .messageListChanged
        default: throw Error.invalidKeyPath(keyPath1)
        }

        let handler: () -> () = { [weak self, weak target] in
            guard let me = self, let target = target, let value = me[keyPath: keyPath1] as? Value2 else { return }
            target[keyPath: keyPath2] = value
        }

        handler()
        let observer = center.addObserver(forName: name, object: nil, queue: queue) { _ in handler() }
        observers.append(observer)
    }
}
