//
//  APIConstants.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 4.07.23.
//

import Foundation

protocol NetworkRouter {
    var serverPath: String { get }
    var pokemonPath: String { get }
    var pokemonPathLimit: String { get }
}

final class APIConstants: NetworkRouter {
    
    var serverPath: String {
        return "https://pokeapi.co/api/v2/"
    }
    
    var pokemonPath: String {
        return serverPath + "pokemon/"
    }
    
    var pokemonPathLimit: String {
        return pokemonPath + "?limit=20&offset=20"
    }
}
