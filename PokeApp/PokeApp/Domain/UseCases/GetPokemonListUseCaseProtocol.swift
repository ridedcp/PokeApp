//
//  GetPokemonListUseCaseProtocol.swift
//  PokeApp
//
//  Created by Daniel Cano on 10/5/25.
//


protocol GetPokemonListUseCaseProtocol {
    func execute(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}