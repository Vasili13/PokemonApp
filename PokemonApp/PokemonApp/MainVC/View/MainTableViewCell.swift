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
        lbl.font = .systemFont(ofSize: Constants.General.size, weight: .bold)
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
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        pokemonTitleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(16)
            $0.height.equalTo(70)
            $0.width.equalTo(contentView.frame.size.width - 170)
        }
        
        pokemonImageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(145)
            $0.height.equalTo(130)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonTitleLbl.text = nil
        pokemonImageView.image = nil
    }
}
