//
//  CharactersCell.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersCell: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var charactersImageView: MarvelImageView!
    @IBOutlet weak var charactersNameLabel: UILabel!
    @IBOutlet weak var charactersDesciptionLabel: UILabel!
    @IBOutlet weak var containerCharactersView: UIView!
    @IBOutlet weak var charactersView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- PRIVATE
    // Method to setup the shodaw and corner radius
    private func setupViewShadow() {
        containerCharactersView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        containerCharactersView.layer.shadowOffset = CGSize(width: 4, height: 4)
        containerCharactersView.layer.shadowOpacity = 1.0
        containerCharactersView.layer.shadowRadius = 5.0
        containerCharactersView.layer.cornerRadius = 12.5
        containerCharactersView.layer.masksToBounds = false
        
        charactersView.layer.cornerRadius = 12.5
        charactersView.clipsToBounds = true
    }
    //MARK:- PUBLIC
    // Method to Configure the cell
    func setupConfigureCell(name: String, description: String, thumbImagePath: String) {
        charactersNameLabel.text = name
        charactersDesciptionLabel.text = description
        charactersDesciptionLabel.isHidden = (description.isEmpty ? true : false)
        DispatchQueue.main.async {
            self.charactersImageView.loadRemoteImageFrom(urlString: thumbImagePath)
        }
    }
}
