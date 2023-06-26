//
//  DescriptionViewController.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 22.06.23.
//

import UIKit

protocol DesciptionViewInputProtocol: AnyObject {
    func setValue(_ value: String)
}

protocol DesciptionViewOutputProtocol {
    init(view: DesciptionViewInputProtocol)
    func showData()
}

class DescriptionViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
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
    func setValue(_ value: String) {
        nameLabel.text = value
    }
}
