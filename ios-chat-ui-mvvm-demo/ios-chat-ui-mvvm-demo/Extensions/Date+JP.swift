//
//  Date+JP.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/23.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

extension Date {

    func now() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: formatter.string(from:self))!
    }
}
