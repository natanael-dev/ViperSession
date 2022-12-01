//
//  DetailRouter.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 29/11/22.
//

import Foundation

typealias DetailRouterProtocols = DetailRouterAccess & DetailPresenterToRouter
protocol DetailRouterAccess {
    var viewController: DetailViewController? { get set }
}

protocol DetailPresenterToRouter {
    
}

class DetailRouter: DetailRouterAccess {
    var viewController: DetailViewController?
}

extension DetailRouter: DetailPresenterToRouter {
    
}
