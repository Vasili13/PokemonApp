//
//  DescriptionInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: -
protocol DesciptionInteractorInputProtocol {
    init(presenter: DesciptionInteractorOutputProtocol)
    func getURL(stringURL: String)
}

// MARK: -
protocol DesciptionInteractorOutputProtocol: AnyObject {
    func receiveSecondData(arrayOfDetails: DetailPokemon)
}

final class DescriptionInteractor: DesciptionInteractorInputProtocol {
    
    unowned let presenter: DesciptionInteractorOutputProtocol

    required init(presenter: DesciptionInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    //get URL of pokemon ID and pass back results of DetailPokemon
    func getURL(stringURL: String) {
        Network().getPokemonInfo(url: stringURL) { result in
            self.presenter.receiveSecondData(arrayOfDetails: result)
        }
    }
}
