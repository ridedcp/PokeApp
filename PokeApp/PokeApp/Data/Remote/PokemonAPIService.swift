//
//  APIClient.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

final class PokemonApiService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1)))
            return
        }
        
        performRequest(url: url, type: PokemonDetail.self, completion: completion)
    }
    
    func fetchPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[PokemonNetworkModel], Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1)))
            return
        }
        
        performRequest(url: url, type: PokemonListResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func performRequest<T: Decodable>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "HTTPError", code: -1)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "EmptyData", code: -1)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
