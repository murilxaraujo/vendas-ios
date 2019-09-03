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
import Firebase

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
        return getClientsFromRealDB()
    }
    
    fileprivate func getClientsFromCloud() -> [Client] {
        
        return []
    }
    
    func saveClientsInitialFileToDB() {
        if let path = Bundle.main.path(forResource: "clientesfile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let clientes = try JSONDecoder().decode([ClientsFileParsingStruct].self, from: data)
                print("Clientes em arquivo:",clientes.count)
                
                for item in clientes {
                    let object = Client(codigo: item.CODIGO.trimmingCharacters(in: .whitespacesAndNewlines), loja: item.LOJA.trimmingCharacters(in: .whitespacesAndNewlines), Nome: item.NOME, Cidade: item.CIDADE, Estado: item.ESTADO, Endereco: item.ENDERECO, Cep: item.CEP.trimmingCharacters(in: .whitespacesAndNewlines))
                    RealmService.shared.save(object)
                }
            } catch {
                print("Erro:", error)
            }
        }
    }
    
    fileprivate func getClientsFromRealDB() -> [Client] {
        let clients = realm.objects(Client.self)
        return Array(clients.sorted(byKeyPath: "Nome"))
    }
    
    fileprivate struct ClientsFileParsingStruct: Decodable {
        var CODIGO:String
        var LOJA:String
        var NOME:String
        var CIDADE:String
        var ESTADO:String
        var ENDERECO:String
        var CEP:String
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
    
    func saveProductsInitialFileToDB() {
        if let path = Bundle.main.path(forResource: "produtos", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let produtos = try JSONDecoder().decode([ProductsFileParsingStruct].self, from: data)
                print("Produtos em arquivo:",produtos.count)
                
                for item in produtos {
                    let object = Product(codigo: item.codigo, nome: item.nome, unidadeDeMedida: item.unidademedida, saldo: item.saldo)
                    print("Saving:", object)
                    RealmService.shared.save(object)
                }
            } catch {
                print("Erro:", error)
            }
        }
    }
    
    fileprivate struct ProductsFileParsingStruct: Decodable {
        var codigo: String
        var nome: String
        var unidademedida: String
        var saldo: String
    }
    
    // MARK: - Get transportadoras functions
    
    func getTransportadorasFromDB() -> [Transportadora] {
        let transportadoras = realm.objects(Transportadora.self)
        return Array(transportadoras.sorted(byKeyPath: "nome"))
    }
    
    func getTransportadorasDataFromCloudToLocal() {
        let jsonString = "http://189.112.124.67:8013/transportadores_pv"
        guard let url = URL(string: jsonString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                
                if error != nil {return}
                if response == nil {return}
                if data == nil {return}
                let transportadoras = try JSONDecoder().decode([TransportadoraParseStruct].self, from: data!)
                
                for item in transportadoras {
                    let object = Transportadora(codigo: item.Codigo, nome: item.Nome)
                    print("Saving:", item)
                    RealmService.shared.save(object)
                    print("Saved:", object)
                }
            } catch {
                print("Erro", error)
            }
        }.resume()
    }
    
    fileprivate struct TransportadoraParseStruct: Decodable {
        var Codigo: String
        var Nome: String
    }
    
    // MARK: - Get condições de pagamento functions
    
    func getCondsPagamentoFromDB() -> [CondicaoDePagamento] {
        let condspagamento = realm.objects(CondicaoDePagamento.self)
        return Array(condspagamento.sorted(byKeyPath: "descricao"))
    }
    
    func getCondsPagamentoFromCloudToLocal() {
        let jsonString = "http://189.112.124.67:8013/condpag_pv"
        guard let url = URL(string: jsonString) else {
            print("Eroor converting to url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if response == nil {
                print("nil response")
                return
            }
            if data == nil {
                print("nil Data")
                return
            }
            
            do {
                let condPagamentos = try JSONDecoder().decode([CondPagamentoParseStruct].self, from: data!)
                
                for item in condPagamentos {
                    let object = CondicaoDePagamento()
                    object.codigo = item.Codigo
                    object.descricao = item.Descricao
                    RealmService.shared.save(object)
                    print("Saved", object)
                }
            } catch {
                print("Erro", error)
            }
        }.resume()
    }
    
    fileprivate struct CondPagamentoParseStruct: Decodable {
        var Codigo: String
        var Descricao: String
    }
    
    // MARK: - Regra de desconto functions
    
    func getRegraDeDescontoFromCloudToLocal() {
        let jsonString = "http://189.112.124.67:8013/regradesconto_pv"
        guard let url = URL(string: jsonString) else {
            print("Error converting to url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if response == nil {
                print("nil response")
                return
            }
            if data == nil {
                print("nil Data")
                return
            }
            
            do {
                let regrasDeDesconto = try JSONDecoder().decode([regraDeDescontoParseStruct].self, from: data!)
                
                for item in regrasDeDesconto {
                    let object = RegraDeDesconto(codigo: item.Codigo, descricao: item.Descricao)
                    RealmService.shared.save(object)
                    print("Saved:", object)
                }
            } catch {
                print("Erro", error)
            }
        }.resume()
    }
    
    func getRegrasDeDesconto() -> [RegraDeDesconto] {
        let transportadoras = realm.objects(RegraDeDesconto.self)
        return Array(transportadoras.sorted(byKeyPath: "descricao"))
    }
    
    fileprivate struct regraDeDescontoParseStruct: Decodable {
        var Codigo: String
        var Descricao: String
    }
    
    // MARK: - Send order to protheus
    
    func sendOrderToProtheus(_ order: NewOrder) {
        
    }
    
    // MARK: - Signature functions
    
    func sendSignatureToCloud(_ signatureImage: UIImage, completionHandler: @escaping (_ fileURL: String, _ error: Error?) -> Void) {
        let storage = Storage.storage().reference()
        let signatureRef = storage.child("signatures/\(NSDate().timeIntervalSinceReferenceDate)")
        
        let uploadTask = signatureRef.putData(<#T##uploadData: Data##Data#>, metadata: <#T##StorageMetadata?#>) { (metadata, error) in
            if error != nil {
                completionHandler("erro", error)
                return
            }
            
            
        }
    }
    
    // MARK: - Support Classes
    
    struct clientsJsonBasicTypes: HandyJSON {
        var nome: String = ""
    }
    
    func getRealmPath() {
        print(realm.configuration.fileURL)
        
    }
    
}
