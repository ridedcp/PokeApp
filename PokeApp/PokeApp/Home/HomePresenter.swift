//
//  HomePresenter.swift
//  PokeApp
//
//  Created by Daniel Cano on 29/4/25.
//

import Foundation

protocol HomePresenterProtocol {
    var pokemons: [Pokemon] { get set }
    
    func numberOfPokemons() -> Int
    func item(at index: Int) -> Pokemon
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeView?
    var pokemons: [Pokemon]
    private let usecase: GetPokemonListUseCaseProtocol
    
    init(view: HomeView, usecase: GetPokemonListUseCaseProtocol) {
        self.view = view
        self.usecase = usecase
        self.pokemons = []
        fetchPokemons()
    }
    
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func item(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    func fetchPokemons() {
        usecase.execute(offset: 0, limit: 40) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.view?.loadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
