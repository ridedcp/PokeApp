//
//  PokemonDetail.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int?
    let name: String?
    let height: Int?
    let weight: Int?
    let types: [PokemonTypeEntry]?
    let stats: [PokemonStat]?
    let sprites: PokemonSprites?
}

struct PokemonTypeEntry: Codable {
    let type: NamedAPIResource?
}

struct PokemonStat: Codable {
    let base_stat: Int?
    let stat: NamedAPIResource?
}

struct NamedAPIResource: Codable {
    let name: String?
}

struct PokemonSprites: Codable {
    let front_default: String?
}
