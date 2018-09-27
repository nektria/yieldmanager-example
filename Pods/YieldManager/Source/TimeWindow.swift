//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

public enum TimeWindowState: String {
    case open = "open"
    case closed = "closed"
}

public struct TimeRange: Encodable, Decodable {
    /**
     Start time in format string: *yyyy-MM-ddTHH:mm*
     */
    public let startTime: String
    
    /**
     End time in format string: *yyyy-MM-ddTHH:mm*
     */
    public let endTime: String
}

public struct TimeWindow: Decodable, Equatable {
    /**
     Time window unique identifier.
     */
    public let id: UUID
    
    /**
     Time window's name.
     */
    public let name: String
    
    /**
     Shift unique identifier *(From YieldManager platform)*
     */
    public let shiftId: UUID
    
    /**
     Time range of the time window.
     */
    public let timeRange: TimeRange
    
    /**
     State of the time window.
     */
    public let state: String
    
    /**
     Used capacity for the time window.
     */
    public let usedCapacity: Int
    
    /**
     Total capacity of the time window.
     */
    public let totalCapacity: Int
    
    /**
     Capacity threshold of the time window which determines when the orders restrictions rules will be applied.
     */
    public let orderCapacityThreshold: Int
    
    /**
     After exceeding the previous threshold, determines the maximum capacity allowance for new orders in this time window.
     */
    public let orderMaxCapacity: Int
    
    /**
     List of postal codes where the time window serves.
     */
    public let postalCodes: [String]
    
    /**
     It compares two timewindows.
     */
    public static func == (lhs: TimeWindow, rhs: TimeWindow) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.shiftId == rhs.shiftId &&
            lhs.timeRange.startTime == rhs.timeRange.startTime &&
            lhs.timeRange.endTime == rhs.timeRange.endTime &&
            lhs.state == rhs.state &&
            lhs.usedCapacity == rhs.usedCapacity &&
            lhs.totalCapacity == rhs.totalCapacity &&
            lhs.orderCapacityThreshold == rhs.orderCapacityThreshold &&
            lhs.orderMaxCapacity == rhs.orderMaxCapacity &&
            lhs.postalCodes == rhs.postalCodes
    }
}

