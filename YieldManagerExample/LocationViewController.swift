//
//  FirstViewController.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import UIKit
import Eureka
import YieldManager
import SVProgressHUD

class LocationViewController: FormViewController {
    
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
    }
    
    func checkForm()  {
        let address = form.rowBy(tag: "address")?.baseValue
        let postalCode = form.rowBy(tag: "postalCode")?.baseValue
        let elevator = form.rowBy(tag: "elevator")?.baseValue
        sendButton.isEnabled = address != nil && postalCode != nil && elevator != nil
    }
    
    @IBAction func sendLocation(_ sender: UIBarButtonItem) {
        let addressRow: TextRow? = form.rowBy(tag: "address")
        let postalCodeRow: TextRow? = form.rowBy(tag: "postalCode")
        let elevatorRow: SwitchRow? = form.rowBy(tag: "elevator")

        SVProgressHUD.show()
        
        Network.shared.sendLocation(
            address: (addressRow?.value)!,
            postalCode: (postalCodeRow?.value)!,
            elevator: ((elevatorRow?.value) != nil)
        ) { (response, error) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async(execute: {
                var title = ""
                var message = ""
                if let error = error {
                    title = "Error"
                    message = error.localizedDescription
                }
                if let _ = response {
                    title = "Status code: \((response?.statusCode)!)"
                    message = (response?.message)!
                }
                self.showAlert(title: title, message: message)
            })
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

