//
//  String+DateFormat.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension String {

    func toDate(dateFormat: String) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.date(from: self)!
    }
}
