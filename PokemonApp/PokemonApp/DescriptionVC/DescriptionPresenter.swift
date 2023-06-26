//
//  DescriptionPresenter.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

class DescriptionPresenter: DesciptionViewOutputProtocol {
    
    unowned let view: DesciptionViewInputProtocol
    var interactor: DesciptionInteractorInputProtocol!
    
    required init(view: DesciptionViewInputProtocol) {
        self.view = view
    }
    
    func showData() {
//        interactor.provideSecondData()
        
    }
}

extension DescriptionPresenter: DesciptionInteractorOutputProtocol {
    func receiveSecondData(array secondData: Pokemon) {
        let data = secondData.name
        view.setValue(data)
    }
}
