//
//  PokemonRepositoryProtocol.swift
//  PokeApp
//
//  Created by Daniel Cano on 10/5/25.
//


protocol PokemonRepositoryProtocol {
    func getPokemonList(offset: Int, limit: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void)
}