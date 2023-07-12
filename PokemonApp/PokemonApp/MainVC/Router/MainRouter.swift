//
//  MainRouter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation
import UIKit

// MARK: - MainRouterInputProtocol
protocol MainRouterInputProtocol {
    init(viewController: MainViewController)
    func showNextViewController(data: Pokemon)
    func showNextViewControllerDB(data: DBPokemon)
}

// MARK: - MainRouter
final class MainRouter: MainRouterInputProtocol {

    unowned let viewController: MainViewController
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    //make transition to next vc
    func showNextViewController(data: Pokemon) {
        guard let descriptionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DescriptionViewController") as? DescriptionViewController else { return }
        descriptionVC.data = data
        viewController.navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
    func showNextViewControllerDB(data: DBPokemon) {
//        guard let descriptionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DescriptionViewController") as? DescriptionViewController else { return }
//        descriptionVC.dataDB = data
//        viewController.navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
}
