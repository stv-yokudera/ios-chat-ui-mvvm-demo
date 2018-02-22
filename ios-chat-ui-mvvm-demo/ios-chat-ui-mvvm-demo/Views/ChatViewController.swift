//
//  ChatViewController.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/22.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit
import Foundation

private extension Selector {
    static let keyboardWillShow = #selector(ChatViewController.keyboardWillShow(notification:))
    static let keyboardWillHide = #selector(ChatViewController.keyboardWillHide(notification:))
}

final class ChatViewController: UIViewController {

    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textViewHeightConstraint: NSLayoutConstraint!
    
    private let viewModel = ChatViewModel()
    private let notificationCenter = NotificationCenter.default
    private let provider = MessageListProvider()
    private var messageList = MessageList() {
        didSet {
            provider.messageList = messageList
            tableView.reloadData()
            scrollToNewMessage()
        }
    }

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton.addTarget(viewModel, action: #selector(ChatViewModel.send), for: .touchUpInside)
        notificationCenter.addObserver(self, selector: .keyboardWillShow, name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: .keyboardWillHide, name: .UIKeyboardWillHide, object: nil)

        do {
            try viewModel.observe(keyPath: \ChatViewModel.isSendEnabled, bindTo: sendButton, \UIButton.isEnabled)
            try viewModel.observe(keyPath: \ChatViewModel.messageList, bindTo: self, \.messageList)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        tableView.dataSource = provider
    }

    // MARK: - UIResponder

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Selectors

    /// キーボードが表示されたときの処理
    @objc func keyboardWillShow(notification: Notification) {

        let rect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { [weak self] in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self?.view.transform = transform
        })
    }

    /// キーボードが非表示になるときの処理
    @objc func keyboardWillHide(notification: Notification) {

        let duration = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { [weak self] in
            self?.view.transform = CGAffineTransform.identity
        })
    }

    // MARK: - Private

    /// 最新のメッセージまで移動する
    private func scrollToNewMessage() {
        DispatchQueue.main.async {
            let section = self.tableView.numberOfSections
            let row = self.tableView.numberOfRows(inSection: section - 1)

            if section <= 0 || row <= 0 {
                return
            }

            let indexPath = IndexPath(row: row - 1 , section: section - 1)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

extension ChatViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        viewModel.inputText = textView.text
        viewModel.inputTextChanged()

        let maxHeight = CGFloat(100)
        if textView.frame.size.height < maxHeight {
            let size = textView.sizeThatFits(textView.frame.size)
            textViewHeightConstraint.constant = size.height
        }
    }
}

