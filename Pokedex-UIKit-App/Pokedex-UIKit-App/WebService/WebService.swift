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
    
//    func fetchPokemonList(request: PokemonRequest, result: @escaping (Result<PokemonReponse, WebServiceError>)->()) {
//        
//        guard let url = request.API else {
//            result(.failure(.URLInvalid))
//            return
//        }
//        
//        callAPI(url: url) { (listResult: Result<PokemonReponse, WebServiceError>) in
//            result(listResult)
//        }
//    }
    
    func perform<T: Decodable>(urlString: String,
                            result:  @escaping (Result<T, WebServiceError>)->()) {
        
        guard let url = URL(string: urlString) else {
            result(.failure(.URLInvalid))
            return
        }
        
        callAPI(url: url) { (detailResult: Result<T, WebServiceError>) in
            result(detailResult)
        }
        
    }
    
    func perform(urlString: String, completion: (UIImage)->()) {
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
    
    func fetchMoreDetails(urlString: String, completion: @escaping (Result<SpeciesDetailResponse, WebServiceError>)->()) {
        
        guard let url = URL(string: urlString) else { return }
        
        callAPI(url: url) { (result: Result<SpeciesDetailResponse, WebServiceError>) in
            completion(result)
        }

    }
    
    //modelo 1
    func perform<T: Decodable>(request: PokemonRequest, result: @escaping (Result<T, WebServiceError>)->()) {
        guard let url = request.API else {
            result(.failure(.URLInvalid))
            return
        }
        
        callAPI(url: url) { (listResult: Result<T, WebServiceError>) in
            result(listResult)
        }
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
