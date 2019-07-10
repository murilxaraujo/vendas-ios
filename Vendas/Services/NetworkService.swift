//
//  NetworkService.swift
//  Vendas
//
//  Created by Murilo Araujo on 03/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkService {
    let network: NetworkManager = NetworkManager.sharedInstance
    
    enum NetworkServiceErrors: Error {
        case valueisNil
    }
    
    func isNetworkAvailable() throws -> Bool {
        var value: Bool?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        NetworkManager.isReachable { (manager) in
            value = true
            semaphore.signal()
        }
        
        NetworkManager.isUnreachable { (manager) in
            value = false
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if value == nil {
            throw NetworkServiceErrors.valueisNil
        }
        
        return value!
    }
}
