//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation
import UIKit

class CharactersViewModel {
    
    // Reference for usecase of marvelCharacters
    let useCase = MarvalCharactersUsecase()
    // Reference for CharactersModel
    var characters:  DynamicValue<CharactersModel?> = DynamicValue(nil)
    // Reference for Characters error
    var characterError:  DynamicValue<Error?> = DynamicValue(nil)
    
    // Method to fetch the characters list
    func fetchCharactersList() {
        useCase.getMarvalCharacters(completion: { [weak self] (charactersModel) in
            guard let self = self else { return }
            switch charactersModel {
                case .success(let data):
                    self.characters.value = data
                case .failure(let error):
                self.characterError.value = error
            }
        })
    }
    
    // Method to get a results array
    func noOfRow() -> Int {
        return charactersData()?.count ?? 0
    }

    // Method to get a results array
    func charactersData() -> [ResultData]? {
        return characters.value?.data?.results
    }
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    func getcharacterIDFor(_ indexPath: IndexPath) -> Int? {
        guard let characterID = charactersData()?.getOrNull(indexPath.row)?.id else { return nil }
        return characterID
    }
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    func getNameFor(_ indexPath: IndexPath) -> String {
        guard let name = charactersData()?.getOrNull(indexPath.row)?.name else { return "" }
        return name
    }
    // Method to get a Thubnail Image path for a given index
    // - Parameter indexPath: index path
    func getthumbnailImageFor(_ indexPath: IndexPath) -> String {
        guard let thumbnailImage = charactersData()?.getOrNull(indexPath.row)?.thumbnail else { return "" }
        if let thumbImagepath = thumbnailImage.path, let imageExtension = thumbnailImage.imageExtension {
            return "\(thumbImagepath).\(imageExtension)"
        }
        return ""
    }
    // Method to get a description for a given index
    // - Parameter indexPath: index path
    func getDescriptionFor(_ indexPath: IndexPath) -> String {
        guard let description = charactersData()?.getOrNull(indexPath.row)?.description else { return "" }
        return description
    }
}
