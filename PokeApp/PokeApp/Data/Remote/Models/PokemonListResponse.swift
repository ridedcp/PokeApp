//
//  PokemonListResponse.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonNetworkModel]
}

struct PokemonNetworkModel: Codable {
    let name: String
    let url: String
}

