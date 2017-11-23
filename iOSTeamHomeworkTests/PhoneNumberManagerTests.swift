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
        XCTAssertEqual(manager.numbers.count, 0)
        let number = NumberData(code: 1, number: 111)
        manager.add(number)
        XCTAssertEqual(manager.numbers.count, 1)
        XCTAssertEqual(manager.numbers.first!.code, 1)
        XCTAssertEqual(manager.numbers.first!.number, 111)
    }
    
    func testRemoving() {
        let defaultNumber = NumberData(code: 1, number: 1)
        manager.add(defaultNumber)
        
        XCTAssertEqual(manager.numbers.count, 1)
        manager.remove(defaultNumber)
        XCTAssertEqual(manager.numbers.count, 0)
    }
    
    func testGetting() {
        let number1 = NumberData(code: 100, number: 111)
        let number2 = NumberData(code: 200, number: 111)
        let number3 = NumberData(code: 100, number: 222)
        manager.add(number1)
        manager.add(number2)
        manager.add(number3)
        
        XCTAssertEqual(manager.getCodes().count, 2)
        let code1 = manager.getCodes()[0]
        XCTAssertEqual(code1, 100)
        let code2 = manager.getCodes()[1]
        XCTAssertEqual(code2, 200)
        let numbers1 = manager.getNumbers(for: code1)
        XCTAssertEqual(numbers1.count, 2)
        XCTAssertEqual(numbers1.first!.number, 111)
        XCTAssertEqual(numbers1.last!.number, 222)
        let numbers2 = manager.getNumbers(for: code2)
        XCTAssertEqual(numbers2.count, 1)
        XCTAssertEqual(numbers2.first!.number, 111)
    }
    
    func testChecking() {
        let number1 = NumberData(code: 199, number: 111)
        let number2 = NumberData(code: 299, number: 111)
        let number3 = NumberData(code: 199, number: 222)
        manager.add(number1)
        manager.add(number2)
        manager.add(number3)
        
        let number4 = NumberData(code: 399, number: 111)
        XCTAssertTrue(manager.checkExisted(number2))
        XCTAssertFalse(manager.checkExisted(number4))
    }
    
}
