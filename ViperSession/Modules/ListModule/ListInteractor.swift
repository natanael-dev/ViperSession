//
//  ListInteractor.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import Foundation

// MARK: Define
typealias ListInteractorProtocols = ListInteractorAccess & ListPresenterToInteractor
protocol ListInteractorAccess {
    var presenter: ListInteractorToPresenter? { get set }
}

protocol ListPresenterToInteractor {
    func getPokemon()
}

// MARK: Implement
class ListInteractor: ListInteractorAccess {
    weak var presenter: ListInteractorToPresenter?
    fileprivate let api = PokemonAPI()
}

extension ListInteractor: ListPresenterToInteractor {
    func getPokemon(){
        let request = ListEntity.PokemonRequest(limit: 151)
        api.pokemonInfo(request: request) {[weak self] result in
            switch result {
            case .success(let pokemons):
                self?.presenter?.sucessPokemon(pokemons: pokemons.results)
            case .failure(let error):
                self?.presenter?.errorPokemon(message: error.localizedDescription)
            }
        }
    }
}
