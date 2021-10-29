//
//  PokemonRequest.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import Foundation

protocol Request {
    var url: URL? { get }
}

final class PokemonListRequest: Request {
    
    private let urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    
    var url: URL? {
        return URL(string: urlString)
    }
}
