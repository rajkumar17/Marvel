//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation
import UIKit

class CharactersViewModel {
    //MARK:- Variable and Constant
    // Reference for usecase of marvelCharacters
    let useCase = MarvalCharactersUsecase()
    // Reference for CharactersModel
    var characters:  DynamicValue<CharactersModel?> = DynamicValue(nil)
    // Reference for Characters error
    var characterError:  DynamicValue<String?> = DynamicValue(nil)
    
    //MARK:- Public Methods
    // Method to fetch the characters list
    func fetchCharactersList() {
        useCase.getMarvalCharacters(completion: { [weak self] (charactersModel) in
            guard let self = self else { return }
            switch charactersModel {
                case .success(let data):
                    self.characters.value = data
                case .failure(let error):
                self.characterError.value = Constants.APIStatusError.getFailureCaseErrorMessage(error:error)
            }
        })
    }
    // Method to get a count of results array
    func noOfRow() -> Int {
        return charactersData()?.count ?? 0
    }
    // Method to get a results array
    func charactersData() -> [ResultData]? {
        return characters.value?.data?.results
    }
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    // Return: Int
    func getcharacterIDFor(_ indexPath: IndexPath) -> Int? {
        guard let characterID = charactersData()?.getOrNull(indexPath.row)?.id else {
            print("character ID is empty")
            return nil
        }
        return characterID
    }
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getNameFor(_ indexPath: IndexPath) -> String? {
        guard let name = charactersData()?.getOrNull(indexPath.row)?.name else {
            print("character name is empty")
            return nil
        }
        return name
    }
    // Method to get a Thubnail Image path for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getthumbnailImageFor(_ indexPath: IndexPath) -> String? {
        guard let thumbnailImage = charactersData()?.getOrNull(indexPath.row)?.thumbnail,let thumbImagepath = thumbnailImage.path, let imageExtension = thumbnailImage.imageExtension else {
            print("thumbnailImage is empty")
            return nil
        }
        return "\(thumbImagepath).\(imageExtension)"
    }
    // Method to get a description for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getDescriptionFor(_ indexPath: IndexPath) -> String? {
        guard let description = charactersData()?.getOrNull(indexPath.row)?.description else {
            print("description is empty")
            return nil
        }
        return description
    }
}
