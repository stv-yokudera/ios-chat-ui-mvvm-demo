//
//  UITableView+Touch.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/23.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

extension UITableView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}
