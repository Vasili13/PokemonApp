//
//  Extension + UIView.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 5.07.23.
//

import Foundation
import UIKit

extension UIView {
    func addViewsToMainView(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
