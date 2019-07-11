//
//  AuthService.swift
//  Vendas
//
//  Created by Murilo Araujo on 09/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation

class AuthService {
    
    static let shared = AuthService()
    
    let url: URL! = URL(string: "")
    
    let defaults = UserDefaults.standard
    
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
        
        if error != nil {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        if data == nil {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        if response == nil {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        var json: NSDictionary?
        
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary ?? nil
        } catch {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        if json == nil {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        if json!["0"] != nil {
            disableSavedCredentials()
            throw LoginError.userNotFound
        }
        
        if json!["2"] != nil {
            disableSavedCredentials()
            throw LoginError.blockedUser
        }
        
        if json!["3"] != nil {
            disableSavedCredentials()
            throw LoginError.notAttachedSeller
        }
        
        if json!["4"] != nil {
            disableSavedCredentials()
            throw LoginError.wrongPassword
        }
        
        if json!["1"] == nil {
            disableSavedCredentials()
            throw LoginError.networkError
        }
        
        authenticatedUser = User(id: json!["1"] as! String)
        
        return authenticatedUser!
    }
    
    func hasSavedLoginCredentials() -> Bool {
        return defaults.bool(forKey: "hasSavedCredentials")
    }
    
    func saveLoginCredentials(username: String, password: String) {
        defaults.set(true, forKey: "hasSavedCredentials")
        defaults.set(username,forKey: "username")
        defaults.set(password, forKey: "batata")
    }
    
    func disableSavedCredentials() {
        defaults.set(false, forKey: "hasSavedCredentials")
    }
    
    func getSavedUsername() -> String {
        return defaults.string(forKey: "username")!
    }
    
    func getSavedPassword() -> String {
        return defaults.string(forKey: "batata")!
    }
    
    func saveUserID(id: String) {
       defaults.set(id, forKey: "userID")
    }
    
    func getSavedUserID() -> String? {
        return defaults.string(forKey: "userID") ?? nil
    }
    
}
