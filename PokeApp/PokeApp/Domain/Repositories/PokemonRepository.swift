//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

class PokemonRepository: PokemonRepositoryProtocol, PokemonDetailRepositoryProtocol {
    
    private let remoteDataSource: PokemonRemoteDataSourceProtocol
    
    init(remoteDataSource: PokemonRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        remoteDataSource.getPokemonList(offset: offset, limit: limit, completion: completion)
    }
    
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        remoteDataSource.getPokemonDetail(id: id, completion: completion)
    }
}
