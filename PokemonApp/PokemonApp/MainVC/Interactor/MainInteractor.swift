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
    func provideFirstData()
    func fetchPokemonList()
}

// MARK: - MainInteractorOutputProtocol
protocol MainInteractorOutputProtocol: AnyObject {
    func receiveFirstData(array: [Pokemon])
    func pokemonListFetched(_ pokemonList: [Pokemon])
}

// MARK: - MainInteractor
final class MainInteractor: MainInteractorInputProtocol {

    unowned let presenter: MainInteractorOutputProtocol
    private var firstData: Pokemon?
    
    private var pokemonList: [Pokemon] = []
    
        private var nextPageURL: String?
        private var isFetching = false


    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func fetchPokemonList() {
            guard !isFetching else { return }
            
            isFetching = true
            
            guard let url = URL(string: nextPageURL ?? "https://pokeapi.co/api/v2/pokemon") else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                defer { self?.isFetching = false }
                
                guard let data = data, error == nil else {
                    print("Error fetching pokemon list:", error?.localizedDescription ?? "")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    
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

    
    //fetch data to tableView
    func provideFirstData() {        
//        Network.fetchGeneralInfo { [weak self] result in
//            switch result {
//            case.success(let array):
//                self?.presenter.receiveFirstData(array: array)
//            case.failure(let error):
//                let error = error
//            }
//        }
    }
}
