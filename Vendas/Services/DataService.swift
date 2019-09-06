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
        return getClientsFromRealmDB()
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
                var items: [Client] = []
                for item in clientes {
                    let object = Client(codigo: item.CODIGO.trimmingCharacters(in: .whitespacesAndNewlines), loja: item.LOJA.trimmingCharacters(in: .whitespacesAndNewlines), Nome: item.NOME, Cidade: item.CIDADE, Estado: item.ESTADO, Endereco: item.ENDERECO, Cep: item.CEP.trimmingCharacters(in: .whitespacesAndNewlines))
                    items.append(object)
                }
                
                let realmInstance = try! Realm()
                
                try! realmInstance.write {
                    realmInstance.add(items)
                }
            } catch {
                print("Erro:", error)
            }
        }
    }
    
    fileprivate func getClientsFromRealmDB() -> [Client] {
        let clients = RealmService.shared.realm.objects(Client.self)
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
        return getProductsFromDB()
    }
    
    fileprivate func getProductsFromDB() -> [Product] {
        let products = RealmService.shared.realm.objects(Product.self)
        return Array(products.sorted(byKeyPath: "nome"))
    }
    
    func saveProductsInitialFileToDB() {
        if let path = Bundle.main.path(forResource: "produtos", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let produtos = try JSONDecoder().decode([ProductsFileParsingStruct].self, from: data)
                print("Produtos em arquivo:",produtos.count)
                var items: [Product] = []
                for item in produtos {
                    let object = Product(codigo: item.codigo, nome: item.nome, unidadeDeMedida: item.unidademedida, saldo: item.saldo)
                    items.append(object)
                }
                
                let realmInstance = try! Realm()
                
                try! realmInstance.write {
                    realmInstance.add(items)
                }
                
            } catch {
                print("Erro:", error)
            }
        }
    }
    
    func getProductSaldo(_ product: Product, completionHandler: @escaping (_ saldo: String?, _ error: Error?) -> Void) {
        
        let jsonDic: [String: Any] = ["CODIGO": product.codigo.trimmingCharacters(in: .whitespacesAndNewlines)]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic)
        
        var request = URLRequest(url: URL(string: "http://189.112.124.67:8013/saldo_pv")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary ?? nil
            if json == nil {
                completionHandler(nil, SwiftyJSONError.notExist)
            }
            let saldo = "\(json!["saldo"]!)"
            completionHandler(saldo, nil)
        }
        task.resume()
    }
    
    fileprivate struct ProductsFileParsingStruct: Decodable {
        var codigo: String
        var nome: String
        var unidademedida: String
        var saldo: String
    }
    
    // MARK: - Get transportadoras functions
    
    func getTransportadorasFromDB() -> [Transportadora] {
        let transportadoras = RealmService.shared.realm.objects(Transportadora.self)
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
                var items: [Transportadora] = []
                for item in transportadoras {
                    let object = Transportadora(codigo: item.Codigo, nome: item.Nome)
                    items.append(object)
                }
                let realmInstance = try! Realm()
                
                try! realmInstance.write {
                    realmInstance.add(items)
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
        let condspagamento = RealmService.shared.realm.objects(CondicaoDePagamento.self)
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
                var items = [RegraDeDesconto]()
                for item in regrasDeDesconto {
                    let object = RegraDeDesconto(codigo: item.Codigo, descricao: item.Descricao)
                    items.append(object)
                }
                
                let realmInstance = try! Realm()
                
                try! realmInstance.write {
                    realmInstance.add(items)
                }
            } catch {
                print("Erro", error)
            }
        }.resume()
    }
    
    func getRegrasDeDesconto() -> [RegraDeDesconto] {
        let transportadoras = RealmService.shared.realm.objects(RegraDeDesconto.self)
        return Array(transportadoras.sorted(byKeyPath: "descricao"))
    }
    
    fileprivate struct regraDeDescontoParseStruct: Decodable {
        var Codigo: String
        var Descricao: String
    }
    
    // MARK: - Send order to protheus
    
    func sendOrderToProtheus(_ order: NewOrder, completionHandler: @escaping (_ order: Order?, _ error: String?) -> Void) {
        if !order.isValid() {
            //Order is not valid
            print("Erro, order is not valid")
        } else {
            order.getJson { (json, error) in
                if error != nil {
                    return
                }
                
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                let url = URL(string: "http://189.112.124.67:8013/PEDIDO_PV")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData

                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let data = data, error == nil else {
                        completionHandler(nil, "\(error!)")
                        return
                    }
                    
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                        if responseJSON["ERRO"] != nil {
                            completionHandler(nil, responseJSON["RETORNO"] as? String)
                        } else if responseJSON["errorCode"] != nil {
                            completionHandler(nil, responseJSON["errorMessage"] as? String)
                        } else {
                            let order = Order()
                            order.codigo = "\(responseJSON["RETORNO"] as! String)"
                            completionHandler(order, nil)
                        }
                    }
                })
                
                task.resume()
            }
        }
    }
    
    // MARK: - Signature functions
    
    func sendSignatureToCloud(_ signatureImage: UIImage, completionHandler: @escaping (_ fileURL: String, _ error: Error?) -> Void) {
        let storage = Storage.storage().reference()
        let signatureRef = storage.child("signatures/\(NSDate().timeIntervalSinceReferenceDate).jpg")
        let metadata: StorageMetadata = {
            let mdata = StorageMetadata()
            mdata.contentType = "image/jpg"
            return mdata
        }()
        let data = signatureImage.jpegData(compressionQuality: 1)
        
        if data == nil {
            completionHandler("erro", SignatureUploadErrors.imageFailedToConvertToData)
        }
        
        signatureRef.putData(data!, metadata: metadata) { (uploadMetadata, error) in
            if error != nil {
                completionHandler("erro", error)
                return
            }
            
            if uploadMetadata == nil {
                completionHandler("erro", SignatureUploadErrors.uploadReturnedNilMetadata)
                return
            }
            
            
            signatureRef.downloadURL(completion: { (url, error) in
                if error != nil {
                    completionHandler("erro", error)
                    return
                }
                
                if url == nil {
                    completionHandler("erro", SignatureUploadErrors.downloadURLIsnil)
                    return
                }
                
                completionHandler("\(url!)", nil)
                return
            })
        }
    }
    
    // MARK: - Support Classes
    
    struct clientsJsonBasicTypes: HandyJSON {
        var nome: String = ""
    }
    
    func getRealmPath() {
        print(RealmService.shared.realm.configuration.fileURL)
        
    }
    
}
