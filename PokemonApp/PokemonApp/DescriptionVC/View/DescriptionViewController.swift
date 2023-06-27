//
//  DescriptionViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import UIKit
import SnapKit

// MARK: - DesciptionViewInputProtocol
protocol DesciptionViewInputProtocol: AnyObject {
    func setValue(_ value: DetailPokemon)
}

// MARK: - DesciptionViewOutputProtocol
protocol DesciptionViewOutputProtocol {
    init(view: DesciptionViewInputProtocol)
    func handleStringValue(_ string: String)
}

// MARK: - DescriptionViewController
class DescriptionViewController: UIViewController {
    
    lazy var pokemonNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    
    lazy var pokemonFrontImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var pokemonTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Type:"
        return lbl
    }()
    
    lazy var pokemonWeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Weight:"
        return lbl
    }()
    
    lazy var pokemonHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Height:"
        return lbl
    }()
    
    lazy var receivedTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    
    lazy var receivedHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    
    lazy var receivedWeigthLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    
    var presenter: DesciptionViewOutputProtocol!
    
    var data: Pokemon?
    
    private var configurator: DescriptionConfiguratorInputProtocol = DescriptionConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonFrontImageView)
        view.addSubview(pokemonTypeLabel)
        view.addSubview(pokemonWeightLabel)
        view.addSubview(pokemonHeightLabel)
        view.addSubview(receivedTypeLabel)
        view.addSubview(receivedWeigthLabel)
        view.addSubview(receivedHeightLabel)
        
        configurator.configure(with: self)
        
        //pass data to fetch details of all Pokemons
        presenter.handleStringValue(data?.url ?? "Pokemon")
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        pokemonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        pokemonFrontImageView.snp.makeConstraints { make in
            make.top.equalTo(pokemonNameLabel).offset(40)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        pokemonTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonFrontImageView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }

        pokemonWeightLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonTypeLabel).offset(50)
            make.left.equalToSuperview().offset(20)
        }

        pokemonHeightLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonWeightLabel).offset(50)
            make.left.equalToSuperview().offset(20)
        }

        receivedTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonFrontImageView.snp.bottom).offset(50)
            make.right.equalToSuperview().inset(20)
        }

        receivedWeigthLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedTypeLabel).offset(50)
            make.right.equalToSuperview().inset(20)
        }

        receivedHeightLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedWeigthLabel).offset(50)
            make.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - extension DescriptionViewController
extension DescriptionViewController: DesciptionViewInputProtocol {
    func setValue(_ value: DetailPokemon) {
        let typeName = value.types.map { $0.type.name }
        pokemonNameLabel.text = value.name.capitalized
        receivedTypeLabel.text = typeName.first?.capitalized
        receivedWeigthLabel.text = value.weight.description.capitalized
        receivedHeightLabel.text = value.height.description.capitalized
        
        guard let url = value.sprites?.front_default else { return }
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    let image = UIImage(data: data)
                    self.pokemonFrontImageView.image = image
                }
            }
            task.resume()
        }
    }
}
