//
//  HomeAssembler.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import UIKit

final class HomeBuilder {
    static func build() -> UIViewController {
        let presenter = HomePresenter()
        let viewController = HomeViewController()
        viewController.presenter = presenter
        return viewController
    }
}
