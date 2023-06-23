//
//  MainConfigurator.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

protocol MainConfiguratorInputProtocol {
    func configure(with viewController: MainViewController)
}

class MainConfigurator: MainConfiguratorInputProtocol {
    
    func configure(with viewController: MainViewController) {
        //пунктирные линии
        let presenter = MainPresenter(viewController: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: viewController)

        //прямые связи
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
