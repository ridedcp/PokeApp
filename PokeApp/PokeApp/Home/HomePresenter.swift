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

    private var isFetching = false
    private var offset = 0
    private let pageSize = 40

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
        guard !isFetching else { return }
        isFetching = true

        usecase.execute(offset: offset, limit: pageSize) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false

            switch result {
            case .success(let newPokemons):
                self.pokemons.append(contentsOf: newPokemons)
                self.offset += self.pageSize
                DispatchQueue.main.async {
                    self.view?.loadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
