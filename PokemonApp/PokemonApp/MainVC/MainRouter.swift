//
//  MainRouter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation
import UIKit

protocol MainRouterInputProtocol {
    init(viewController: MainViewController)
//    func openVC(with secondData: Pokemon)
    func showNextViewController(data1: Pokemon)
}

class MainRouter: MainRouterInputProtocol {

    unowned let viewController: MainViewController
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
//    func openVC(with secondData: Pokemon) {
//        viewController.performSegue(withIdentifier: "Show", sender: secondData)
//    }
    
    func showNextViewController(data1: Pokemon) {
        print(data1, "Data")
        
        guard let descrVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DescriptionViewController") as? DescriptionViewController else { return }
        
        descrVc.data = data1
        
//        nextVC.data = data
        viewController.navigationController?.pushViewController(descrVc, animated: true)
    }
    
}
