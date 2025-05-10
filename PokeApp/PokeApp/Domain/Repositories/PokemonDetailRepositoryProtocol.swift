//
//  PokemonDetailRepositoryProtocol.swift
//  PokeApp
//
//  Created by Daniel Cano on 10/5/25.
//


protocol PokemonDetailRepositoryProtocol {
    func getPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}