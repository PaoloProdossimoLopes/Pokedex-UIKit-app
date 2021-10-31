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
    private var pokemons: [PokemonBasicInfo] = .init()
    
    //MARK: - Bindings
    
    var updateView: (() -> Void)?
    var showError: ((WebServiceError) -> Void)?
    
    //MARK: - Functions
    
    func getPokemon(at index: Int) -> PokemonBasicInfo {
        return pokemons[index]
    }
    
    func getPokemonImage(at index: Int) -> UIImage? {
        let outOfRange: Bool = (index) >= pokemons.count
        return outOfRange ? nil : pokemons[index].image
    }
    
    func getNumberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func fetchPokemonsForPokedex() {
        
        repository.collectPokemonInformations { pokemons in
            self.pokemons = pokemons
            self.updateView?()
        }
    }
    
    func getCell(_ tableView: UITableView, identifier: String, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PokedexCell else { return UITableViewCell() }
        
        let pk = getPokemon(at: indexPath.row)
        let pokemon: PokemonBasicInfo = .init(id: pk.id, name: pk.name, image: pk.image,
                                              flavourText: pk.flavourText)
        
        cell.configureCell(pokemon: pokemon)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func getPokemonDetailView(at indexPath: IndexPath) -> UIViewController {
        return  PokemonDetailViewController(model: pokemons[indexPath.row])
    }
    
}
