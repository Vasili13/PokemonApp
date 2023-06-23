//
//  MainRouter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

protocol MainRouterInputProtocol {
    init(viewController: MainViewController)
    func openDescriptionVC()
}

class MainRouter: MainRouterInputProtocol {

    unowned let viewController: MainViewController
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func openDescriptionVC() {
        let a = 1
    }
}
