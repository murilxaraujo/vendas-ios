//
//  RegraDeDesconto.swift
//  Vendas
//
//  Created by Murilo Araujo on 30/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class RegraDeDesconto: Object {
    @objc dynamic var codigo: String = ""
    @objc dynamic var descricao: String = ""
    @objc dynamic var desconto: String = ""
    
    convenience init(codigo: String, descricao: String, desconto: String) {
        self.init()
        self.codigo = codigo
        self.descricao = descricao
        self.desconto = desconto
    }
    
    func getCodigoAndDescricaoAsString() -> String {
        return "\(codigo) - \(descricao)"
    }
}
