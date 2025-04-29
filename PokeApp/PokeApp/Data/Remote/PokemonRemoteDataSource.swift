//
//  PokemonRemoteDataSource.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

protocol PokemonRemoteDataSourceProtocol {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

class PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    
    let service: PokemonApiService
    
    init(service: PokemonApiService = PokemonApiService()) {
        self.service = service
    }
    
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        service.fetchPokemonList(offset: offset, limit: limit) { results in
            switch results {
            case .success(let networkModel):
                let pokemons = networkModel.map { Pokemon(name: $0.name, url: $0.url) }
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
