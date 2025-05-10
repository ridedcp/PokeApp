//
//  GetPokemonDetailUseCaseProtocol.swift
//  PokeApp
//
//  Created by Daniel Cano on 10/5/25.
//

protocol GetPokemonDetailUseCaseProtocol {
    func execute(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}
