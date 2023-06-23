//
//  MainInteractor.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import Foundation

protocol MainInteractorInputProtocol {
    init(presenter: MainInteractorOutputProtocol)
    func provideFirstData()
}

//for presenter
protocol MainInteractorOutputProtocol: AnyObject {
    func receiveFirstData()
}

class MainInteractor: MainInteractorInputProtocol {

    unowned let presenter: MainInteractorOutputProtocol

    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func provideFirstData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print(error)
            }

            guard let data = data else { return }

            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                print(res)
                
                self?.presenter.receiveFirstData()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
