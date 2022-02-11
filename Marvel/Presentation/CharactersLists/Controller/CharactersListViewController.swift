//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersListViewController: UIViewController {

    //MARK:- IBOutlet
    // Characters tableview reference
    @IBOutlet weak var charactersTableView: UITableView!
    
    let viewModel = CharactersViewModel()
    
    var characters: [CharactersModel]?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        charactersTableView.register(UINib(nibName: CharactersCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CharactersCell.reuseIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    //MARK: - PRIVATE
    fileprivate func setNavigtionBarItems() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .red
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.tintColor = .white
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .red
        }
    }
    private func loadData() {
       if NetworkReachability.isConnection() {
           SpinnerView.shared.showActivityIndicator(uiView: self.view)
           viewModel.fetchCharactersList()
           viewModel.characters.addObserver(self, completionHandler: { [weak self] in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   SpinnerView.shared.hideActivityIndicator(uiView: self.view)
                   self.charactersTableView.reloadData()
               }
           })
        }else{
            AlertManager.showAlertView(alertTitle: "", alertMsg: "No Internet Connection, Please try again!", view: self)
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