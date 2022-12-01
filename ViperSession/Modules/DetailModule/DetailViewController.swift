//
//  DetailViewController.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import UIKit

// MARK: Define
typealias DetailViewProtocols = DetailViewAccess & DetailPresenterToView
protocol DetailViewAccess {
    var presenter: DetailPresenterProtocols? { get set }
}
protocol DetailPresenterToView: AnyObject {
    func showAbility(pokemonInfo pokemon: ListEntity.Pokemon, ability: DetailEntity.AbilityResponse)
    func showErrorAbility(errorMessage: String)
    func showProgressAnimation()
    func hideProgressAnimation()
}

// MARK: Implement
class DetailViewController: UIViewController, DetailViewAccess {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var shortEffectLabel: UILabel!
    @IBOutlet weak var effectTitleLabel: UILabel!
    @IBOutlet weak var shortEffectTitleLabel: UILabel!
    @IBOutlet weak var abilityTitleLabel: UILabel!
  
    var presenter: DetailPresenterProtocols?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: String(describing: DetailViewController.self), bundle: Bundle(for: DetailViewController.self))
        self.viperConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viperConfigure()
    }
    
    fileprivate func viperConfigure(){
        var view: DetailViewProtocols = self
        var presenter: DetailPresenterProtocols = DetailPresenter()
        var interactor: DetailInteractorProtocols = DetailInteractor()
        var router: DetailRouterProtocols = DetailRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = self
    }
    
    func setPokemon(_ pokemon: ListEntity.Pokemon){
        self.presenter?.setPokemon(pokemon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.fetchAbitity()
    }
}


extension DetailViewController: DetailPresenterToView {
    func showAbility(pokemonInfo pokemon: ListEntity.Pokemon, ability: DetailEntity.AbilityResponse) {
        self.abilityTitleLabel.text = "Ability"
        self.effectTitleLabel.text = "Effect"
        self.shortEffectTitleLabel.text = "Short Effect"
        if let imageURL = pokemon.imageUrl2 {
            self.previewImageView.af.setImage(withURL: imageURL)
        }
        self.title = pokemon.name.capitalized
        
        var abilityEffect = ""
        var abilityShortEffect = ""
        for effect in ability.effectEntries {
            if effect.language.name == "en" {
                abilityEffect = effect.effect
                abilityShortEffect = effect.shortEffect
            }
        }
        self.effectLabel.text = abilityEffect
        self.shortEffectLabel.text = abilityShortEffect
    }
    
    func showErrorAbility(errorMessage: String) {
        let alert = UIAlertController(title: "Lo sentimos", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgressAnimation() {
        LottieProgress.animation.show()
    }
    
    func hideProgressAnimation() {
        LottieProgress.animation.hide()
    }    
}
