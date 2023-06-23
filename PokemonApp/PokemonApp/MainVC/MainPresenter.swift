//
//  MainPresenter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

class MainPresenter: MainViewOutputProtocol {
    
    unowned let viewController: MainViewInputProtocol
    
    var interactor: MainInteractorInputProtocol!
    var router: MainRouterInputProtocol!
    
    required init(viewController: MainViewInputProtocol) {
        self.viewController = viewController
    }
    
    func showInfo() {
        interactor.provideFirstData()
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func receiveFirstData(array: [Pokemon]) {
        viewController.setValue(value: array)
    }
}
