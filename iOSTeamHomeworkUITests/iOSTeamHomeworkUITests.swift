//
//  iOSTeamHomeworkUITests.swift
//  iOSTeamHomeworkUITests
//
//  Created by willsbor Kang on 2017/9/16.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import XCTest
@testable import iOSTeamHomework

class iOSTeamHomeworkUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testAdd() {
        let app = XCUIApplication()
        app.launchEnvironment["-FakedData"] = "Y"
        app.launch()
        let addButton = app.navigationBars["Phone Numbers"].buttons["Add"]
        addButton.tap()
        
        let codeTextField = app.textFields["Code"]
        codeTextField.tap()
        codeTextField.typeText("123")
        
        let phoneNumberTextField = app.textFields["Phone Number"]
        phoneNumberTextField.tap()
        phoneNumberTextField.typeText("123456")
        
        let saveButton = app.navigationBars["iOSTeamHomework.AddPhoneNumberView"].buttons["Save"]
        saveButton.tap()
        
        addButton.tap()
        codeTextField.tap()
        codeTextField.typeText("123")
        phoneNumberTextField.tap()
        phoneNumberTextField.typeText("123456")
        XCTAssertTrue(app.staticTexts["This number is already existed."].exists)
        
        phoneNumberTextField.typeText("654321")
        XCTAssertFalse(app.staticTexts["This number is already existed."].exists)
        
        saveButton.tap()
        
        XCTAssertEqual(app.tables.cells.count, 2)
    }
    
    func testCancelAdding() {
        let app = XCUIApplication()
        let addButton = app.navigationBars["Phone Numbers"].buttons["Add"]
        addButton.tap()
        
        let cancelButton = app.navigationBars["iOSTeamHomework.AddPhoneNumberView"].buttons["Cancel"]
        cancelButton.tap()
    }
    
}
