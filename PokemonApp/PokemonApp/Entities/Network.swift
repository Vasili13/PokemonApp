//
//  Network.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 23.06.23.
//

import Foundation

class Network {
    
    static func fetchArticles(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getPokemonInfo(url: String, completion: @escaping ((DetailPokemon) -> ())) {
        guard let url = URL(string: url) else {
            return
        }
            
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let pokemonInfo = try! JSONDecoder().decode(DetailPokemon.self, from: data)
                
            DispatchQueue.main.async {
                completion(pokemonInfo)
            }
        }.resume()
    }
}
