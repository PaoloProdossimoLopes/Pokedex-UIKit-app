//
//  PokedexCell.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import UIKit

final class PokedexCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 40/2
        image.backgroundColor = .red
        return image
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokemon name Here"
        label.font = .boldSystemFont(ofSize: 18)
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
        [containerView, pokemonImage, pokemonName].forEach {
            addSubview($0)
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
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
