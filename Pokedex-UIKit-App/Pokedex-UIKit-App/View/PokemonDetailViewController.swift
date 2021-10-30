//
//  PokemonDetailViewController.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    var model: PokemonDetailModel?
    
    private lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.image = model?.photo
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    init(model: PokemonDetailModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
    }
    
    private func configureHierarchy() {
        view.addSubview(pokemonImage)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            pokemonImage.heightAnchor.constraint(equalToConstant: 200),
            pokemonImage.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
