//
//  AddPhoneNumberViewModel.swift
//  iOSTeamHomework
//
//  Created by 曾國翰 on 2017/11/22.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

class AddPhoneNumberViewModel {
    let code = MutableProperty<Int?>(nil)
    let number = MutableProperty<Int?>(nil)
    
    lazy var isExistedProducer: SignalProducer<Bool, NoError> = self.code.producer.combineLatest(with: self.number.producer).map({ (values) -> Bool in
        guard let code = values.0,
            let number = values.1 else {
                return false
        }
        let numberData = PhoneNumberManager.NumberData(code: code, number: number)
        return PhoneNumberManager.sharedInstance.checkExisted(numberData)
    })
    
    lazy var isEnableProducer: SignalProducer<Bool, NoError> = self.code.producer.combineLatest(with: self.number.producer).map({ (values) -> Bool in
        guard let code = values.0,
            let number = values.1 else {
                return false
        }
        let numberData = PhoneNumberManager.NumberData(code: code, number: number)
        return !PhoneNumberManager.sharedInstance.checkExisted(numberData)
    })
}
