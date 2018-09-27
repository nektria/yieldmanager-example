///
/// This file is part of the YieldManager package.
///
/// For the full copyright and license information, please view the LICENSE
/// file that was distributed with this source code.
///

import Foundation

/**
 Closure used on finish an api request.
 
 - parameter response: Response from the api.
 - parameter error: Error when request has not finished correctly.
*/
public typealias RequestCompletionBlock = (_ response: Response?,_ error: Error?) -> Void

public class Client {
    /*
     Static instance of this client.
    */
    public static let shared = Client()
    
    /**
     Http session.
    */
    var session: URLSession
    
    /**
     Used to authenticate all api requests. (mandatory)
    */
    public var apiKey: String?
    
    /**
     Timeout in miliseconds for api requests. Default value: 1000.
     */
    private var _timeOut: Double = 1000
    
    /**
     Timeout in miliseconds for api requests. Default value: 1000.
    */
    public var timeOut: Double {
        set {
            _timeOut = newValue
            configureSession()
        }
        get {
            return _timeOut
        }
    }
    
    /**
     Api base url.
    */
    public var baseUrl: String?
    
    /**
     Client initializer.
     
     - parameter session: Http session.
    */
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /**
     Instantiates the http session with the current timeout.
    */
    private func configureSession() -> Void {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        configuration.timeoutIntervalForResource = TimeInterval(timeOut)
        session = URLSession(configuration: configuration)
    }
}

extension Client {
    /**
     Sends a request to the YM API.
     
     - parameter method: Method to be used. [POST, PUT, PATCH or GET]
     - parameter path: Endpoint path
     - parameter resource: Resource to be sent to the API (if applies)
     - parameter completion: Closure called on request finish.
    */
    internal func request(
        method: String,
        path: String,
        resource: Data? = nil,
        completion: @escaping RequestCompletionBlock
    ) -> Void {
        guard apiKey != nil else {
            return completion(nil, NSError(domain: "", code: 400, userInfo: nil))
        }
        
        let endpoint = URL(string: baseUrl! + path)
        
        var request = URLRequest(url: endpoint!)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "X-API-ID")
        request.httpBody = resource
        
        let task = session.dataTask(with: request) {
            data, response, error in
            
            var responseCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                responseCode = httpResponse.statusCode
            }
            
            var responseBody = ""
            if let data = data {
                responseBody = String(bytes: data, encoding: .utf8)!
            }
            completion(self.buildResponse(responseBody: responseBody, statusCode: responseCode), error)
        }
        task.resume()
    }

    /**
     Builds the response including the time windows received from the API.

     - parameter response: Response from the request.
     */
    private func buildResponse(responseBody: String, statusCode: Int) -> Response {
        let decoder = JSONDecoder()
        guard let jsonData = responseBody.data(using: .utf8) else {
            return Response(message: responseBody, statusCode: statusCode)
        }

        let response: Response
        do {
            response = try decoder.decode(Response.self, from: jsonData)
        } catch {
            return Response(message: responseBody, statusCode: statusCode)
        }

        response.statusCode = statusCode

        return response
    }
}
