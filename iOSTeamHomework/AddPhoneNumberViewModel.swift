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
    enum InteractionError: Error {
        case missingRequired
    }
    
    var phoneNumberManager: PhoneNumberInteractor = PhoneNumberManager.sharedInstance
    
    let code = MutableProperty<Int?>(nil)
    let number = MutableProperty<Int?>(nil)
    
    let isExisted: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    let isEnabled: MutableProperty<Bool> = MutableProperty<Bool>(false)
    
    init() {
        if let _ = ProcessInfo.processInfo.environment["-FakedData"] {
            phoneNumberManager = StubPhoneNumberManager.sharedInstance
        }
        bindData()
    }
    
    private func bindData() {
        isExisted <~ code.producer.combineLatest(with: number.producer).map({ (values) -> Bool in
            guard let code = values.0,
                let number = values.1 else {
                    return false
            }
            let numberData = NumberData(code: code, number: number)
            return self.phoneNumberManager.checkExisted(numberData)
        })
        
        isEnabled <~ code.producer.combineLatest(with: number.producer).map({ (values) -> Bool in
            guard let code = values.0,
                let number = values.1 else {
                    return false
            }
            let numberData = NumberData(code: code, number: number)
            return !self.phoneNumberManager.checkExisted(numberData)
        })
    }
    
    func save() throws {
        guard let code = code.value, let number = number.value else {
            throw InteractionError.missingRequired
        }
        let numberData = NumberData(code: code, number: number)
        phoneNumberManager.add(numberData)
    }
}
