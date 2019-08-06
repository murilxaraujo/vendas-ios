//
//  DataService.swift
//  Vendas
//
//  Created by Murilo Araujo on 11/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class DataService {
    
    // MARK: -Variables and constants
    let realm = try! Realm()
    let defaults = UserDefaults.standard
    
    // MARK: -Singleton declaration
    
    static let shared = DataService()

    // MARK: -Data backup functions
    
    func hasDownloadedData() -> Bool {
        return defaults.bool(forKey: "hasDownloadedData")
    }
    
    func setHasDownloadedData(_ downloaded: Bool) {
        defaults.set(downloaded, forKey: "hasDownloadedData")
    }
    
    // MARK: -Client functions
    
    func saveNewClient(client: NewClient) {
        if NetworkService.shared.networkIsAvailable() {
            sendNewClientToCloud(client)
        } else {
            saveNewClientToLocal(client)
        }
    }
    
    fileprivate func saveNewClientToLocal(_ client: NewClient) {
        RealmService.shared.save(client)
    }
    
    fileprivate func sendNewClientToCloud(_ client: NewClient) {
        

    }
    
    func getClients() -> [Client] {
        if NetworkService.shared.networkIsAvailable() {
            return getClientsFromCloud()
        } else {
            return getClientsFromRealDB()
        }
    }
    
    fileprivate func getClientsFromCloud() -> [Client] {
        let url = URL(string: "189.112.124.67:8013/REST/clientes_pv")
        Alamofire.request(url!, method: HTTPMethod.get).responseJSON { (response) in
            if let data = response.data {
                let json = try! JSON(data: data)
                
                
                
            }
            
        }
        
        return [Client()]
    }
    
    fileprivate func getClientsFromRealDB() -> [Client] {
        let clients = realm.objects(Client.self)
        return Array(clients.sorted(byKeyPath: "name"))
    }
    
}
