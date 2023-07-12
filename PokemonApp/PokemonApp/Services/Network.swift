//
//  Network.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 23.06.23.
//

import Foundation

// MARK: - Network
class Network {
    func getPokemonInfo(url: String, completion: @escaping ((DetailPokemon) -> ())) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let pokemonInfo = try JSONDecoder().decode(DetailPokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(pokemonInfo)
                }
            } catch(let error) {
                let error = error
            }
        }.resume()
    }
}
