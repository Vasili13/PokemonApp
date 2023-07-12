//
//  MainPresenter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - MainPresenter
final class MainPresenter: MainViewOutputProtocol {
    
    unowned let viewController: MainViewInputProtocol
    
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterInputProtocol?
    
    required init(viewController: MainViewInputProtocol) {
        self.viewController = viewController
    }
    
    func openNextVC(pokemon: Pokemon) {
        router?.showNextViewController(data: pokemon)
    }
    
    func provideImageURL(_ url: String) {
        interactor?.getImageURL(url)
    }
    
    func viewCreated() {
        interactor?.fetchPokemonList()
    }
        
    func loadMorePokemon() {
        interactor?.fetchPokemonList()
    }
}

// MARK: - extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func getDetails(pokemon: [DetailPokemon]) {
        viewController.showDetailPokemon(detailPokemon: pokemon)
    }
    
    func pokemonListFetched(_ pokemonList: [Pokemon]) {
        viewController.showPokemonList(pokemonList)
    }
}
