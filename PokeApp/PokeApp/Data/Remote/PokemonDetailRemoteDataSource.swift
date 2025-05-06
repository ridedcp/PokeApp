//
//  PokemonDetailRemoteDataSource.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

protocol PokemonDetailDataSourceProtocol {
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}

class PokemonDetailRemoteDataSource: PokemonDetailDataSourceProtocol {
    let service: PokemonApiService

    init(service: PokemonApiService) {
        self.service = service
    }

    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        service.fetchPokemonDetail(id: id, completion: completion)
    }
}
