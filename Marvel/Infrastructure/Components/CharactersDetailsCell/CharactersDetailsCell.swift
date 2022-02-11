//
//  CharactersDetailsCell.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

class CharactersDetailsCell: UITableViewCell {

    // Characters name reference
    @IBOutlet weak var characterNameLabel: UILabel!
    // Characters description reference
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    // Characters imageview reference
    @IBOutlet weak var imgView: MarvelImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Method to Configure the cell
    func setupConfigureCell(name: String, description: String, thumbImagePath: String) {
        characterNameLabel.text = name
        characterDescriptionLabel.text = description
        DispatchQueue.main.async {
            self.imgView.loadRemoteImageFrom(urlString: thumbImagePath)
        }
    }
}
