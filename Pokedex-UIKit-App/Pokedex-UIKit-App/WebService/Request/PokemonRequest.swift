//
//  PokemonAPI.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import Foundation

typealias PokemonNameOrID = String

enum PokemonAPIs: String {
    case defaultAPI = "https://pokeapi.co/api/v2/pokemon/"
    case pokemonDetail = "https://pokeapi.co/api/v2/pokemon/{NameOrID}/"
}

enum PokemonRequest {
    
    //MARK: - Enum
    
    case defaultAPI
    
    
    //MARK: - Propertie
    
    var API: URL? {
        switch self {
            case .defaultAPI:
                return configureURL()
        }
    }
    
    private var urlString: String {
        var urlEnum: PokemonAPIs
        switch self {
            case .defaultAPI:
                urlEnum = .defaultAPI
                return urlEnum.rawValue
        }
    }
    
    //MARK: - Helpers
    
    private func configureURL(old: String? = nil, new: String? = nil) -> URL? {
        let raw = urlString
        
        guard let old = old,
              let new = new else { return parseURL(raw) }
        
        let urlString = raw.replacingOccurrences(of: old, with: new)
        
        return parseURL(urlString)
    }
    
    private func parseURL(_ urlString: String) -> URL? {
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
