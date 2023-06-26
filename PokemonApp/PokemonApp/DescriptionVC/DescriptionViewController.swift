//
//  DescriptionViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import UIKit

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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokImageView: UIImageView!
    var presenter: DesciptionViewOutputProtocol!
    
    var data: Pokemon?
    
    private var configurator: DescriptionConfiguratorInputProtocol = DescriptionConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.showData()
//        guard let pok = pok else { return }
//        configurator.configure(with: self, and: pok)
//        print(data, "desjnsdfkvhkfsjhkfjshkj")
//        nameLabel.text = data?.name
        showsdfds()
        configurator.configure(with: self)
        presenter.handleStringValue(data?.url ?? "Str")
    }
    
    func showsdfds() {
        guard let data = data else { return }
        
        print(data.name)
        nameLabel.text = data.name.capitalized
    }
    
    deinit {
        print("deinit")
    }
}

extension DescriptionViewController: DesciptionViewInputProtocol {
    func setValue(_ value: DetailPokemon) {
        nameLabel.text = value.id.description
        
        guard let url = value.sprites?.front_default else { return }
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    let image = UIImage(data: data)
                    self.pokImageView.image = image
                }
            }
            task.resume()
        }
    }
}
