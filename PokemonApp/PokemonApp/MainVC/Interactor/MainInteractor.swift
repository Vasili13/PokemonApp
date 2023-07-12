//
//  MainInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - MainInteractorInputProtocol
protocol MainInteractorInputProtocol {
    init(presenter: MainInteractorOutputProtocol)
    func fetchPokemonList()
    func getImageURL(_ url: String)
}

// MARK: - MainInteractorOutputProtocol
protocol MainInteractorOutputProtocol: AnyObject {
    func pokemonListFetched(_ pokemonList: [Pokemon])
    func getDetails(pokemon: [DetailPokemon])
}

// MARK: - MainInteractor
final class MainInteractor: MainInteractorInputProtocol {

    unowned let presenter: MainInteractorOutputProtocol
    private var firstData: Pokemon?
    
    private var pokemonList: [Pokemon] = []
    
    private var detailPokemonList: [DetailPokemon] = []
    
    private var nextPageURL: String?
    private var isFetching = false


    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getImageURL(_ url: String) {
        Network().getPokemonInfo(url: url) { result in
            guard let urlString = result.sprites?.front_default else { return }
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else { return }
//                    self.presenter.pokemonImageURL(data: data)
                }
                task.resume()
            }
        }
    }

    func fetchPokemonList() {
        guard !isFetching else { return }

        isFetching = true

        guard let url = URL(string: nextPageURL ?? APIConstants().pokemonPath) else { return }

            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                defer { self?.isFetching = false }

                guard let data = data, error == nil else {
                    print("Error fetching pokemon list:", error?.localizedDescription ?? "")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    
                    let result = response.results.compactMap { pok in
                        pok.url
                    }
                    
                    for url in result {
                        guard let url = URL(string: url) else  { return }

                        URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data else { return }
                            let response = try! JSONDecoder().decode(DetailPokemon.self, from: data)
                            
                            self?.detailPokemonList.append(response)

                            self?.presenter.getDetails(pokemon: self?.detailPokemonList ?? [])
                        }.resume()
                    }
                    
                    
                    
                    self?.pokemonList += response.results
                    self?.nextPageURL = response.next
                    DispatchQueue.main.async {
                        self?.presenter.pokemonListFetched(self?.pokemonList ?? [])
                    }
                } catch {
                    print("Error decoding pokemon list:", error.localizedDescription)
                }
            }

            task.resume()
        }
}
