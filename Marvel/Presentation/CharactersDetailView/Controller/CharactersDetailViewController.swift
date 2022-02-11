//
//  CharactersDetailViewController.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    //MARK:- IBOutlets
    // Characters character tableview reference
    @IBOutlet weak var characterDetailsTableView:UITableView!
    var getCharactersID: Int?
    let viewModel = CharactersDetailsViewModel()
    
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
            SpinnerView.shared.showActivityIndicator(uiView: self.view)
            guard let characterID = getCharactersID else {
                return
            }
            viewModel.fetchCharactersList(charactersID: characterID)
            viewModel.characterDetails.addObserver(self, completionHandler: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    SpinnerView.shared.hideActivityIndicator(uiView: self.view)
                    self.characterDetailsTableView.reloadData()
                }
            })
            viewModel.characterError.addObserver(self, completionHandler: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    SpinnerView.shared.hideActivityIndicator(uiView: self.view)
                    if let errorLocalized = self.viewModel.characterError.value?.localizedDescription {
                        AlertManager.showAlertView(alertTitle: "", alertMsg: errorLocalized, view: self)
                    }
                }
            })
         }else{
             AlertManager.showAlertView(alertTitle: "", alertMsg: "No Internet Connection, Please try again!", view: self)
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
            fatalError("")
        }
        let name = viewModel.getNameFor(indexPath)
        let description = viewModel.getDescriptionFor(indexPath)
        let thumbImagePath = viewModel.getthumbnailImageFor(indexPath)
        cell.setupConfigureCell(name: name, description: description, thumbImagePath: thumbImagePath)
        return cell
    }
}
