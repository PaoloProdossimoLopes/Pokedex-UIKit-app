//
//  FlavorTextCell.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 30/10/21.
//

import UIKit

class FlavorTextCell: UITableViewCell {
    
    lazy var message: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        
        addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        message.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        message.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
