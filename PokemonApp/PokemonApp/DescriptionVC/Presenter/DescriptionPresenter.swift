//
//  DescriptionPresenter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

// MARK: - DescriptionPresenter
class DescriptionPresenter: DesciptionViewOutputProtocol {
    
    unowned let view: DesciptionViewInputProtocol
    var interactor: DesciptionInteractorInputProtocol!
    
    required init(view: DesciptionViewInputProtocol) {
        self.view = view
    }
    
    func handleStringValue(_ string: String) {
        interactor.getURL(stringURL: string)
    }
}

// MARK: - DescriptionPresenter Extension
extension DescriptionPresenter: DesciptionInteractorOutputProtocol {
    func receiveSecondData(arrayOfDetails: DetailPokemon) {
        view.setValue(arrayOfDetails)
    }
}
