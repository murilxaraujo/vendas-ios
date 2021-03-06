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
    @objc dynamic var primeiraunidade: String = ""
    @objc dynamic var segundaunidade: String = ""
    @objc dynamic var saldo: Float = 0
    @objc dynamic var tipoconv: String = ""
    @objc dynamic var conv: String = ""
    
    convenience init(codigo: String, nome: String, primeiraunidade: String, saldo: String, segundaunidade: String, tipoDeConv: String, fatorDeConv: String) {
        self.init()
        self.codigo = codigo.trimmingCharacters(in: .whitespacesAndNewlines)
        self.nome = nome.trimmingCharacters(in: .newlines)
        self.primeiraunidade = primeiraunidade.trimmingCharacters(in: .whitespacesAndNewlines)
        self.segundaunidade = segundaunidade.trimmingCharacters(in: .whitespacesAndNewlines)
        self.saldo = Float(saldo) ?? 0
        self.tipoconv = tipoDeConv
        self.conv = fatorDeConv
    }
    
    func getCodeAndName() -> String {
        return "\(codigo) - \(nome)"
    }
    
    func hasSecondMeasureUnit() -> Bool {
        return !segundaunidade.isEmpty
    }
}

class ProdutoPedido: Object {
    @objc dynamic var quantidade: Float = 0.0
    @objc dynamic var produto: Product? = nil
    @objc dynamic var price: String = ""
    @objc dynamic var um: String = ""
    
    convenience init(quantidade: Float, produto: Product, price: String, selectedUM: String) {
        self.init()
        self.quantidade = quantidade
        self.produto = produto
        self.price = price
        self.um = selectedUM
    }
}
