//
//  DescriptionViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import UIKit
import SnapKit

protocol DesciptionViewInputProtocol: AnyObject {
    func setValue(_ value: DetailPokemon)
}

protocol DesciptionViewOutputProtocol {
    init(view: DesciptionViewInputProtocol)
    func showData()
    func handleStringValue(_ string: String)
//    func sendStringToInteractor()
}

class DescriptionViewController: UIViewController {
    
    lazy var pokemonNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        return lbl
    }()
    
    lazy var pokemonFrontImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var pokemonTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type:"
        return lbl
    }()
    
    lazy var pokemonWeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Weight:"
        return lbl
    }()
    
    lazy var pokemonHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Height:"
        return lbl
    }()
    
    lazy var receivedTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    lazy var receivedHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    lazy var receivedWeigthLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
//    @IBOutlet weak var nameLabel: UILabel!
    
//    @IBOutlet weak var pokImageView: UIImageView!
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
        
//        presenter.showData()
//        guard let pok = pok else { return }
//        configurator.configure(with: self, and: pok)
//        print(data, "desjnsdfkvhkfsjhkfjshkj")
//        nameLabel.text = data?.name
        showsdfds()
        configurator.configure(with: self)
        presenter.handleStringValue(data?.url ?? "Str")
        
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
    
    func showsdfds() {
        guard let data = data else { return }
        
        print(data.name)
//        nameLabel.text = data.name.capitalized
    }
    
    deinit {
        print("deinit")
    }
}

extension DescriptionViewController: DesciptionViewInputProtocol {
    func setValue(_ value: DetailPokemon) {
//        var b = ""
//
//        let typeName = value.types.map { res in
//            b = res.type.name
//        }
        
        let typeName = value.types.map { $0.type.name }
        
//        nameLabel.text = value.id.description
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
//                    self.pokImageView.image = image
                    self.pokemonFrontImageView.image = image
                }
            }
            task.resume()
        }
    }
}
