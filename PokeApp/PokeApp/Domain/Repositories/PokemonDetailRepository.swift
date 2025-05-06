//
//  PokemonDetailRepository.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}

class PokemonDetailRepository: PokemonDetailRepositoryProtocol {
    let remoteDataSource: PokemonDetailDataSourceProtocol

    init(remoteDataSource: PokemonDetailDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        remoteDataSource.getPokemonDetail(id: id, completion: completion)
    }
}

