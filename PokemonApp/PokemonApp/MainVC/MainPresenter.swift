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
    
    func openCV(pok: Pokemon) {
//        router.openVC(with: pok)
        print(pok, "pres")
        router?.showNextViewController(data1: pok)
    }
//
//    func didSelectRow(data: Pokemon) {
//
//    }

}

//extension MainPresenter: YourViewDelegate {
//    func didSelectRow(data: Pokemon) {
//        didSelectRow(data: data)
//    }
//    func didSelectRow1(data: Pokemon) {
//        didSelectRow(data: data)
//    }
//}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func receiveFirstData(array: [Pokemon]) {
        viewController.setValue(value: array)
    }
}
