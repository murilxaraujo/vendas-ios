//
//  Enums.swift
//  Vendas
//
//  Created by Murilo Araujo on 11/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

enum NetworkServiceErrors: Error {
    case valueisNil
}

enum LoginError: Error {
    case userNotFound
    case blockedUser
    case notAttachedSeller
    case wrongPassword
    case networkError
}

enum SignatureUploadErrors: Error {
    case imageFailedToConvertToData
    case downloadURLIsnil
    case uploadReturnedNilMetadata
}
