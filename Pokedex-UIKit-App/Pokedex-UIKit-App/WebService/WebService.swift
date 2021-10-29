//
//  WebService.swift
//  Pokedex-UIKit-App
//
//  Created by Paolo Prodossimo Lopes on 28/10/21.
//

import Foundation
import UIKit

class WebService {
    
    static let shared: WebService = .init()
    
    func fetchPokemonList(request: Request, result: @escaping (Result<PokemonReponse, WebServiceError>)->()) {
        
        guard let url = request.url else {
            result(.failure(.URLInvalid))
            return
        }
        
        callAPI(url: url) { (listResult: Result<PokemonReponse, WebServiceError>) in
            result(listResult) }
    }
    
    func fetchPokemonDetail(urlString: String, result:  @escaping  (Result<PokemonDetailReponse, WebServiceError>)->()) {
        
        guard let url = URL(string: urlString) else {
            result(.failure(.URLInvalid))
            return
        }
        
        callAPI(url: url) { (detailResult: Result<PokemonDetailReponse, WebServiceError>) in
            result(detailResult)
        }
        
    }
    
    func convertImage(urlString: String, completion: (UIImage)->()) {
        guard let url = URL(string: urlString) else { return  }
        var data: Data
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            print(WebServiceError.decodeObjectFail)
            return
        }
        
        guard let image = UIImage(data: data) else { return }
        completion(image)
    }
    
    private func callAPI<T: Decodable>(url: URL, result: @escaping (Result<T, WebServiceError>)-> Void) {
        URLSession.shared.dataTask(with: url) { dat, resp, err in
            
            guard let data = dat, err == nil else {
                result(.failure(.badRequest))
                return
            }
            
            self.decodeObject(data: data) { objDecodeResult in
                result(objDecodeResult)
            }
            
        }.resume()
    }
    
    private func decodeObject<T: Decodable>(data: Data, result: (Result<T, WebServiceError>)-> Void) {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            result(.success(object))
        } catch {
            result(.failure(.decodeObjectFail))
        }
    }
    
}
