//
//  DescriptionConfigurator.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - DescriptionConfiguratorInputProtocol
protocol DescriptionConfiguratorInputProtocol {
    func configure(with viewController: DescriptionViewController)
}

// MARK: - DescriptionConfigurator
final class DescriptionConfigurator: DescriptionConfiguratorInputProtocol {
    
    func configure(with view: DescriptionViewController) {
        let presenter = DescriptionPresenter(view: view)
        let interactor = DescriptionInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
