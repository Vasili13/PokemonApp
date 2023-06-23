//
//  ViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 21.06.23.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    func setValue()
}

protocol MainViewOutputProtocol {
    init(viewController: MainViewInputProtocol)
    func showInfo()
}

class MainViewController: UIViewController {
    
    let array: [Pokemon] = []

    var presenter: MainViewOutputProtocol!

    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        configurator.configure(with: self)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}



extension MainViewController: MainViewInputProtocol {
    func setValue() {
    }
}
