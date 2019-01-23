//
//  RetrieveGridViewController.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import UIKit
import Eureka
import YieldManager

class RetrieveGridViewController: FormViewController {
    @IBOutlet weak var sendButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section()
            <<< TextRow() { row in
                row.title = "Address"
                row.tag = "address"
                row.placeholder = "Avda diagonal 440, Barcelona"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< TextRow() { row in
                row.title = "Postal code"
                row.tag = "postalCode"
                row.placeholder = "08012"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< SwitchRow() { row in
                row.tag = "elevator"
                row.title = "Elevator"
                row.value = true
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< IntRow() { row in
                row.tag = "weight"
                row.title = "Weight"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< TextRow() { row in
                row.tag = "startTime"
                row.title = "Start time"
                row.placeholder = "2018-09-10 07:00"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< TextRow() { row in
                row.tag = "endTime"
                row.title = "End time"
                row.placeholder = "2018-09-17 20:00"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
            <<< IntRow() { row in
                row.tag = "productLines"
                row.title = "Product lines"
                row.placeholder = "10"
                }.cellUpdate({ _, _ in
                    self.checkForm()
                })
    }
    
    func checkForm()  {
        let address = form.rowBy(tag: "address")?.baseValue
        let postalCode = form.rowBy(tag: "postalCode")?.baseValue
        let elevator = form.rowBy(tag: "elevator")?.baseValue
        let weight = form.rowBy(tag: "weight")?.baseValue
        let startTime = form.rowBy(tag: "startTime")?.baseValue
        let endTime = form.rowBy(tag: "endTime")?.baseValue
        
        sendButton.isEnabled = address != nil &&
            postalCode != nil &&
            elevator != nil &&
            weight != nil &&
            startTime != nil &&
            endTime != nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GridTableTableViewController else {
            return
        }
        
        destination.address = form.rowBy(tag: "address")?.value
        destination.postalCode = form.rowBy(tag: "postalCode")?.value
        destination.elevator = form.rowBy(tag: "elevator")?.value
        destination.weight = form.rowBy(tag: "weight")?.value
        destination.startTime = form.rowBy(tag: "startTime")?.value
        destination.endTime = form.rowBy(tag: "endTime")?.value
        destination.productLines = form.rowBy(tag: "productLines")?.value
        
    }
}
