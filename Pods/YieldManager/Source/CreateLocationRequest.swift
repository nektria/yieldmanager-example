//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

public struct CreateLocationRequest: Encodable {
    /**
     A postal address. Example: Avda. Diagonal 440, Barcelona
    */
    public let address: String
    
    /**
     A postal code: Example: 08100
    */
    public let postalCode: String
    
    /**
     Indicates if the building has elevator.
    */
    public let elevator: Bool
    
    /**
     Initializes a YMLocation with the required parameters.
     
     - parameter address: A postal address. Example: Avda. Diagonal 440, Barcelona
     - parameter postalCode: A postal code: Example: 08100
     - parameter elevator: Indicates if the building has elevator
    */
    public init(address: String, postalCode: String, elevator: Bool) {
        self.address = address
        self.postalCode = postalCode
        self.elevator = elevator
    }
}
