//
//  PhoneNumberTableViewController.swift
//  iOSTeamHomework
//
//  Created by willsbor Kang on 2017/9/16.
//  Copyright © 2017年 gogolook. All rights reserved.
//

import UIKit

class PhoneNumberTableViewController: UITableViewController {

    var phoneNumberManager: PhoneNumberInteractor = PhoneNumberManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = ProcessInfo.processInfo.environment["-FakedData"] {
            phoneNumberManager = StubPhoneNumberManager.sharedInstance
        }
        NotificationCenter.default.addObserver(self, selector: #selector(dataChanged), name: .dataChangedNotification, object: nil)
    }
    
    @IBAction func savePhoneNumbers() {
        phoneNumberManager.save()
    }
    
    @objc func dataChanged() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let viewController = nav.childViewControllers.first as? AddPhoneNumberViewController {
            viewController.viewModel = AddPhoneNumberViewModel()
        }
    }

}

extension PhoneNumberTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return phoneNumberManager.getCodes().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let code = phoneNumberManager.getCodes()[section]
        return phoneNumberManager.getNumbers(for: code).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let code = phoneNumberManager.getCodes()[section]
        return "\(code)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)

        let code = phoneNumberManager.getCodes()[indexPath.section]
        let data = phoneNumberManager.getNumbers(for: code)[indexPath.row]
        
        cell.textLabel?.text = "\(data.number)"
        cell.detailTextLabel?.text = "\(data.code) \(data.number)"

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let code = phoneNumberManager.getCodes()[indexPath.section]
            let data = phoneNumberManager.getNumbers(for: code)[indexPath.row]
            phoneNumberManager.remove(data)
        }
    }
}
