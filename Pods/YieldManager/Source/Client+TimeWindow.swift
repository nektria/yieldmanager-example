//
// This file is part of the YieldManager package.
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import Foundation

/**
 Closure used on finish an api request.
 
 - parameter response: Response from the api.
 - parameter error: Error when request has not finished correctly.
 */
public typealias RetrieveGridRequestCompletionBlock = (_ response: RetrieveGridResponse?,_ error: Error?) -> Void

extension Client {
    /**
     Generates a list of time windows for the given order.
     
     - parameter with: request to generate time windows
     - parameter completion: Closure called on request finish.
     
     Example:
     ```
         Client.shared.baseUrl = "https://nektria.com/api/v1"
         Client.shared.apiId = "your-api-key"
     
         let request = RetrieveGridRequest(
            address: "Avda Diagonal 440",
            postalCode: "08015",
            elevator: true
            weight: 10000,
            startTime: "2018-09-20 08:00",
            endTime: "2018-09-27 22:00"
         )
     
         Client.shared.retrieveGrid(with: request) { (response, error) in
            // ...
         }
     ```
    */
    public func retrieveGrid(with request: RetrieveGridRequest, completion: @escaping RetrieveGridRequestCompletionBlock) -> Void {
        let jsonEncoder = JSONEncoder()
        let body = try! jsonEncoder.encode(request)
        
        self.request(method: "POST", path: "/time-windows/generate", resource: body) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard response != nil else {
                completion(nil, error)
                return
            }
            
            completion(self.buildResponse(response: response!), error)
        }
    }
    
    /**
     Builds the response including the time windows received from the API.
     
     - parameter response: Response from the request.
    */
    private func buildResponse(response: Response) -> RetrieveGridResponse? {
        let decoder = JSONDecoder()
        let jsonData = response.message.data(using: .utf8)
        
        if !response.isSuccess() || jsonData == nil {
            return RetrieveGridResponse(
                message: response.message,
                statusCode: response.statusCode!
            )
        }
        
        var timeWindows: [TimeWindow] = []
        timeWindows = try! decoder.decode( [TimeWindow].self, from: jsonData!)
        
        return RetrieveGridResponse(
            message: response.message,
            statusCode: response.statusCode!,
            timeWindows: TimeWindowList(timeWindows: timeWindows)
        )
    }
}
