//
//  APIConstants.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 4.07.23.
//

import Foundation

final class APIConstants {
    static let serverPath = "https://pokeapi.co/api/v2/"
    static let pokemonPath = serverPath + "pokemon/"
    static let pokemonPathLimit = pokemonPath + "?limit=20&offset=20"
}
