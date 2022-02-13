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
    // Reference for CharactersModel
    var characterDetails:  DynamicValue<CharactersModel?> = DynamicValue(nil)
    // Reference for Characters error
    var characterError:  DynamicValue<String?> = DynamicValue(nil)
    
    // Method to fetch the characters list
    func fetchCharactersList(charactersID: Int) {
        useCase.getMarvalCharacterDetails(characterID: charactersID, completion: { [weak self] (characterDetailsModel) in
            guard let self = self else { return }
            switch characterDetailsModel {
                case .success(let data):
                    self.characterDetails.value = data
                case .failure(let error):
                self.getFailureCaseErrorMessage(error: error)
            }
        })
    }

    private func getFailureCaseErrorMessage(error: APIStatus){
        switch error {
        case .noData:
            self.characterError.value = "Data Not Found!"
        case .networkFailure:
            self.characterError.value = "Network not found!"
        case .unAuthorized:
            self.characterError.value = "Authorized Failed!"
        case .serverError:
            self.characterError.value = "Server Error. Please try again!"
        case .invalidRequest:
            self.characterError.value = "Invalid Request!"
        }
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
