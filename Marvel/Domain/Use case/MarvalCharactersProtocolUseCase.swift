//
//  UseCase.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation

typealias completion = (CharactersModel?)->Void

protocol MarvalCharactersProtocol {
    func getMarvalCharacters(completion: @escaping (completion))
    func getMarvalCharacterDetails(characterID: Int, completion:@escaping ((CharacterDetailsModel?)->Void))
}

class MarvalCharactersUsecase: MarvalCharactersProtocol {
    let repository = MarvalCharactersRepository()

    func getMarvalCharacters(completion: @escaping (completion)) {
        repository.getMarvalCharacters(completion: { result in
            completion(result)
        })
    }
    
    func getMarvalCharacterDetails(characterID: Int, completion:@escaping ((CharacterDetailsModel?)->Void)) {
        repository.getMarvalCharacterDetails(characterID: characterID, completion: { result in
            completion(result)
        })
    }
    
}
