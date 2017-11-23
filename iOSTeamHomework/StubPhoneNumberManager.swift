//
//  StubPhoneNumberManager.swift
//  iOSTeamHomework
//
//  Created by 曾國翰 on 2017/11/23.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import Foundation

class StubPhoneNumberManager: PhoneNumberInteractor {
    static let sharedInstance = StubPhoneNumberManager()
    var numbers: [NumberData] = [
        NumberData(code: 1, number: 111),
        NumberData(code: 1, number: 222),
        NumberData(code: 1, number: 333),
        NumberData(code: 2, number: 111),
        NumberData(code: 2, number: 222),
        NumberData(code: 2, number: 333),
        NumberData(code: 3, number: 111),
        NumberData(code: 3, number: 222),
        NumberData(code: 3, number: 333)
    ] {
        didSet {
            NotificationCenter.default.post(name: .dataChangedNotification, object: nil)
        }
    }
    func load() {}
    func save() {}
    
    func reset() {
        numbers = [
        NumberData(code: 1, number: 111),
        NumberData(code: 1, number: 222),
        NumberData(code: 1, number: 333),
        NumberData(code: 2, number: 111),
        NumberData(code: 2, number: 222),
        NumberData(code: 2, number: 333),
        NumberData(code: 3, number: 111),
        NumberData(code: 3, number: 222),
        NumberData(code: 3, number: 333)
        ]
    }
}
