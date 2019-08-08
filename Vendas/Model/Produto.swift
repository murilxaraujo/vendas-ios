//
//  Produto.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var codigo = ""
    @objc dynamic var nome = ""
    @objc dynamic var unidademedida = ""
    
    convenience init(codigo: String, nome: String, unidadeDeMedida: String) {
        self.init()
        self.codigo = codigo
        self.nome = nome
        self.unidademedida = unidadeDeMedida
    }
}
