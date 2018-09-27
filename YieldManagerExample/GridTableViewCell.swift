//
//  GridTableViewCell.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import UIKit
import YieldManager

class GridTableViewCell: UITableViewCell {
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var usedCapacity: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var state: UIView!
    
    func loadTimeWindow(timeWindow: TimeWindow) -> Void {
        startTime.text = "\(timeWindow.timeRange.startTime) - \(timeWindow.timeRange.endTime)"
        usedCapacity.text = "\(timeWindow.usedCapacity) of \(timeWindow.totalCapacity)"
        name.text = timeWindow.name
        
        if timeWindow.state == TimeWindowState.open.rawValue {
            state.backgroundColor = UIColor.green
        } else {
            state.backgroundColor = UIColor.red
        }
    }
}
