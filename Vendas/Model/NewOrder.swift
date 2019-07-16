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
    @objc dynamic var filial: Int = 0
    @objc dynamic var client: Client? = nil
}
