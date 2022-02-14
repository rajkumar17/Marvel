//
//  CharactersDetailsViewModel.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation
import UIKit

class CharactersDetailsViewModel {
    //MARK:- Variable and Constant
    // Reference for usecase of marvelCharacters
    let useCase = MarvalCharactersUsecase()
    // Reference for CharactersModel
    var characterDetails:  DynamicValue<CharactersModel?> = DynamicValue(nil)
    // Reference for Characters error
    var characterError:  DynamicValue<String?> = DynamicValue(nil)

    //MARK:- Public Method
    // Method to fetch the characters list
    // Parameter: charactersID
    func fetchCharactersList(charactersID: Int) {
        useCase.getMarvalCharacterDetails(characterID: charactersID, completion: { [weak self] (characterDetailsModel) in
            guard let self = self else { return }
            switch characterDetailsModel {
                case .success(let data):
                    self.characterDetails.value = data
                case .failure(let error):
                self.characterError.value = Constants.APIStatusError.getFailureCaseErrorMessage(error:error)
            }
        })
    }
    // Method to get a results array
    // Return: array of ResultData
    func characterDetailsData() -> [ResultData]? {
        return characterDetails.value?.data?.results
    }
    // Method to get a name for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getNameFor(_ indexPath: IndexPath) -> String? {
        guard let name = characterDetailsData()?.getOrNull(indexPath.row)?.name else {
          print("Character name is empty")
          return nil
        }
        return name
    }
    // Method to get a Thubnail Image path for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getthumbnailImageFor(_ indexPath: IndexPath) -> String? {
        guard let thumbnailImage = characterDetailsData()?.getOrNull(indexPath.row)?.thumbnail,let thumbImagepath = thumbnailImage.path, let imageExtension = thumbnailImage.imageExtension else {
            print("thumbnailImage is empty")
            return nil
        }
        return "\(thumbImagepath).\(imageExtension)"
    }
    // Method to get a description for a given index
    // - Parameter indexPath: index path
    // Return: string
    func getDescriptionFor(_ indexPath: IndexPath) -> String? {
        guard let description = characterDetailsData()?.getOrNull(indexPath.row)?.description else {
            print("description is empty")
            return nil
        }
        return description
    }
}
