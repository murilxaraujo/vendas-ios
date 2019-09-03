//
//  NewOrder.swift
//  Vendas
//
//  Created by Murilo Araujo on 15/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class NewOrder: Object {
    
    @objc dynamic var filial: String = ""
    @objc dynamic var client: Client? = nil
    @objc dynamic var vendedor: String = ""
    @objc dynamic var empresa: String = ""
    @objc dynamic var filialClient: String = ""
    @objc dynamic var kit: String = ""
    @objc dynamic var express: String = ""
    @objc dynamic var tipoDeFrete: String = ""
    @objc dynamic var transportadora: String = ""
    @objc dynamic var condPagamento: String = ""
    @objc dynamic var regraDeDesconto: String = ""
    @objc dynamic var desconto: String = ""
    @objc dynamic var obs: String = ""
    @objc dynamic var pesoLq: Float = 0.0
    @objc dynamic var pesoBt: Float = 0.0
    @objc dynamic var signatureURL: String = ""
    @objc dynamic var uMedida: String = ""
    let items = List<ProdutoPedido>()
    //assinatura
    
    convenience init(filial: String) {
        self.init()
        self.filial = filial
    }
    
    func getJson(completionHandler: (_ json: [String: Any],_ error: Error?) -> Void) {
        var json = [String: Any]()
        json["cliente"] = self.client!.codigo
        json["filial"] = self.filial
        json["loja"] = self.client!.loja
        json["kit"] = self.kit
        json["vendedor"] = AuthService.shared.getSavedUserID()
        json["express"] = self.express
        json["tipoDeFrete"] = self.tipoDeFrete
        json["transportadora"] = self.transportadora
        json["condPagamento"] = self.condPagamento
        json["regraDeDesconto"] = self.regraDeDesconto
        json["desconto"] = self.desconto
        json["obs"] = self.obs
        json["pesoLq"] = self.pesoLq
        json["pesoBt"] = self.pesoBt
        json["items"] = Array<[String:Any]>()
        json["assinatura"] = self.signatureURL
        var items = Array<[String:Any]>()
        
        for item in self.items {
            items.append(["produto": item.produto!.codigo, "quantidade": item.quantidade])
        }
        
        json["items"] = items
        
        completionHandler(json, nil)
    }
    
    func isValid() -> Bool {
        if self.client == nil {
            return false
        }
        
        if self.items.count == 0 {
            return false
        }
        
        if self.kit == "" || self.express == "" {
            return false
        }
        
        if self.signatureURL == ""{
            return false
        }
        
        return true
    }
}
