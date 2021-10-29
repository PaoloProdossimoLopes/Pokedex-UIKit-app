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
        viewModel.fetchPokedexList()
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        configureNavigationController()
        configureHierarchy()
        configureConstraints()
        configureStyle()
        configureBindings()
    }
    
    private func configureNavigationController() {
        view.backgroundColor = .white
        navigationItem.title = "Pokedex"
        
        tableView.rowHeight = 80
        tableView.register(PokedexCell.self, forCellReuseIdentifier: POKEDEX_CEL_IDENTIFIER)
    }
    
    private func configureHierarchy() {
        
    }
    
    private func configureConstraints() {
        
    }
    
    private func configureStyle() {
        
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
                guard let _ = self else { return }
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Selectors


}

//MARK: -

extension PokedexListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfPokemons()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: POKEDEX_CEL_IDENTIFIER, for: indexPath) as! PokedexCell
        let pokemon = viewModel.getPokemon(at: indexPath.row)
        cell.configureCell(pokemon: pokemon)
        return cell
    }
    
}

