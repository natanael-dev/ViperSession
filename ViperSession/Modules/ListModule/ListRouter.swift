//
//  ListRouter.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import Foundation

typealias ListRouterProtocols = ListRouterAccess & ListPresenterToRouter
protocol ListRouterAccess {
    var viewController: ListViewController? { get set }
}

protocol ListPresenterToRouter {
    func routeToDetail(withPokemon pokemon: ListEntity.Pokemon)
}

class ListRouter: ListRouterAccess {
    var viewController: ListViewController?
}

extension ListRouter: ListPresenterToRouter {
    func routeToDetail(withPokemon pokemon: ListEntity.Pokemon){
        let pokemonDetailController = DetailViewController()
        pokemonDetailController.setPokemon(pokemon)
        viewController?.navigationController?.navigationBar.tintColor = .label
        viewController?.navigationController?.pushViewController(pokemonDetailController, animated: true)
    }
}
