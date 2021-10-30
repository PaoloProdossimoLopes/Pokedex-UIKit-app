//
//  ViewController.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import UIKit

private let POKEDEX_CEL_IDENTIFIER: String = "PokedexCell"

class PokedexListTableViewController: UITableViewController {
    
    //MARK: - Propertie
    
    private let viewModel: PokedexListViewModel
    
    //MARK: - Constructors
    
    init(viewModel: PokedexListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        viewModel.fetchPokemonsForPokedex()
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        configureNavigationController()
        configureBindings()
    }
    
    private func configureNavigationController() {
        view.backgroundColor = .white
        navigationItem.title = "Pokedex"
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        tableView.rowHeight = 250
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(PokedexCell.self, forCellReuseIdentifier: POKEDEX_CEL_IDENTIFIER)
    }
    
    private func configureBindings() {
        viewModel.updateView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.showError = { error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert(title: "Erro inesperado", message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}

//MARK: - Delagte & DataSouce

extension PokedexListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfPokemons()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: POKEDEX_CEL_IDENTIFIER, for: indexPath) as? PokedexCell else { return UITableViewCell() }
        let pk = viewModel.getPokemon(at: indexPath.row)
        let pokemon: Pokemon = .init(name: pk.name,
                                     photo: viewModel.getPokemonImage(at: indexPath.row))
        cell.configureCell(pokemon: pokemon)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let info = viewModel.fetchDetails(at: indexPath.row)
        guard let image = viewModel.getPokemonImage(at: indexPath.row) else { return }
        
        let model = PokemonDetailModel(plResponse: viewModel.getPokemon(at: indexPath.row),
                                       photo: image,
                                       species: info)
        
        let vc = PokemonDetailViewController(model: model)
        print(info)
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

