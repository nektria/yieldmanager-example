//
//  GridTableTableViewController.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import UIKit
import YieldManager
import SVProgressHUD

class GridTableTableViewController: UITableViewController {
    var _timeWindows: TimeWindowList?
    
    var timeWindows: TimeWindowList? {
        set {
            _timeWindows = newValue
            tableView.reloadData()
        }
        get {
            return _timeWindows
        }
    }
    
    var address: String?
    var postalCode: String?
    var elevator: Bool?
    var weight: Int?
    var startTime: String?
    var endTime: String?
    var productLines: Int?

    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        
        Network.shared.retrieveGrid(address: address!, postalCode: postalCode!, elevator: elevator!, weight: weight!, startTime: startTime!, endtime: endTime!, productLines: productLines) { (response, error) in
            SVProgressHUD.dismiss()
            DispatchQueue.main.async(execute: {
                if let error = error {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
                
                if let response = response, !response.isSuccess() {
                    self.showAlert(title: "Status code: \((response.statusCode)!)", message: response.message)
                }
                
                self.timeWindows = response?.timeWindows
            })
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timeWindows == nil {
            return 0
        }
        return timeWindows!.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GridTableViewCell

        let item = timeWindows?.items[indexPath.row]
        cell.loadTimeWindow(timeWindow: item!)

        return cell
    }
}
