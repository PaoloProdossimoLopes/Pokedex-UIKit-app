//
//  PokemonDetailResponse.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import Foundation

struct PokemonDetailRequest: Request {
    let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
}
