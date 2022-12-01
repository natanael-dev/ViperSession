//
//  DetailInteractor.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 29/11/22.
//

import Foundation

// MARK: Define
typealias DetailInteractorProtocols = DetailInteractorAccess & DetailPresenterToInteractor
protocol DetailInteractorAccess {
    var presenter: DetailInteractorToPresenter? { get set }
}

protocol DetailPresenterToInteractor {
    func getAbility(withPokemonId id: String)
}

// MARK: Implement
class DetailInteractor: DetailInteractorAccess {
    var presenter: DetailInteractorToPresenter?
    fileprivate let api = PokemonAPI()
}

extension DetailInteractor: DetailPresenterToInteractor {
    func getAbility(withPokemonId id: String){
        let request = DetailEntity.AbilityRequest(pokemonId: id)
        api.pokemonAbility(with: request) {[weak self] result in
            switch result {
            case .success(let ability):
                self?.presenter?.sucessAbility(ability: ability)
            case .failure(let error):
                self?.presenter?.errorAbility(message: error.localizedDescription)
            }
        }
    }    
}
