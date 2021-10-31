//
//  PokemonReponse.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import Foundation

struct PokemonReponse: Decodable {
    
    let results: [PokemonListReponse]
}

struct PokemonListReponse: Equatable, Decodable {
    let name: String
    let url: String
}
