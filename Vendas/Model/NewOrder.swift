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
    let items = List<ProdutoPedido>()
    //assinatura
    
    convenience init(filial: String) {
        self.init()
        self.filial = filial
    }
    
    func getJsonAsString(_ parameters: [String:String], completionHandler: (_ jsonString: String,_ error: Error?) -> Void) {
        var json = [String: Any]()
        json["filial"] = self.filial
        json["cliente"] = self.client!.codigo
        json["vendedor"] = AuthService.shared.getSavedUserID()
        json["kit"] = self.kit
        json["express"] = self.express
        json["obs"] = self.obs
        json["items"] = Array<[String:Any]>()
        
        var items = Array<[String:Any]>()
        
        for item in self.items {
            items.append(["produto": item.produto!.codigo, "quantidade": item.quantidade])
        }
        
        json["items"] = items
        
        if let theJSONData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            completionHandler(theJSONText!, nil)
        }
    }
}
