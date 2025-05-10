//
//  DetailPresenter.swift
//  PokeApp
//
//  Created by Daniel Cano on 5/5/25.
//

import Foundation

class DetailPresenter {
    
    private weak var view: DetailView?
    private let useCase: GetPokemonDetailUseCase

    init(view: DetailView, useCase: GetPokemonDetailUseCase) {
        self.view = view
        self.useCase = useCase
    }

    func fetchDetail(id: Int) {
        useCase.execute(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self?.view?.show(detail: detail)
                case .failure(let error):
                    self?.view?.showError("Failed to load details: \(error.localizedDescription)")
                }
            }
        }
    }
}
