//
//  String+normalized.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

extension String {
    var normalized: String {
        return self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
    }
}

