//
//  MainTableViewCell.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 27.06.23.
//

import UIKit
import SnapKit

// MARK: - MainTableViewCell
class MainTableViewCell: UITableViewCell {

    static let key = "MainTableViewCell"

    lazy var pokemonTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokemonTitleLbl)
        contentView.addSubview(pokemonImageView)
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        pokemonTitleLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
            make.height.equalTo(70)
            make.width.equalTo(contentView.frame.size.width - 170)
        }
        
        pokemonImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(130)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonTitleLbl.text = nil
        pokemonImageView.image = nil
    }
}
