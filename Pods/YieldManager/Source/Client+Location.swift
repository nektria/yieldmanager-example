//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

extension Client {
    /**
     Puts a location to the yield manager system.
     It is used to pre-calculate the GPS of a location.
     
     - parameter with: Request with all parameters.
     - parameter completion: Closure called on request finish.
     
     ## How to use ##
     ````
        Client.shared.baseUrl = url
        Client.shared.apiKey = apiKey
        Client.timeout = 1000 // opcional
     
        let request = CreateLocationRequest(
            address: "Avda Diagonal 440",
            postalCode: "08015",
            elevator: true
        }
     
        Client.shared.create(with: request) { (response, error) in
            // ...
        }
     ````
    */
    public func create(with request: CreateLocationRequest, completion: @escaping RequestCompletionBlock) {
        let jsonEncoder = JSONEncoder()
        let body = try! jsonEncoder.encode(request)
        
        self.request(method: "POST", path: "/locations", resource: body) { (response: Response?, error: Error?) in
            completion(response, error)
        }
    }
}
