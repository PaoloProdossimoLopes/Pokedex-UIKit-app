//
//  PokemonDetailModel.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import UIKit

struct PokemonDetailModel {
    let id: Int
    let name: String
    let photo: UIImage
    let flavorText: [FlavorText]
    
    init(plResponse: PokemonListReponse, photo: UIImage, species: SpeciesDetailResponse) {
        self.id = species.id
        self.name = plResponse.name
        self.photo = photo
        self.flavorText = species.flavor_text_entries
    }
    
    init(pBasicInfo: PokemonBasicInfo) {
        self.id = pBasicInfo.id
        self.name = pBasicInfo.name
        self.photo = pBasicInfo.image
        self.flavorText = pBasicInfo.flavourText
    }
}
