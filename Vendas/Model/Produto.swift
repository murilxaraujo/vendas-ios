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
    @objc dynamic var codigo: String = ""
    @objc dynamic var nome = ""
    @objc dynamic var unidademedida: String = ""
    @objc dynamic var saldo: Float = 0
    
    convenience init(codigo: String, nome: String, unidadeDeMedida: String, saldo: String) {
        self.init()
        self.codigo = codigo.trimmingCharacters(in: .whitespacesAndNewlines)
        self.nome = nome.trimmingCharacters(in: .newlines)
        self.unidademedida = unidadeDeMedida.trimmingCharacters(in: .whitespacesAndNewlines)
        self.saldo = Float(saldo) ?? 0
    }
    
    func getCodeAndName() -> String {
        return "\(codigo) - \(nome)"
    }
}

class ProdutoPedido: Object {
    @objc dynamic var quantidade: Float = 0.0
    @objc dynamic var produto: Product? = nil
    
    convenience init(quantidade: Float, produto: Product) {
        self.init()
        self.quantidade = quantidade
        self.produto = produto
    }
}
