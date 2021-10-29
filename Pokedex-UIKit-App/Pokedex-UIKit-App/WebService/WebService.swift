//
//  WebService.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import Foundation

final class WebService {
    
    static let shared: WebService = .init()
    
    func fetchPokemons(request: Request, result: @escaping (Result<PokemonReponse, WebServiceError>)->()) {
        
        guard let url = request.url else {
            result(.failure(.URLInvalid))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { dat, resp, err in
            
            guard let data = dat, err == nil else {
                result(.failure(.badRequest))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(PokemonReponse.self, from: data)
                result(.success(object))
            } catch {
                result(.failure(.decodeObjectFail))
            }
            
            
        }
        
        task.resume()
    }
    
}
