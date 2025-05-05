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
    var pokemons: [Pokemon] = []
    private var allPokemons: [Pokemon] = []
    private let usecase: GetPokemonListUseCaseProtocol

    private var query: String = ""
    private var offset = 0
    private let pageSize = 40
    private var totalCount = 1302

    init(view: HomeView, usecase: GetPokemonListUseCaseProtocol) {
        self.view = view
        self.usecase = usecase
        fetchPokemons()
    }
    
    func numberOfPokemons() -> Int {
        return pokemons.count
    }
    
    func item(at index: Int) -> Pokemon {
        return pokemons[index]
    }
    
    func fetchPokemons() {
        guard offset < totalCount else { return }

        usecase.execute(offset: offset, limit: pageSize) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fetched):
                self.offset += fetched.count
                self.allPokemons.append(contentsOf: fetched)
                
                if self.query.isEmpty {
                    self.pokemons = self.allPokemons
                } else {
                    self.pokemons = self.allPokemons.filter {
                        $0.name.lowercased().hasPrefix(self.query) == true
                    }
                }
                
                DispatchQueue.main.async {
                    self.view?.loadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func filterPokemons(with query: String) {
        let normalizedQuery = query.normalized
        guard normalizedQuery != self.query else { return }

        self.query = normalizedQuery

        if normalizedQuery.isEmpty {
            pokemons = allPokemons
        } else {
            pokemons = allPokemons.filter {
                $0.name.normalized.hasPrefix(normalizedQuery) == true
            }
        }

        view?.loadData()
    }
}
