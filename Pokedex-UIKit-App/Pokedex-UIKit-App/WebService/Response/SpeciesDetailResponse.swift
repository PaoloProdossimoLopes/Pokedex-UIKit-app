//
//  SpeciesDetailResponse.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import Foundation

struct SpeciesDetailResponse: Decodable {
    let id: Int
    let flavor_text_entries: [FlavorText]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case flavor_text_entries = "flavor_text_entries"
    }
}

struct FlavorText: Decodable {
    let flavor_text: String
    
    enum CodingKeys: String, CodingKey {
        case flavor_text = "flavor_text"
    }
}
