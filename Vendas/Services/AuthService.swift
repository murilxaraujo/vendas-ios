//
//  AuthService.swift
//  Vendas
//
//  Created by Murilo Araujo on 09/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation

class AuthService {
    
    let url: URL! = URL(string: "")
    
    let shared = AuthService()
    
    enum LoginError: Error {
        case userNotFound
        case blockedUser
        case notAttachedSeller
        case wrongPassword
        case networkError
    }
    
    func authenticate(username: String, password: String) throws -> User {
        let session = URLSession.shared
        let authenticatedUser: User?
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphone = DispatchSemaphore(value: 0)
        
        session.dataTask(with: url) { (datad, urlresponse, errord) in
            data = datad
            response = urlresponse
            error = errord
            
            semaphone.signal()
        }.resume()
        
        _ = semaphone.wait(timeout: .distantFuture)
        
        if error == nil {
            throw LoginError.networkError
        }
        
        if data == nil {
            throw LoginError.networkError
        }
        
        if response == nil {
            throw LoginError.networkError
        }
        
        var json: NSDictionary?
        
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary ?? nil
        } catch {
            throw LoginError.networkError
        }
        
        if json == nil {
            throw LoginError.networkError
        }
        
        if json!["0"] != nil {
            throw LoginError.userNotFound
        }
        
        if json!["2"] != nil {
            throw LoginError.blockedUser
        }
        
        if json!["3"] != nil {
            throw LoginError.notAttachedSeller
        }
        
        if json!["4"] != nil {
            throw LoginError.wrongPassword
        }
        
        if json!["1"] == nil {
            throw LoginError.networkError
        }
        
        authenticatedUser = User(id: json!["1"] as! String)
        
        return authenticatedUser!
    }
    
}
