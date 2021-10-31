//
//  PokemonDetailViewController.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var model: PokemonBasicInfo
    
    private lazy var closeButton: UIButton = {
        let image = UIImage(systemName: "xmark.square.fill")
        
        let button = UIButton(type: .system)
        button.setImage(image?.withTintColor(UIColor.red.withAlphaComponent(0.8),
                                             renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        
        button.addTarget(self, action: #selector(closeButtonHandleTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.image = model.image
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.text = model.name.uppercased()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messagesTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FlavorTextCell.self, forCellReuseIdentifier: FLAVOR_TEXT_CELL_REUSE_IDENTIFIER)
        return table
    }()
    
    //MARK: - Constructor
    
    init(model: PokemonBasicInfo) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
    }
    
    private func configureHierarchy() {
        view.addSubview(closeButton)
        view.addSubview(pokemonImage)
        view.addSubview(pokemonName)
        view.addSubview(messagesTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            pokemonImage.heightAnchor.constraint(equalToConstant: 200),
            pokemonImage.widthAnchor.constraint(equalToConstant: 200),
            
            pokemonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonName.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 0),
            pokemonName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pokemonName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            messagesTableView.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 10),
            messagesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messagesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messagesTableView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    //MARK: - Selectors
    
    @objc private func closeButtonHandleTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - TableView Delegate&DataSouce

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Flavour Texts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.flavourText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FLAVOR_TEXT_CELL_REUSE_IDENTIFIER, for: indexPath) as! FlavorTextCell
        cell.message.text = model.flavourText[indexPath.row].flavor_text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

fileprivate let FLAVOR_TEXT_CELL_REUSE_IDENTIFIER = "FlavorTextCell"
