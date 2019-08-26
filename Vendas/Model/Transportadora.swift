//
//  Transportadora.swift
//  Vendas
//
//  Created by Murilo Araujo on 26/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class Transportadora: Object {
    @objc dynamic var codigo = ""
    @objc dynamic var nome = ""
    
    convenience init(codigo: String, nome: String) {
        self.init()
        self.codigo = codigo
        self.nome = nome
    }
}
