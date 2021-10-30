//
//  PokemonDetailReponse.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import Foundation

struct PokemonDetailReponse: Decodable {
    let sprites: PokemonSpretes
    let species: Species
    
}

struct PokemonSpretes: Decodable {
    let front: String
    
    enum CodingKeys: String, CodingKey {
        case front = "front_default"
    }
}

struct Species: Decodable {
    let url: String
}


