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
}
