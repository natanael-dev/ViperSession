//
//  DetailPresenter.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 29/11/22.
//

import Foundation

// MARK: Define
typealias DetailPresenterProtocols = DetailPresenterAccess & DetailViewToPresenter & DetailInteractorToPresenter

protocol DetailPresenterAccess {
    var interactor: DetailPresenterToInteractor? { get set }
    var view: DetailPresenterToView? { get set }
    var router: DetailPresenterToRouter? { get set }
    func setPokemon(_ pokemon: ListEntity.Pokemon?)
    func didLoad()
}

protocol DetailViewToPresenter {
    func fetchAbitity()
}

protocol DetailInteractorToPresenter: AnyObject {
    func sucessAbility(ability: DetailEntity.AbilityResponse)
    func errorAbility(message: String)
}

// MARK: Implement
class DetailPresenter: DetailPresenterAccess {
    var interactor: DetailPresenterToInteractor?
    var view: DetailPresenterToView?
    var router: DetailPresenterToRouter?
    
    fileprivate var pokemon: ListEntity.Pokemon?
    
    func setPokemon(_ pokemon: ListEntity.Pokemon?){
        self.pokemon = pokemon
    }
    
    func didLoad(){
        self.view?.showProgressAnimation()
    }
    
}

extension DetailPresenter: DetailViewToPresenter {
    func fetchAbitity() {        
        self.interactor?.getAbility(withPokemonId: self.pokemon?.id?.description ?? "0")
    }
}

extension DetailPresenter: DetailInteractorToPresenter {
    func sucessAbility(ability: DetailEntity.AbilityResponse) {
        self.view?.hideProgressAnimation()
        self.view?.showAbility(pokemonInfo: self.pokemon!, ability: ability)
    }
    
    func errorAbility(message: String) {
        self.view?.hideProgressAnimation()
        self.view?.showErrorAbility(errorMessage: message)
    }    
}
