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
    func showPokemonList(_ pokemonList1: [Pokemon])
    func showDetailPokemon(detailPokemon: [DetailPokemon])
}

// MARK: - MainViewOutputProtocol
protocol MainViewOutputProtocol {
    init(viewController: MainViewInputProtocol)
    func openNextVC(pokemon: Pokemon)
    func provideImageURL(_ url: String)
    func viewCreated()
    func loadMorePokemon()
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    private let pokemonTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.key)
        return table
    }()
    
    private var pokemonList: [Pokemon] = []
    
    private var detailedPokemonList: [DetailPokemon] = []

    var presenter: MainViewOutputProtocol?
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        view.addSubview(pokemonTableView)
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        configurateNavBar()
        presenter?.viewCreated()
        makeConstraints()
        
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    private func configurateNavBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "pokemonLogo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func makeConstraints() {
        pokemonTableView.snp.makeConstraints {
            $0.height.width.equalToSuperview()
        }
    }
}

// MARK: - TableView extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {fatalError()}

        cell.configure(pokemonUrl: self.pokemonList[indexPath.row].url, pokemonName: self.pokemonList[indexPath.row].name)
        
        presenter?.provideImageURL(pokemonList[indexPath.row].url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemonList[indexPath.row].self
        presenter?.openNextVC(pokemon: pokemon)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        self.pokemonTableView.tableFooterView = createSpinnerFooter()
        if offsetY > contentHeight - scrollView.frame.height {
            presenter?.viewCreated()
            self.pokemonTableView.tableFooterView = nil
            pokemonTableView.reloadData()
        }
    }
}

// MARK: - extension MainViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func showDetailPokemon(detailPokemon: [DetailPokemon]) {
        print(detailPokemon)
        detailedPokemonList = detailPokemon
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
        
    }
    
    func showPokemonList(_ pokemonList1: [Pokemon]) {
        pokemonList = pokemonList1
        pokemonTableView.reloadData()
    }
}
