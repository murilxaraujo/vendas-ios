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
    
    func saveClientsInitialFileToDB() throws {
        if let path = Bundle.main.path(forResource: "clientesfile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let clientes = try JSONDecoder().decode([ClientsFileParsingStruct].self, from: data)
                print("Clientes em arquivo: ",clientes.count)
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
                throw DataDownloadError.UndefinedError
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
    
    func saveProductsInitialFileToDB() throws {
        if let path = Bundle.main.path(forResource: "jsonformatter", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let produtos = try JSONDecoder().decode([ProductsFileParsingStruct].self, from: data)
                print("Produtos em arquivo: ",produtos.count)
                var items: [Product] = []
                for item in produtos {
                    let object = Product(codigo: item.codigo.trimmingCharacters(in: .whitespacesAndNewlines), nome: item.nome, primeiraunidade: item.primeiraunidade.trimmingCharacters(in: .whitespacesAndNewlines), saldo: item.saldo.trimmingCharacters(in: .whitespacesAndNewlines), segundaunidade: item.segundaunidade.trimmingCharacters(in: .whitespacesAndNewlines), tipoDeConv: item.tipoconv.trimmingCharacters(in: .whitespacesAndNewlines), fatorDeConv: item.conv.trimmingCharacters(in: .whitespacesAndNewlines))
                    items.append(object)
                }
                
                let realmInstance = try! Realm()
                
                try! realmInstance.write {
                    realmInstance.add(items)
                }
                
            } catch {
                print("Erro:", error)
                throw DataDownloadError.UndefinedError
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
                return
            }
            let saldo = "\(json!["saldo"]!)"
            completionHandler(saldo, nil)
        }
        task.resume()
    }
    
    func getProductPrice(clientID: String, clientLoja: String, productID: String, completionHandler: @escaping (_ preco: String?, _ error: Error?) -> Void) {
        let jsonDic: [String: Any] = [
            "CODIGO": clientID,
            "LOJA": clientLoja,
            "PRODUTO": productID
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic)
        
        var request = URLRequest(url: URL(string: "http://189.112.124.67:8013/PRECO_PV")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completionHandler(nil, SwiftyJSONError.notExist)
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary ?? nil
                if json == nil {
                    completionHandler(nil, SwiftyJSONError.notExist)
                    return
                }
                
                if json!["RETORNO"] != nil {
                    completionHandler(nil, SwiftyJSONError.notExist)
                    return
                }
                
                let price = "\(json!["PRECO"]!)"
                completionHandler(price, nil)
            }
            
        }
        task.resume()
    }
    // send CODIGO LOJA PRODUTO, preco PRECO_PV, erro RETORNO
    
    fileprivate struct ProductsFileParsingStruct: Decodable {
        var codigo: String
        var nome: String
        var primeiraunidade: String
        var segundaunidade: String
        var saldo: String
        var tipoconv: String
        var conv: String
    }
    
    // MARK: - Get transportadoras functions
    
    func getTransportadorasFromDB() -> [Transportadora] {
        let transportadoras = RealmService.shared.realm.objects(Transportadora.self)
        return Array(transportadoras.sorted(byKeyPath: "nome"))
    }
    
    func getTransportadorasDataFromCloudToLocal() throws {
        let jsonString = "http://189.112.124.67:8013/transportadores_pv"
        guard let url = URL(string: jsonString) else {throw DataDownloadError.ErrorConvertingUrl}
        
        var data: Data?
        var response: URLResponse?
        var error: DataDownloadError?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (innerData, innerResponse, innerError) in
            if error != nil {error = DataDownloadError.SessionError}
            if response == nil {error =  DataDownloadError.ResponseIsNil}
            if data == nil {error = DataDownloadError.DataIsNil}
            data = innerData
            response = innerResponse
            
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        do {
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
            throw DataDownloadError.UndefinedError
        }
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
    
    func getCondsPagamentoFromCloudToLocal() throws {
        let jsonString = "http://189.112.124.67:8013/condpag_pv"
        guard let url = URL(string: jsonString) else {
            print("Eroor converting to url")
            throw DataDownloadError.ErrorConvertingUrl
        }
        
        var error: DataDownloadError?
        var data: Data?
        var response: URLResponse?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (innerData, innerResponse, innerError) in
            if error != nil {
                error = DataDownloadError.SessionError
            }
            if response == nil {
                error = DataDownloadError.ResponseIsNil
            }
            if data == nil {
                error = DataDownloadError.DataIsNil
            }
            
            data = innerData
            response = innerResponse
            
            semaphore.signal()
            
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        do {
            let condPagamentos = try JSONDecoder().decode([CondPagamentoParseStruct].self, from: data!)
            var items = [CondicaoDePagamento]()
            for item in condPagamentos {
                let object = CondicaoDePagamento()
                object.codigo = item.Codigo
                object.descricao = item.Descricao
                items.append(object)
            }
            let realmInstance = try! Realm()
            
            try! realmInstance.write {
                realmInstance.add(items)
            }
        } catch {
            print("Erro:",error)
            throw DataDownloadError.UndefinedError
        }
    }
    
    fileprivate struct CondPagamentoParseStruct: Decodable {
        var Codigo: String
        var Descricao: String
    }
    
    // MARK: - Regra de desconto functions
    
    enum DataDownloadError: Error {
        case ErrorConvertingUrl
        case ResponseIsNil
        case DataIsNil
        case UndefinedError
        case SessionError
    }
    
    func getRegraDeDescontoFromCloudToLocal() throws -> Bool {
        let jsonString = "http://189.112.124.67:8013/regradesconto_pv"
        guard let url = URL(string: jsonString) else {
            throw DataDownloadError.ErrorConvertingUrl
        }
        
        var error: DataDownloadError?
        var response: URLResponse?
        var data: Data?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { (innerData, innerResponse, innerError) in
            if innerError != nil {
                error = DataDownloadError.SessionError
            }
            if innerResponse == nil {
                error = DataDownloadError.ResponseIsNil
            }
            if innerData == nil {
                error = DataDownloadError.DataIsNil
            }
            data = innerData
            response = innerResponse
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        if error != nil {
            switch error! {
            case DataDownloadError.ErrorConvertingUrl:
                throw DataDownloadError.ErrorConvertingUrl
            case DataDownloadError.ResponseIsNil:
                throw DataDownloadError.ResponseIsNil
            case DataDownloadError.DataIsNil:
                throw DataDownloadError.DataIsNil
            default:
                throw DataDownloadError.UndefinedError
            }
        }
        do {
            let regrasDeDesconto = try JSONDecoder().decode([regraDeDescontoParseStruct].self, from: data!)
            var items = [RegraDeDesconto]()
            for item in regrasDeDesconto {
                let object = RegraDeDesconto(codigo: item.Codigo, descricao: item.Descricao, desconto: item.Desconto)
                items.append(object)
            }
            let realmInstance = try! Realm()
            try! realmInstance.write {
                realmInstance.add(items)
            }
            return true
        } catch {
            throw error
        }
    }
    
    func getRegrasDeDesconto() -> [RegraDeDesconto] {
        let transportadoras = RealmService.shared.realm.objects(RegraDeDesconto.self)
        return Array(transportadoras.sorted(byKeyPath: "descricao"))
    }
    
    fileprivate struct regraDeDescontoParseStruct: Decodable {
        var Codigo: String
        var Descricao: String
        var Desconto: String
    }
    
    // MARK: - Send order to protheus
    
    func sendOrderToProtheus(_ order: NewOrder, completion: @escaping (_ retorno: String?, _ error: String?) -> Void) {
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
                    if error != nil {
                        completion(nil, "\(error!)")
                        return
                    }
                    
                    if data == nil {
                        completion(nil, "Data is nil")
                    }
                    
                    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                    
                    DispatchQueue.main.async {
                        if let responseJSON = responseJSON as? [String: Any] {
                            print(responseJSON)
                            print("ERRO value", responseJSON["ERRO"] as! String)
                            print("ERRO EQUALS S:", responseJSON["ERRO"] as! String == "S")
                            if responseJSON["ERRO"] as! String == "S" {
                                completion(nil, responseJSON["RETORNO"] as? String)
                            } else if responseJSON["errorCode"] != nil {
                                completion(nil, responseJSON["errorMessage"] as? String)
                            } else {
                                completion(responseJSON["RETORNO"] as? String, nil)
                            }
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
            // EXPRESS =! POLO
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
