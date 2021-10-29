//
//  PokedexRepository.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import UIKit

final class PokedexRepository: WebService {
    
    func fetchPokedexList(succes: @escaping (PokemonListReponse, UIImage)->(),
                          failure: @escaping (WebServiceError)->()) {
        
        fetchPokemonList(request: PokemonListRequest()) { results in
            switch results {
            case .success(let pokemons):
                for pokemon in pokemons.results {
                    self.fetchPokemonDetail(reponse: pokemon, succes: { image in succes(pokemon, image) }, failure: failure)
                }
            case .failure(let error): failure(error) }
        }
    }
    
    private func fetchPokemonDetail(reponse: PokemonListReponse,
                                    succes: @escaping (UIImage)->(),
                                    failure: @escaping (WebServiceError)->()) {
        
        fetchPokemonDetail(urlString: reponse.url) { result in
            switch result {
            case .success(let pokemonDetail):
                self.convertImage(urlString: pokemonDetail.sprites.front) { image in  succes(image) }
            case .failure(let error):
                failure(error)
            }
        }
    }
}
