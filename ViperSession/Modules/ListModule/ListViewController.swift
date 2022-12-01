//
//  ListViewController.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import UIKit

// MARK: Define
typealias ListViewProtocols = ListViewAccess & ListPresenterToView
protocol ListViewAccess {
    var presenter: ListPresenterProtocols? { get set }
}
protocol ListPresenterToView: AnyObject {
    func showPokemons()
    func showErrorPokemon(errorMessage: String)
}

// MARK: Implement
class ListViewController: UIViewController, ListViewAccess {
    
    @IBOutlet weak var listTableView: UITableView! {
        didSet {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.rowHeight = 116
            listTableView.separatorStyle = .none
            listTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonId")
        }
    }
    
    var presenter: ListPresenterProtocols?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viperConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viperConfigure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.fetchPokemon()
    }
    
    fileprivate func viperConfigure(){
        var view: ListViewProtocols = self
        var presenter: ListPresenterProtocols = ListPresenter()
        var interactor: ListInteractorProtocols = ListInteractor()
        var router: ListRouterProtocols = ListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = self
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.pokemonsCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonId", for: indexPath) as? PokemonTableViewCell,
            let pokemonItem = presenter?.pokemonData(for: indexPath.row) else {
            return UITableViewCell()
        }
        cell.nameLabel.text = pokemonItem.name
        cell.numberLabel.text = pokemonItem.number
        cell.previewImage.image = nil
        if let url = pokemonItem.urlImage {
            cell.previewImage.af.setImage(withURL: url)
        }else{
            cell.previewImage?.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.pokemonSelected(for: indexPath.row)
    }
}

extension ListViewController: ListPresenterToView {
    func showPokemons(){
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
        }
    }

    func showErrorPokemon(errorMessage: String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
