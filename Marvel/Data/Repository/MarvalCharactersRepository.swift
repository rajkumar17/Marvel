//
//  MarvalCharactersRepository.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation

protocol MarvalCharactersRepositoryProtocol {
    func getMarvalCharacters(completion: @escaping (completion))
    func getMarvalCharacterDetails(characterID: Int, completion: @escaping (completion))
}

class MarvalCharactersRepository: MarvalCharactersRepositoryProtocol {
    
    let networkRepository = MarvalCharactersNetworkRepository()

    func getMarvalCharacters(completion:@escaping (completion)) {
        networkRepository.getMarvalCharacters(completion: { data in 
            completion(data)
        })
    }
    
    func getMarvalCharacterDetails(characterID: Int, completion: @escaping completion) {
        networkRepository.getMarvalCharacterDetails(characterID: characterID, completion: { data in
            completion(data)
        })
    }
}
