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

// MARK: - DetailPokemon
struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let name: String
    let types: [TypeElement]
    let sprites: PokemonSprites?
}

// MARK: - PokemonSprites
struct PokemonSprites: Codable {
    let front_default: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    var type: Species
}

// MARK: - Species
struct Species: Codable {
    var name: String
}

