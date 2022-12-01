//
//  ListPresenter.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import Foundation

// MARK: Define
typealias ListPresenterProtocols = ListPresenterAccess & ListViewToPresenter & ListInteractorToPresenter

protocol ListPresenterAccess {
    var interactor: ListPresenterToInteractor? { get set }
    var view: ListPresenterToView? { get set }
    var router: ListPresenterToRouter? { get set }
    var pokemonsCount: Int { get }
    func pokemonData(for row: Int)-> (name:String, number: String, urlImage: URL?)
    func pokemonSelected(for row: Int)
}

protocol ListViewToPresenter {
    func fetchPokemon()
}

protocol ListInteractorToPresenter: AnyObject {
    func sucessPokemon(pokemons: [ListEntity.Pokemon])
    func errorPokemon(message: String)
}

// MARK: Implement
class ListPresenter: ListPresenterAccess {
    var interactor: ListPresenterToInteractor?
    weak var view: ListPresenterToView?
    var router: ListPresenterToRouter?
    private var pokemons: [ListEntity.Pokemon] = []
    
    var pokemonsCount: Int {
        return pokemons.count
    }
    
    func pokemonData(for row: Int)-> (name:String, number: String, urlImage: URL?){
        let pokemonItem = pokemons[row]
        let pokemonName = pokemonItem.name.capitalized
        let pokemonNumber = "#" + (pokemonItem.id?.description ?? "")
        let pokemonUrlImage = pokemonItem.imageUrl2         
        return (pokemonName, pokemonNumber, pokemonUrlImage)
    }
    
    func pokemonSelected(for row: Int){
        let pokemon = pokemons[row]
        self.router?.routeToDetail(withPokemon: pokemon)
    }
}

extension ListPresenter: ListViewToPresenter {
    func fetchPokemon(){
        self.interactor?.getPokemon()
    }
}

extension ListPresenter: ListInteractorToPresenter {
    func sucessPokemon(pokemons: [ListEntity.Pokemon]){
        self.pokemons = pokemons
        self.view?.showPokemons()
    }
    
    func errorPokemon(message: String){
        self.view?.showErrorPokemon(errorMessage: message)
    }
}
