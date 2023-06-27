//
//  MainPresenter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - MainPresenter
class MainPresenter: MainViewOutputProtocol {
    
    unowned let viewController: MainViewInputProtocol
    
    var interactor: MainInteractorInputProtocol!
    var router: MainRouterInputProtocol!
    
    required init(viewController: MainViewInputProtocol) {
        self.viewController = viewController
    }
    
    func provideFirstData() {
        interactor.provideFirstData()
    }
    
    func openNextVC(pokemon: Pokemon) {
        router?.showNextViewController(data: pokemon)
    }

}

// MARK: - extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {

    //pass data to MainVC
    func receiveFirstData(array: [Pokemon]) {
        viewController.setValue(value: array)
    }
}
