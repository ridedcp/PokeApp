//
//  GetPokemonDetailUseCase.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

class GetPokemonDetailUseCase {
    private let repository: PokemonDetailRepositoryProtocol

    init(repository: PokemonDetailRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        repository.getPokemonDetail(id: id, completion: completion)
    }
}
