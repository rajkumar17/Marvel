//
//  CharactersDetailViewController.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    //MARK:- IBOutlets
    // Characters tableview reference
    @IBOutlet weak var characterDetailsTableView:UITableView!
    // Reference for characters ID
    var getCharactersID: Int?
    // Reference for view model
    let viewModel = CharactersDetailsViewModel()
    // Reference for Spinner view
    let spinnerView = SpinnerViewController()
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsTableView.register(UINib(nibName: CharactersDetailsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CharactersDetailsCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    //MARK: - PRIVATE
    private func loadData() {
        if NetworkReachability.isConnection() {
            self.showSpinnerView(viewController: spinnerView)
            guard let characterID = getCharactersID else {
                print("CharacterID not found")
                return
            }
            viewModel.fetchCharactersList(charactersID: characterID)
            viewModel.characterDetails.addObserver(self, completionHandler: { [weak self] in
                guard let self = self else { return }
                self.hideSpinnerView(viewController: self.spinnerView)
                DispatchQueue.main.async {
                    self.characterDetailsTableView.reloadData()
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
//MARK: - Extension
extension CharactersDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersDetailsCell.reuseIdentifier, for: indexPath) as? CharactersDetailsCell else {
            fatalError("CharactersDetailsCell is not load")
        }
        let name = viewModel.getNameFor(indexPath)
        let description = viewModel.getDescriptionFor(indexPath)
        let thumbImagePath = viewModel.getthumbnailImageFor(indexPath)
        cell.setupConfigureCell(name: name, description: description, thumbImagePath: thumbImagePath)
        return cell
    }
}
