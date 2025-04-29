//
//  APIClient.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

class PokemonApiService {
    
    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[PokemonNetworkModel], Error>) -> Void) {
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(PokemonListResponse.self, from: data) {
                    completion(.success(decodedData.results))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                }
            }
            task.resume()
        }
    }

}
