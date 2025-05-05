//
//  APIClient.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

class PokemonApiService {
    
    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[PokemonNetworkModel], Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
