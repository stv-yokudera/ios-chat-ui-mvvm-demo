//
//  Observable.swift
//  ios-chat-ui-mvvm-demo
//
//  Created by OkuderaYuki on 2018/02/21.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case invalidKeyPath(AnyKeyPath)
}

protocol Observable {

    func observe<Value1, Target: AnyObject, Value2>(keyPath keyPath1: ReferenceWritableKeyPath<Self, Value1>,
                                                    on queue: OperationQueue?,
                                                    bindTo target: Target,
                                                    _ keyPath2: ReferenceWritableKeyPath<Target, Value2>) throws
}
