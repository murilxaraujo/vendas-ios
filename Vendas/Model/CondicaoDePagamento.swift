//
//  CondicaoDePagamento.swift
//  Vendas
//
//  Created by Murilo Araujo on 26/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class CondicaoDePagamento: Object {
    @objc dynamic var codigo = ""
    @objc dynamic var descricao = ""
    
    convenience init(codigo: String, descricao: String) {
        self.init()
        self.codigo = codigo
        self.descricao = descricao
    }
    
    func getCodigoAndDescricaoAsString() -> String {
        return "\(codigo) - \(descricao)"
    }
}
