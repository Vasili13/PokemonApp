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
    func getURL(string: String)
}

//for presenter
protocol DesciptionInteractorOutputProtocol: AnyObject {
    func receiveSecondData(array: DetailPokemon)
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
    
    func getURL(string: String) {
        print(string, "Inter")
        Network().getPokemonInfo(url: string) { result in
            guard let urlStr = result.sprites?.front_default else { return }
            print(urlStr)
            
            self.presenter.receiveSecondData(array: result)
        }
    }
}
