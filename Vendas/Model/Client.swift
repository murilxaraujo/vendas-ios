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
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
}
