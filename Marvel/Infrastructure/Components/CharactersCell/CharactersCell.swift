//
//  CharactersCell.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersCell: UITableViewCell {

    //MARK:- IBOutlet
    // An instance of charactersImageView? which will be used for holding the character imageview
    @IBOutlet weak var charactersImageView: MarvelImageView!
    // An instance of charactersNameLabel? which will be used for holding the character name
    @IBOutlet weak var charactersNameLabel: UILabel!
    // An instance of charactersDesciptionLabel? which will be used for holding the character description reference
    @IBOutlet weak var charactersDesciptionLabel: UILabel!
    // An instance of containerCharactersView? which will be used for holding the character container view
    @IBOutlet weak var containerCharactersView: UIView!
    // An instance of charactersView? which will be used for holding the character view
    @IBOutlet weak var charactersView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewShadow()
    }
    //MARK:- PRIVATE
    // Method to setup the shodaw and corner radius
    private func setupViewShadow() {
        
        containerCharactersView.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.2).cgColor)
        containerCharactersView.applyingRoundedCornersView()
        containerCharactersView.layer.masksToBounds = false
        
        charactersView.applyingRoundedCornersView()
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
