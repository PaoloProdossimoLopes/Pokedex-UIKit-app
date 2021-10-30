//
//  PokedexRepository.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import UIKit

final class PokedexRepository: WebService {
    
    func fetchPokedexList(succes: @escaping (PokemonListReponse, UIImage, Species)->(),
                          failure: @escaping (WebServiceError)->()) {
        
        fetchPokemonList(request: .defaultAPI) { results in
            switch results {
            case .success(let pokemons):
                for pokemon in pokemons.results {
                    self.fetchPokemonDetail(reponse: pokemon, succes: { image, species in
                        succes(pokemon, image, species) }, failure: failure)
                }
            case .failure(let error): failure(error) }
        }
    }
    
    private func fetchPokemonDetail(reponse: PokemonListReponse,
                                    succes: @escaping (UIImage, Species)->(),
                                    failure: @escaping (WebServiceError)->()) {
        
        fetchPokemonDetail(urlString: reponse.url) { result in
            switch result {
            case .success(let pokemonDetail):
                self.convertImage(urlString: pokemonDetail.sprites.front) { image in
                    succes(image, pokemonDetail.species) }
                
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func fetchSpecies(specie: Species, completion: @escaping(SpeciesDetailResponse)->()) {
        
        fetchMoreDetails(urlString: specie.url) { result in
            switch result {
            case .success(let speciesResponse):
                completion(speciesResponse)
            case .failure(let error):
                break
            }
        }
        
    }
    
//    func fetchInformationAbountPokemon(url: String,
//                                       succes: @escaping (SpeciesDetailResponse)->(),
//                                       failure: @escaping (WebServiceError)->(),
//                                       completion: @escaping (Bool)->()) {
//        
//        fetchMoreDetails(urlString: url) { result in
//            switch result {
//                case .success(let pokemonSpeciesDetailResponse):
//                    succes(pokemonSpeciesDetailResponse)
//                    completion(true)
//                case .failure(let error):
//                    failure(error)
//                    completion(false)
//            }
//        }
//        
//    }
}
