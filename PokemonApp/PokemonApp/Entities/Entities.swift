//
//  Entities.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - Welcome
struct Response: Codable {
    let results: [Pokemon]
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String
    let url: String
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let name: String
    let sprites: PokemonSprites?
}

struct PokemonSprites: Codable {
    let front_default: String
}
