//
//  Network.swift
//  YieldManagerExample
//
//  Created by Daniel Funes on 26/09/2018.
//  Copyright © 2018 Nektria. All rights reserved.
//

import Foundation
import YieldManager

class Network {
    static var shared = Network()
    
    var apiKey: String? = "123456"
    var apiUrl: String? = "http://localhost:92/api/v1"
    var timeout: Double = 1000
    
    func sendLocation(address: String, postalCode: String, elevator: Bool, completion: @escaping RequestCompletionBlock) -> Void {
        Client.shared.apiKey = apiKey
        Client.shared.baseUrl = apiUrl
        Client.shared.timeOut = timeout
        
        let request = CreateLocationRequest(
            address: address,
            postalCode: postalCode,
            elevator: elevator
        )
        
        Client.shared.create(with: request) { (response, error) in
            completion(response, error)
        }
    }
    
    func retrieveGrid(address: String, postalCode: String, elevator: Bool, weight: Int, startTime: String, endtime: String, productLines: Int?, completion: @escaping RetrieveGridRequestCompletionBlock) -> Void {
        Client.shared.apiKey = apiKey
        Client.shared.baseUrl = apiUrl
        Client.shared.timeOut = timeout
        
        let request = RetrieveGridRequest(
            address: address,
            postalCode: postalCode,
            elevator: elevator,
            weight: weight,
            startTime: startTime,
            endTime: endtime,
            productLines: productLines
        )
        
        Client.shared.retrieveGrid(with: request) { (response, error) in
            completion(response, error)
        }
    }
}
