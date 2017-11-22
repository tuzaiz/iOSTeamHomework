//
//  PhoneNumberManagerTests.swift
//  iOSTeamHomeworkTests
//
//  Created by 曾國翰 on 2017/11/22.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import XCTest
@testable import iOSTeamHomework
class PhoneNumberManagerTests: XCTestCase {
    
    var manager: PhoneNumberManager!
    
    override func setUp() {
        super.setUp()
        manager = PhoneNumberManager()
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }
    
    func testAdding() {
        let expect = expectation(description: "WaitForNotification")
        NotificationCenter.default.addObserver(forName: PhoneNumberManager.dataChangedNotification, object: nil, queue: nil) { (_) in
            expect.fulfill()
        }
        
        XCTAssertEqual(manager.numbers.count, 0)
        let number = PhoneNumberManager.NumberData(code: 1, number: 111)
        manager.add(number)
        XCTAssertEqual(manager.numbers.count, 1)
        XCTAssertEqual(manager.numbers.first!.code, 1)
        XCTAssertEqual(manager.numbers.first!.number, 111)
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
            NotificationCenter.default.removeObserver(self, name: PhoneNumberManager.dataChangedNotification, object: nil)
        }
    }
    
    func testRemoving() {
        let defaultNumber = PhoneNumberManager.NumberData(code: 1, number: 1)
        manager.add(defaultNumber)
        
        XCTAssertEqual(manager.numbers.count, 1)
        manager.remove(defaultNumber)
        XCTAssertEqual(manager.numbers.count, 0)
    }
    
    func testGetting() {
        let number1 = PhoneNumberManager.NumberData(code: 1, number: 111)
        let number2 = PhoneNumberManager.NumberData(code: 2, number: 111)
        let number3 = PhoneNumberManager.NumberData(code: 1, number: 222)
        manager.add(number1)
        manager.add(number2)
        manager.add(number3)
        
        XCTAssertEqual(manager.getCodes().count, 2)
        let code1 = manager.getCodes()[0]
        XCTAssertEqual(code1, 1)
        let code2 = manager.getCodes()[1]
        XCTAssertEqual(code2, 2)
        let numbers1 = manager.getNumbers(for: code1)
        XCTAssertEqual(numbers1.count, 2)
        XCTAssertEqual(numbers1.first!.number, 111)
        XCTAssertEqual(numbers1.last!.number, 222)
        let numbers2 = manager.getNumbers(for: code2)
        XCTAssertEqual(numbers2.count, 1)
        XCTAssertEqual(numbers2.first!.number, 111)
    }
    
    func testChecking() {
        let number1 = PhoneNumberManager.NumberData(code: 1, number: 111)
        let number2 = PhoneNumberManager.NumberData(code: 2, number: 111)
        let number3 = PhoneNumberManager.NumberData(code: 1, number: 222)
        manager.add(number1)
        manager.add(number2)
        manager.add(number3)
        
        let number4 = PhoneNumberManager.NumberData(code: 3, number: 111)
        XCTAssertTrue(manager.checkExisted(number2))
        XCTAssertFalse(manager.checkExisted(number4))
    }
    
}
