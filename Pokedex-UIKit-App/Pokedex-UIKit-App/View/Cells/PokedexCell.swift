//
//  PokedexCell.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import UIKit

final class PokedexCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        return image
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon name Here"
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        configureViewHeirarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureViewHeirarchy() {
        addSubview(pokemonImage)
        addSubview(pokemonName)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pokemonImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonImage.heightAnchor.constraint(equalToConstant: 40),
            pokemonImage.widthAnchor.constraint(equalToConstant: 40),
            
            pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 10),
            pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func configureStyle() {
        
    }
    
    func configureCell(pokemon: PokemonListReponse) {
        pokemonName.text = pokemon.name
    }
    
    
}
