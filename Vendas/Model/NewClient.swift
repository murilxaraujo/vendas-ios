//
//  NewClient.swift
//  Vendas
//
//  Created by Murilo Araujo on 12/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import Foundation
import RealmSwift

class NewClient: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var fantasyName: String = ""
    @objc dynamic var cpfCnpj: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var stateEnrollmentID: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var cep: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var phone: String = ""
    
}
