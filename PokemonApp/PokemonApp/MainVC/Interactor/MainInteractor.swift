//
//  MainInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - MainInteractorInputProtocol
protocol MainInteractorInputProtocol {
    init(presenter: MainInteractorOutputProtocol)
    func provideFirstData()
}

// MARK: - MainInteractorOutputProtocol
protocol MainInteractorOutputProtocol: AnyObject {
    func receiveFirstData(array: [Pokemon])
}

// MARK: - MainInteractor
class MainInteractor: MainInteractorInputProtocol {

    unowned let presenter: MainInteractorOutputProtocol
    private var firstData: Pokemon?

    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }

    //fetch data to tableView
    func provideFirstData() {        
        Network.fetchGeneralInfo { [weak self] result in
            switch result {
            case.success(let array):
                self?.presenter.receiveFirstData(array: array)
            case.failure(let error):
                let error = error
            }
        }
    }
}
