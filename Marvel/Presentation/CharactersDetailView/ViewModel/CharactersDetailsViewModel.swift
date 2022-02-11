//
//  CharactersDetailsViewModel.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation
import UIKit

class CharactersDetailsViewModel {
    
    // Reference for usecase of marvelCharacters
    let useCase = MarvalCharactersUsecase()
    // Reference for CharactersDetailsModel
    var characterDetails:  DynamicValue<CharacterDetailsModel?> = DynamicValue(nil)
    
    // Method to fetch the characters list
    func fetchCharactersList(charactersID: Int) {
        useCase.getMarvalCharacterDetails(characterID: charactersID, completion: { [weak self] (characterDetailsModel) in
            guard let self = self else { return }
            self.characterDetails.value = characterDetailsModel
        })
    }
    
    // Method to get a results array
    func noOfRow() -> Int {
        return characterDetailsData()?.count ?? 0
    }

    // Method to get a results array
    func characterDetailsData() -> [ResultData]? {
        return characterDetails.value?.data?.results
    }
 
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    func getNameFor(_ indexPath: IndexPath) -> String {
        guard let name = characterDetailsData()?.getOrNull(indexPath.row)?.name else { return "" }
        return name
    }
    
    // Method to get a Thubnail Image path for a given index
    // - Parameter indexPath: index path
    func getthumbnailImageFor(_ indexPath: IndexPath) -> String {
        guard let thumbnailImage = characterDetailsData()?.getOrNull(indexPath.row)?.thumbnail else { return "" }
        if let thumbImagepath = thumbnailImage.path, let imageExtension = thumbnailImage.imageExtension {
            return "\(thumbImagepath).\(imageExtension)"
        }
        return ""
    }
    // Method to get a description for a given index
    // - Parameter indexPath: index path
    func getDescriptionFor(_ indexPath: IndexPath) -> String {
        guard let description = characterDetailsData()?.getOrNull(indexPath.row)?.description else { return "" }
        return description
    }
}
