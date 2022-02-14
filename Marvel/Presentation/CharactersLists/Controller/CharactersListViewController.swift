//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersListViewController: UIViewController {

    //MARK:- IBOutlet
    // Reference for tableview
    @IBOutlet weak var charactersTableView: UITableView!
    // Reference for character view model
    let viewModel = CharactersViewModel()
    // Reference for character model
    var characters: [CharactersModel]?
    // Reference for Spinner view
    let spinnerView = SpinnerViewController()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        charactersTableView.register(UINib(nibName: CharactersCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CharactersCell.reuseIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
    }
    
    //MARK: - PRIVATE
    private func loadData() {
       if NetworkReachability.isConnection() {
           self.showSpinnerView(viewController: spinnerView)
           viewModel.fetchCharactersList()
           viewModel.characters.addObserver(self, completionHandler: { [weak self] in
               guard let self = self else { return }
               self.hideSpinnerView(viewController: self.spinnerView)
               DispatchQueue.main.async {
                   self.charactersTableView.reloadData()
               }
           })
           
           viewModel.characterError.addObserver(self, completionHandler: { [weak self] in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   self.hideSpinnerView(viewController: self.spinnerView)
                   if let errorLocalized = self.viewModel.characterError.value {
                       AlertManager.showAlertView(alertTitle: "", alertMsg: errorLocalized, view: self)
                   }
               }
           })
        }else{
            AlertManager.showAlertView(alertTitle: "", alertMsg: Constants.APIStatusError.noInternetConnection, view: self)
        }
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersCell.reuseIdentifier, for: indexPath) as? CharactersCell else {
            fatalError("Failed to load the CharactersCell")
        }
        let name = viewModel.getNameFor(indexPath)
        let description = viewModel.getDescriptionFor(indexPath)
        let thumbImagePath = viewModel.getthumbnailImageFor(indexPath)
        cell.setupConfigureCell(name: name, description: description, thumbImagePath: thumbImagePath)
        return cell
    }
}

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsVC = CharactersDetailViewController(nibName: "CharactersDetailViewController", bundle: nil)
        characterDetailsVC.getCharactersID = viewModel.getcharacterIDFor(indexPath)
        self.present(characterDetailsVC, animated: true, completion: nil)
    }
}
