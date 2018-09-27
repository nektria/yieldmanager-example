//
//  SettingsViewController.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< TextRow() { row in
                row.title = "Api url"
                row.placeholder = "https://www.example.com/api/v1"
                row.value = "http://localhost:92/api/v1"
                
            }.cellUpdate({ (cell, row) in
                Network.shared.apiUrl = cell.textField.text
            })
            <<< TextRow() { row in
                row.title = "Api key"
                row.placeholder = "12345"
                row.value = "123456"
            }.cellUpdate({ (cell, row) in
                Network.shared.apiKey = cell.textField.text
            })
            <<< IntRow() { row in
                row.title = "Timeout"
                row.placeholder = "1000"
                row.value = 1000
            }.cellUpdate({ (cell, row) in
                if let value = row.value {
                    Network.shared.timeout = Double(exactly: value)!
                }
            })
    }

}
