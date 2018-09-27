//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

public struct Coordinates: Encodable {
    var latitude: Double
    var longitude: Double
}

struct Location: Encodable {
    /**
     Postal address where the order has to be sent.
    */
    public var address: String
    
    /**
     Postal code.
    */
    public var postalCode: String
    
    /**
     Indicates if the building has elevator.
    */
    public var elevator: Bool
    
    /**
     Coordinates of the location (Optional)
    */
    public var coordinates: Coordinates?
}

/**
 Request to retrieve a grid with a list of time windows for a specific order and time range.
*/
public struct RetrieveGridRequest: Encodable {
    /**
     Order location
    */
    var location: Location
    
    /**
     Order weight in grams.
    */
    public var weight: Int
    
    /**
     Time range of the first time window between the last time window.
    */
    public var timeRange: TimeRange
    
    /**
     It initializes the request with all required parameters.
     
     - parameter address: Postal address where the order has to be sent.
     - parameter postalCode: Postal code.
     - parameter elevator: Indicates if the building has elevator.
     - parameter weight: Order weight in grams.
     - parameter startTime: Date of the first time window. Format: yyyy/MM/dd HH:mm
     - parameter endTime: Date of the last time window. Format: yyyy/MM/dd HH:mm
     
     Example:
     ```
     let request = RetrieveGridRequest(
        address: "Avda. Diagonal 440, Barcelona",
        postalCode: "08037",
        elevator: true,
        startTime: "2018/09/17 08:00",
        endTime: "2018/09/24 20:00",
        coordinates: Coordinates(latitude: 41.38809, longitude: 2.12639)
     )
     ```
    */
    public init(
        address: String,
        postalCode: String,
        elevator: Bool,
        weight: Int,
        startTime: String,
        endTime: String,
        coordinates: Coordinates? = nil
    ) {
        self.location = Location(address: address, postalCode: postalCode, elevator: elevator, coordinates: coordinates)
        self.weight = weight
        self.timeRange = TimeRange(startTime: startTime, endTime: endTime)
    }
}
