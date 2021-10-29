//
//  WebServiceError.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

enum WebServiceError: Error {
    case badRequest
    case URLInvalid
    case decodeObjectFail
}
