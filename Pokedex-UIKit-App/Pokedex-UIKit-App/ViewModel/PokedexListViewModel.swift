//
//  PokedexListViewModel.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import Foundation

final class PokedexListViewModel {
    
    //MARK: - Properties
    
    private let service: WebService = .shared
    private var pokemons = [PokemonListReponse]()
    
    //MARK: - Bindings
    
    var updateView: (() -> Void)?
    var showError: ((WebServiceError) -> Void)?
    
    //MARK: - Functions
    
    func getPokemon(at index: Int) -> PokemonListReponse {
        return pokemons[index]
    }
    
    func getNumberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func fetchPokedexList() {
        service.fetchPokemons(request: PokemonListRequest()) { results in
            switch results {
            case .success(let pokemons):
                self.pokemons = pokemons.results
                self.updateView?()
            case .failure(let error):
                self.showError?(error)
            }
        }
    }
    
    
    
}
