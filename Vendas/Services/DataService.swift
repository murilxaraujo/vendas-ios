//
//  DataService.swift
//  Vendas
//
//  Created by Murilo Araujo on 11/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

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
        return [Client()]
    }
    
    fileprivate func getClientsFromRealDB() -> [Client] {
        let clients = realm.objects(Client.self)
        return Array(clients.sorted(byKeyPath: "name"))
    }
    
}
