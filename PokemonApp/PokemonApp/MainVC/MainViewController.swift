//
//  ViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 21.06.23.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    func setValue(value: [Pokemon])
}

protocol MainViewOutputProtocol {
    init(viewController: MainViewInputProtocol)
    func showInfo()
    func openCV(pok: Pokemon)
}

class MainViewController: UIViewController {
    
    var array: [Pokemon] = []

    var presenter: MainViewOutputProtocol!

    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        configurator.configure(with: self)
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "pokemonLogo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        tryToDo()
    }
    
    func tryToDo() {
        presenter.showInfo()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].name.capitalized
        cell.detailTextLabel?.text = array[indexPath.row].url
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = array[indexPath.row].self
        print(pokemon)
//        delegate?.didSelectRow1(data: pokemon)
        presenter.openCV(pok: pokemon)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: MainViewInputProtocol {
    
    func setValue(value: [Pokemon]) {
        array = value
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
}
