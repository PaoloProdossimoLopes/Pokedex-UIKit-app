//
//  PokedexListViewModel.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import UIKit

final class PokedexListViewModel {
    
    //MARK: - Properties
    
    private let repository: PokedexRepository = .init()
    private var pokemonsResponse = [PokemonListReponse]()
    private var pokemonImages = [UIImage]()
    
    //MARK: - Bindings
    
    var updateView: (() -> Void)?
    var showError: ((WebServiceError) -> Void)?
    
    //MARK: - Functions
    
    func getPokemon(at index: Int) -> PokemonListReponse {
        return pokemonsResponse[index]
    }
    
    func getPokemonImage(at index: Int) -> UIImage? {
        let outOfRange: Bool = (index) >= pokemonImages.count
        return outOfRange ? nil : pokemonImages[index]
    }
    
    func getNumberOfPokemons() -> Int {
        return pokemonsResponse.count
    }
    
    func fetchPokemonsForPokedex() {
        repository.fetchPokedexList { [weak self] listReponse, pImage in
            guard let self = self else { return }
            self.pokemonImages.append(pImage)
            self.pokemonsResponse.append(listReponse)
            self.updateView?()
        } failure: { [weak self] error in
            self?.showError?(error)
        }
    }
}
