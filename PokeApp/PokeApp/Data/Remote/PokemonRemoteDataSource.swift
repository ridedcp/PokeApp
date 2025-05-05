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
    
    init(service: PokemonApiService) {
        self.service = service
    }
    
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        service.fetchPokemonList(offset: offset, limit: limit) { result in
            switch result {
            case .success(let networkModels):
                let pokemons = networkModels.map {
                    let id = Int($0.url.split(separator: "/").last!) ?? 0
                    let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
                    return Pokemon(id: id, name: $0.name.capitalized, imageUrl: imageUrl)
                }
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
