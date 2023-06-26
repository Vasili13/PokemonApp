//
//  DescriptionInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

protocol DesciptionInteractorInputProtocol {
    init(presenter: DesciptionInteractorOutputProtocol)
    func provideSecondData()
}

//for presenter
protocol DesciptionInteractorOutputProtocol: AnyObject {
    func receiveSecondData(array: Pokemon)
}

class DescriptionInteractor: DesciptionInteractorInputProtocol {
    
    unowned let presenter: DesciptionInteractorOutputProtocol
//    private let secondData: Pokemon
    
    
    required init(presenter: DesciptionInteractorOutputProtocol) {
        self.presenter = presenter
//        self.secondData = secondData
    }
    
    func provideSecondData() {
//        presenter.receiveSecondData(array: secondData)
    }
    
}
