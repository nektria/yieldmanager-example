//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

public class Response: Decodable {
    /**
     Response message.
    */
    public var message: String
    
    var file: String?
    
    var line: Int?
    
    /**
     Http status code.
    */
    public var statusCode: Int?
    
    /**
     Initializer.

     - parameter message: Response message.
     - parameter statusCode: Http status code.
    */
    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }
}

extension Response {
    /*
     Checks if the response status code is success.
    */
    public func isSuccess() -> Bool {
        return statusCode != nil && statusCode! >= 200 && statusCode! < 300
    }
}
