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
    @objc dynamic var codigo: Int = 0
    @objc dynamic var nome = ""
    @objc dynamic var unidademedida: String = ""
    @objc dynamic var saldo: Float = 0
    
    convenience init(codigo: String, nome: String, unidadeDeMedida: String, saldo: String) {
        self.init()
        self.codigo = Int(codigo) ?? 0
        self.nome = nome
        self.unidademedida = unidadeDeMedida
        self.saldo = Float(saldo) ?? 0
    }
    
    func getCodeAndName() -> String {
        return "\(codigo) - \(nome)"
    }
}

struct ProdutoPedido {
    var quantidade: Float!
    var produto: Product
    
    init(quantidade: Float!, produto: Product) {
        self.quantidade = quantidade
        self.produto = produto
    }
}
