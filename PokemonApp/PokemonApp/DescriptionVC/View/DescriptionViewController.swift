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
    func handleStringValueFromDB(_ string: String)
}

// MARK: - DescriptionViewController
final class DescriptionViewController: UIViewController {
    
    private lazy var pokemonNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.largerFontSize, weight: .bold)
        return lbl
    }()
    
    private lazy var pokemonFrontImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constants.ImageView.largeCornerRadius
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var pokemonTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .bold)
        lbl.text = "Type:"
        return lbl
    }()
    
    private lazy var pokemonWeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .bold)
        lbl.text = "Weight:"
        return lbl
    }()
    
    private lazy var pokemonHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .bold)
        lbl.text = "Height:"
        return lbl
    }()
    
    private lazy var receivedTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .medium)
        return lbl
    }()
    
    private lazy var receivedHeightLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .medium)
        return lbl
    }()
    
    private lazy var receivedWeigthLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: Constants.Fonts.smallerFontSize, weight: .medium)
        return lbl
    }()
    
    var presenter: DesciptionViewOutputProtocol?
    
    var data: Pokemon?
    var dataDB: DBPokemon?
    
    private var configurator: DescriptionConfiguratorInputProtocol = DescriptionConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewsList = [pokemonNameLabel, pokemonFrontImageView, pokemonTypeLabel, pokemonWeightLabel, pokemonHeightLabel, pokemonTypeLabel, receivedTypeLabel, receivedWeigthLabel, receivedHeightLabel]
        view.addViewsToMainView(viewsList)
        
        configurator.configure(with: self)
        
        //pass data to fetch details of all Pokemons
        presenter?.handleStringValue(data?.url ?? "Pokemon")
        presenter?.handleStringValueFromDB(dataDB?.url ?? "Pokemon")
        makeConstraints()
    }
    
    private func makeConstraints() {
        pokemonNameLabel.snp.makeConstraints {
            $0.top.equalTo(Constants.DistanceToTheTop.largestTopMargin)
            $0.centerX.equalToSuperview()
        }
        
        pokemonFrontImageView.snp.makeConstraints {
            $0.top.equalTo(pokemonNameLabel).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(Constants.ImageView.largeImageHeightAndWidth)
        }
        
        pokemonTypeLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonFrontImageView.snp.bottom).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.left.equalToSuperview().offset(Constants.SideIndent.commonIndent)
        }

        pokemonWeightLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonTypeLabel).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.left.equalToSuperview().offset(Constants.SideIndent.commonIndent)
        }

        pokemonHeightLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonWeightLabel).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.left.equalToSuperview().offset(Constants.SideIndent.commonIndent)
        }

        receivedTypeLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonFrontImageView.snp.bottom).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.right.equalToSuperview().inset(Constants.SideIndent.commonIndent)
        }

        receivedWeigthLabel.snp.makeConstraints {
            $0.top.equalTo(receivedTypeLabel).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.right.equalToSuperview().inset(Constants.SideIndent.commonIndent)
        }

        receivedHeightLabel.snp.makeConstraints {
            $0.top.equalTo(receivedWeigthLabel).offset(Constants.DistanceToTheTop.commonTopMargin)
            $0.right.equalToSuperview().inset(Constants.SideIndent.commonIndent)
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
            ImageCache.shared.loadImage(fromURL: url) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.pokemonFrontImageView.image = image
                    } else {
                        print("ERROR")
                    }
                }
            }
            
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
