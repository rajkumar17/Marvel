//
//  CharactersDetailsCell.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersDetailsCell: UITableViewCell {

    // An instance of characterNameLabel? which will be used for holding the character name
    @IBOutlet weak var characterNameLabel: UILabel!
    // An instance of characterDescriptionLabel? which will be used for holding the character description
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    // An instance of imgView? which will be used for holding the character imageview
    @IBOutlet weak var imgView: MarvelImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Method to Configure the cell
    // Parameter: name, description, thumbnail path
    func setupConfigureCell(name: String?, description: String?, thumbImagePath: String?) {
        characterNameLabel.text = name
        characterDescriptionLabel.text = description
        if let imagePath = thumbImagePath {
          DispatchQueue.main.async {
            self.imgView.loadRemoteImageFrom(urlString: imagePath)
          }
        }
    }
}
