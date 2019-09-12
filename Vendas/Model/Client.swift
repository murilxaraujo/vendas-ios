//
//  Client.swift
//  Vendas
//
//  Created by Murilo Araujo on 15/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class Client: Object {
    @objc dynamic var codigo = ""
    @objc dynamic var loja = ""
    @objc dynamic var Nome = ""
    @objc dynamic var Cidade = ""
    @objc dynamic var Estado = ""
    @objc dynamic var Endereco = ""
    @objc dynamic var Cep = ""
    
    convenience init(codigo: String, loja: String, Nome: String, Cidade: String, Estado: String, Endereco: String, Cep: String) {
        self.init()
        self.codigo = codigo
        self.loja = loja
        self.Nome = Nome
        self.Cidade = Cidade
        self.Estado = Estado
        self.Endereco = Endereco
        self.Cep = Cep
    }
}
