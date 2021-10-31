//
//  PokedexRepository.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 29/10/21.
//

import UIKit

final class PokedexRepository: WebService {
    
    private let dGroup: DispatchGroup = .init()
    
    private var pokemonsResponse = [PokemonListReponse]()
    private var pokeonDetailResponse = [PokemonDetailReponse]()
    private var species = [SpeciesDetailResponse]()
    private var pokemonImages = [UIImage]()
    
    func collectPokemonInformations(completion: @escaping ([PokemonBasicInfo])->()) {
        
        fetchPokemonList { pokemons in
            pokemons.results.forEach { self.pokemonsResponse.append($0) }
            self.FPD {  self.dGroup.leave() }
        } failure: { error in
            print(error)
        }
        
        //notify when done
        dGroup.notify(queue: .global()) {
            
            var pokemons = [PokemonBasicInfo]()
            
            for i in (0 ..< self.pokemonsResponse.count) {
                pokemons.append(PokemonBasicInfo(id: self.species[i].id,
                                                 name: self.pokemonsResponse[i].name,
                                                 image: self.pokemonImages[i],
                                                 flavourText: self.species[i].flavor_text_entries))
            }
            
            completion(pokemons)
        }
    }
    
    //Fetch pokemon list
    
    private func fetchPokemonList(succes: @escaping (PokemonReponse)->(),
                                  failure: @escaping (WebServiceError)->()) {
        dGroup.enter()
        perform(request: .defaultAPI) { (results: Result<PokemonReponse, WebServiceError>) in
            switch results {
                case .success(let pokemons): succes(pokemons)
                case .failure(let error): failure(error)
            }
        }
    }
    
    //Fetch pokemon detail
    
    private func FPD(completion: @escaping ()->()) {
        for pokemon in pokemonsResponse {
            fetchPokemonsDetails(url: pokemon.url) { PDetailReponse in
                self.pokeonDetailResponse.append(PDetailReponse)
                self.GPImage(url: PDetailReponse.sprites.front)
                self.fetchSpecies(species: PDetailReponse.species) { specie in
                    self.species.append(specie)
                    if pokemon == self.pokemonsResponse.last { completion() }
                }
            } failure: { error in
                print(error)
            }
        }
    }
    
    private func fetchPokemonsDetails(url: String,
                                      success: @escaping (PokemonDetailReponse)->(),
                                      failure: @escaping (WebServiceError)->()) {
        
        perform(urlString: url) { (result: (Result<PokemonDetailReponse, WebServiceError>)) in
            switch result {
            case .success(let pokemonDetail): success(pokemonDetail)
            case .failure(let error): failure(error)
            }
        }
    }
    
    //Get image
    
    private func GPImage(url: String) {
        getPokemonImage(url: url) { image in
            self.pokemonImages.append(image)
        }
    }
    
    private func getPokemonImage(url: String, completion: @escaping (UIImage)->()) {
        self.perform(urlString: url) { image in
            completion(image)
        }
    }
    
    func fetchSpecies(species: Species, completion: @escaping(SpeciesDetailResponse)->()) {
        
            fetchMoreDetails(urlString: species.url) { result in
                switch result {
                case .success(let speciesResponse):
                    completion(speciesResponse)
                case .failure(_):
                    break
                }
            
        }
    }
    
}
