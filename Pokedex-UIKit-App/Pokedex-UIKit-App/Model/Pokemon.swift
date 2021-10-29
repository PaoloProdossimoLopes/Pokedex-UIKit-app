//
//  Pokemon.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import UIKit

class Pokemon {
    
    //MARK: - Properties
    
    var name: String
    var photo: UIImage?
    
    //MARK: - Init
    
    init(reponse: PokemonListReponse) {
        self.name = reponse.name
    }
    
    init (pokemon: Pokemon) {
        self.name = pokemon.name
        self.photo = pokemon.photo
    }
    
}
