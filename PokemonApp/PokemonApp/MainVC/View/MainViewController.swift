//
//  ViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 21.06.23.
//

import UIKit
import SnapKit

// MARK: - MainViewInputProtocol
protocol MainViewInputProtocol: AnyObject {
    func setValue(value: [Pokemon])
}

// MARK: - MainViewOutputProtocol
protocol MainViewOutputProtocol {
    init(viewController: MainViewInputProtocol)
    func provideFirstData()
    func openNextVC(pokemon: Pokemon)
}

// MARK: - MainViewController
class MainViewController: UIViewController {
    
    lazy var pokemonTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.key)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private var arrayOfPokemons: [Pokemon] = []

    var presenter: MainViewOutputProtocol!
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        view.addSubview(pokemonTableView)
        
        configurateNavBar()
        provideFirstData()
        
        updateViewConstraints()
    }
    
    func configurateNavBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "pokemonLogo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    func provideFirstData() {
        presenter.provideFirstData()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        pokemonTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}

// MARK: - TableView extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {fatalError()}
        cell.pokemonTitleLbl.text = arrayOfPokemons[indexPath.row].name.capitalized
        
// TODO: - Do it in Interactor
        Network().getPokemonInfo(url: arrayOfPokemons[indexPath.row].url) { result in
            guard let urlStr = result.sprites?.front_default else { return }
            if let url = URL(string: urlStr) {
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        let image = UIImage(data: data)
                        cell.pokemonImageView.image = image
                    }
                }
                task.resume()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = arrayOfPokemons[indexPath.row].self
        presenter.openNextVC(pokemon: pokemon)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - extension MainViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func setValue(value: [Pokemon]) {
        arrayOfPokemons = value
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
}
