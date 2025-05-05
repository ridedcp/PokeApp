//
//  HomeAssembler.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import UIKit

final class HomeBuilder {
    static func build() -> UIViewController {
        let apiService = PokemonApiService()
        let remoteDataSource = PokemonRemoteDataSource(service: apiService)
        let repository = PokemonRepository(remoteDataSource: remoteDataSource)
        let usecase = GetPokemonListUseCase(repository: repository)
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController, usecase: usecase)
        viewController.presenter = presenter

        return viewController
    }
}
