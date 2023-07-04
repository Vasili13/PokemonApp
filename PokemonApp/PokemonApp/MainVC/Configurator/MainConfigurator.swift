//
//  MainConfigurator.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - MainConfiguratorInputProtocol
protocol MainConfiguratorInputProtocol {
    func configure(with viewController: MainViewController)
}

// MARK: - MainConfigurator
final class MainConfigurator: MainConfiguratorInputProtocol {
    
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter(viewController: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
