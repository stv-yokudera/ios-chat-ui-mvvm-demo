//
//  Date+DateFormat.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension Date {

    func dateStyleHHMM() -> String {

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)

        if let hour = components.hour, let minite = components.minute {
            return String(format: "%02d:%02d",hour, minite)
        }
        return ""
    }
}
