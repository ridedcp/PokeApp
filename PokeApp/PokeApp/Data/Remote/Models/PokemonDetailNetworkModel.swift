//
//  PokemonDetailNetworkModel.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

struct PokemonDetailNetworkModel: Codable {
    let sprites: Sprites

    struct Sprites: Codable {
        let frontDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
