//
//  AddPhoneNumberViewController.swift
//  iOSTeamHomework
//
//  Created by 曾國翰 on 2017/11/22.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class AddPhoneNumberViewController: UIViewController {

    @IBOutlet var areaCodeField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var numberExistedLabel: UILabel!
    
    var viewModel: AddPhoneNumberViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.code <~ areaCodeField.reactive.continuousTextValues.map({ (code) -> Int? in
            guard let code = code else { return nil }
            return Int(code)
        })
        viewModel.number <~ phoneNumberField.reactive.continuousTextValues.map({ (code) -> Int? in
            guard let code = code else { return nil }
            return Int(code)
        })
        
        phoneNumberField.reactive.text <~ viewModel.number.map({ (number) -> String? in
            guard let number = number else { return nil }
            return String(number)
        })
        areaCodeField.reactive.text <~ viewModel.code.map({ (code) -> String? in
            guard let code = code else { return nil }
            return String(code)
        })
        
        saveButton.reactive.isEnabled <~ viewModel.isEnabled
        numberExistedLabel.reactive.isHidden <~ viewModel.isExisted.map({ (existed) -> Bool in
            return !existed
        })
    }
    
}

extension AddPhoneNumberViewController {
    @IBAction func saveButtonTapped() {
        do {
            try viewModel.save()
            self.navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            preconditionFailure()
        }
    }
    
    @IBAction func cancelButtonTapped() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
