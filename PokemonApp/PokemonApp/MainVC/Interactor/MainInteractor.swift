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
}

// MARK: - MainInteractorOutputProtocol

protocol MainInteractorOutputProtocol: AnyObject {
    func pokemonListFetched(_ pokemonList: [Pokemon])
}

// MARK: - MainInteractor

final class MainInteractor: MainInteractorInputProtocol {
    unowned let presenter: MainInteractorOutputProtocol
    private var firstData: Pokemon?

    private var pokemonList: [Pokemon] = []

    var names: [String] = []
    var urls: [String] = []
    
    
    private var nextPageURL: String?
    private var isFetching = false

    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func fetchPokemonList() {
        guard !isFetching else { return }

        isFetching = true

        guard let url = URL(string: nextPageURL ?? APIConstants().pokemonPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            defer { self?.isFetching = false }

            guard let data = data, error == nil else {
                print("Error fetching pokemon list:", error?.localizedDescription ?? "")
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)

                self?.pokemonList += response.results
                self?.nextPageURL = response.next

                response.results.forEach { result in
                    self?.names.append(result.name)
                    self?.urls.append(result.url)
                }

                CoreDataHelper.shared.savePokemons(names: self?.names ?? [], urls: self?.urls ?? [])

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
