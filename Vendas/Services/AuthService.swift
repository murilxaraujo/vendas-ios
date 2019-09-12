//
//  AuthService.swift
//  Vendas
//
//  Created by Murilo Araujo on 09/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar
import Just

class AuthService {
    
    static let shared = AuthService()
    
    let url: URL! = URL(string: "http://189.112.124.67:8013/login_pv")!
    //let url: URL! = URL(string: "https://en0beqomb5f2av.x.pipedream.net")!

    let defaults = UserDefaults.standard
    
    func authenticate(username: String, password: String) throws -> User {
        
        let authenticatedUser: User?
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let jsonDic: [String: Any] = ["NOME": username, "SENHA": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let semaphone = DispatchSemaphore(value: 0)
        

        let task = URLSession.shared.dataTask(with: request) {
            (datain, responsein, errorin) in
            data = datain
            response = responsein
            error = errorin
            
            semaphone.signal()
        }
        
        task.resume()
        
        _ = semaphone.wait(timeout: .distantFuture)
        
        if error != nil {
            disableSavedCredentials()
            print("Erro é diferente de nil")
            throw error!
        }
        
        if data == nil {
            disableSavedCredentials()
            print("Erro: Data é nil")
            throw LoginError.notAttachedSeller
        }
        
        if response == nil {
            disableSavedCredentials()
            print("Erro: response é nil")
            throw LoginError.userNotFound
        }
        
        var json: NSDictionary?
        
        do {
            print("Data", data)
            json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary ?? nil
            print("JSON:", json)
        } catch {
            disableSavedCredentials()
            print("Erro na serializacao")
            throw LoginError.networkError
        }
        
        if json == nil {
            disableSavedCredentials()
            print("Erro json é nil")
            throw LoginError.networkError
        }
        
        if json!["0"] != nil {
            disableSavedCredentials()
            print("Erro nao encontrado")
            throw LoginError.userNotFound
        }
        
        if json!["2"] != nil {
            disableSavedCredentials()
            print("Erro usuario bloqueado")
            throw LoginError.blockedUser
        }
        
        if json!["3"] != nil {
            disableSavedCredentials()
            print("Erro sem vendedor")
            throw LoginError.notAttachedSeller
        }
        
        if json!["4"] != nil {
            disableSavedCredentials()
            print("Erro senha incorreta")
            throw LoginError.wrongPassword
        }
        
        if json!["1"] == nil {
            disableSavedCredentials()
            print("Erro objeto usuário é nil")
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
