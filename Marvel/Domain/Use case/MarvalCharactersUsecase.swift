//
//  MarvalCharactersUsecase.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation

typealias completion = (Result<CharactersModel?,Error>)->Void

protocol MarvalCharactersProtocol {
    func getMarvalCharacters(completion: @escaping (completion))
    func getMarvalCharacterDetails(characterID: Int, completion: @escaping (completion))
}

class MarvalCharactersUsecase: MarvalCharactersProtocol {
    let repository = MarvalCharactersRepository()

    func getMarvalCharacters(completion: @escaping (completion)) {
        repository.getMarvalCharacters(completion: { result   in
            switch result {
                 case .success(let data):
                     completion(.success(data))
                 case .failure(let error):
                     completion(.failure(error))
            }
        })
    }
    
    func getMarvalCharacterDetails(characterID: Int, completion:@escaping (completion)) {
        repository.getMarvalCharacterDetails(characterID: characterID, completion: { result in
            switch result {
                 case .success(let data):
                     completion(.success(data))
                 case .failure(let error):
                     completion(.failure(error))
            }
        })
    }
    
}
