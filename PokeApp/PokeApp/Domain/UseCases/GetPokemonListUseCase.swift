//
//  GetPokemonListUseCase.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

protocol GetPokemonListUseCaseProtocol {
    func execute(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

class GetPokemonListUseCase: GetPokemonListUseCaseProtocol {
    
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol = PokemonRepository()) {
        self.repository = repository
    }
    
    func execute(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        repository.getPokemonList(offset: offset, limit: limit, completion: completion)
    }
}
