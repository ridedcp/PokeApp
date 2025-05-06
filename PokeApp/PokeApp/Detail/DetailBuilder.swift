//
//  DetailBuilder.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import UIKit

class DetailBuilder {
    static func build(id: Int) -> UIViewController {
        let apiService = PokemonApiService()
        let remoteDataSource = PokemonDetailRemoteDataSource(service: apiService)
        let repository = PokemonDetailRepository(remoteDataSource: remoteDataSource)
        let useCase = GetPokemonDetailUseCase(repository: repository)
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController, useCase: useCase)
        viewController.presenter = presenter
        presenter.fetchDetail(id: id)
        
        return viewController
    }
}
