//
//  MainInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

//class NewsTableViewCellViewModel {
//    let name: String
//    let url: String
//    
//    init(name: String, url: String) {
//        self.name = name
//        self.url = url
//    }
//}

protocol MainInteractorInputProtocol {
    init(presenter: MainInteractorOutputProtocol)
    func provideFirstData()
}

//for presenter
protocol MainInteractorOutputProtocol: AnyObject {
    func receiveFirstData(array: [Pokemon])
//    func openSecondVC(secondData: SecondPokemon)
}

class MainInteractor: MainInteractorInputProtocol {

    unowned let presenter: MainInteractorOutputProtocol
    private var firstData: Pokemon?

    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func provideFirstData() {        
        Network.fetchArticles { [weak self] result in
            switch result {
            case.success(let array):
                self?.presenter.receiveFirstData(array: array)
            case.failure(let error):
                print(error)
            }
        }
    }

}
