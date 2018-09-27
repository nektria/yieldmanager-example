//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

/**
 List of time windows.
 */
public class TimeWindowList: Equatable {
    /**
     Elements of the list
    */
    public let items: [TimeWindow]
    
    /**
     List initializer.

     - parameter timeWindows: Elements of the list.
    */
    init(timeWindows:[TimeWindow] ) {
        self.items = timeWindows
    }
    
    /**
     Compares two time window lists.
    */
    public static func == (lhs: TimeWindowList, rhs: TimeWindowList) -> Bool {
        return lhs.items == rhs.items
    }
    
    /**
     Filters the current list by the given state and returns a new instance.
    */
    public func filter(by state: TimeWindowState) -> TimeWindowList {
        var list: [TimeWindow] = []
        for timeWindow in items {
            if timeWindow.state == state.rawValue {
                list.append(timeWindow)
            }
        }
        return TimeWindowList(timeWindows: list)
    }
}

/**
 Extension for sequence.
*/
extension TimeWindowList: Sequence {
    public func makeIterator() -> Array<TimeWindow>.Iterator {
        return items.makeIterator()
    }
}
