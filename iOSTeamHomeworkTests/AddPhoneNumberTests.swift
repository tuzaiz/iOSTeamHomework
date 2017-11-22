//
//  AddPhoneNumberTests.swift
//  iOSTeamHomeworkTests
//
//  Created by 曾國翰 on 2017/11/22.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import XCTest
@testable import iOSTeamHomework
class AddPhoneNumberTests: XCTestCase {
    
    var viewModel: AddPhoneNumberViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = AddPhoneNumberViewModel()
        PhoneNumberManager.sharedInstance.add(PhoneNumberManager.NumberData(code: 1, number: 11111111))
        PhoneNumberManager.sharedInstance.add(PhoneNumberManager.NumberData(code: 1, number: 22222222))
    }
    
    override func tearDown() {
        viewModel = nil
        PhoneNumberManager.sharedInstance.clear()
        super.tearDown()
    }
    
    func testDataValidation() {
        XCTAssertFalse(viewModel.isEnabled.value)
        XCTAssertFalse(viewModel.isExisted.value)
        
        viewModel.code.value = 2
        viewModel.number.value = 187361298
        XCTAssertTrue(viewModel.isEnabled.value)
        XCTAssertFalse(viewModel.isExisted.value)
        
        viewModel.code.value = 1
        viewModel.number.value = 11111111
        XCTAssertFalse(viewModel.isEnabled.value)
        XCTAssertTrue(viewModel.isExisted.value)
    }
    
    func testBinding() {
        let viewController = AddPhoneNumberViewController()
        viewController.numberExistedLabel = UILabel()
        viewController.saveButton = UIBarButtonItem()
        viewController.areaCodeField = UITextField()
        viewController.phoneNumberField = UITextField()
        viewController.viewModel = viewModel
        viewController.viewDidLoad()
        
        viewModel.isExisted.value = true
        XCTAssertFalse(viewController.numberExistedLabel.isHidden)
        
        viewModel.isExisted.value = false
        XCTAssertTrue(viewController.numberExistedLabel.isHidden)
        
        viewModel.isEnabled.value = false
        XCTAssertFalse(viewController.saveButton.isEnabled)
        
        viewModel.isEnabled.value = true
        XCTAssertTrue(viewController.saveButton.isEnabled)
    }
    
}
