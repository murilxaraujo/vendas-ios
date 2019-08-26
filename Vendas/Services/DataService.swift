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
import HandyJSON
import PromiseKit

class DataService {
    
    struct ProdutosForParse: Decodable {
        
    }
    
    struct ClientsForParse: Decodable {
        
    }
    
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
        let url = URL(string: "http://189.112.124.67:8013/REST/clientes_pv")
        Alamofire.request(url!, method: HTTPMethod.get).responseJSON { (response) in
            if let data = response.data {
                
            }
            
        }
        
        return []
    }
    
    fileprivate func getClientsFromRealDB() -> [Client] {
        let clients = realm.objects(Client.self)
        return Array(clients.sorted(byKeyPath: "name"))
    }
    
    // MARK: - Produtos functions
    
    func getProdutos() -> [Product] {
        if NetworkService.shared.networkIsAvailable() {
            return getProductsFromDB()
        } else {
            return getProductsFromDB()
        }
    }
    
    fileprivate func getProductsFromCloud() -> [Product] {
        guard let url = URL(string: "http://189.112.124.67:8013/PRODUTOS_PV") else { return [] }
        var products: [Product] = []
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            let dataAsString = String(data: data, encoding: .utf8)
            
            print(dataAsString)
        }
        
        return products
    }
    
    fileprivate func getProductsFromDB() -> [Product] {
        let products = realm.objects(Product.self)
        return Array(products.sorted(byKeyPath: "nome"))
    }
    
    // MARK: - Get transportadoras functions
    
    fileprivate func getTransportadorasFromDB() -> [Transportadora] {
        let transportadoras = realm.objects(Transportadora.self)
        return Array(transportadoras.sorted(byKeyPath: "nome"))
    }
    
    // MARK: - Get condições de pagametno functions
    
    fileprivate func getCondsPagamentoFromDB() -> [CondicaoDePagamento] {
        let condspagamento = realm.objects(CondicaoDePagamento.self)
        return Array(condspagamento.sorted(byKeyPath: "descricao"))
    }
    
    // MARK: - Support Classes
    
    struct clientsJsonBasicTypes: HandyJSON {
        var nome: String = ""
    }
    
    func getRealmPath() {
        print(realm.configuration.fileURL)
    }
    
}
