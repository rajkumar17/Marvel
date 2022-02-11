//
//  MarvalCharactersNetworkRepository.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation

protocol MarvalCharactersNetworkRepositoryProtocol {
    func getMarvalCharacters(completion: @escaping (completion))
    func getMarvalCharacterDetails(characterID: Int, completion: @escaping (completion))
}

class MarvalCharactersNetworkRepository: MarvalCharactersNetworkRepositoryProtocol {
    
    func getMarvalCharacters(completion: @escaping (completion)) {
        APIServices.shared.requestNetworkAPI(method: .get, urlString: AppConfiguration.shared.charactersUrl, completion: { result in
            switch result {
              case .success(let data):
                    let modelObject = ResponseHandler.fetchResponse(responseData: data, modelType: CharactersModel.self)
                    completion(.success(modelObject))
              case .failure(let error):
                    completion(.failure(error))
            }
        })
    }

    func getMarvalCharacterDetails(characterID: Int, completion: @escaping (completion)) {
        let characterDetailsString = "\(AppConfiguration.shared.apiBaseURL)characters/\(characterID)\(AppConfiguration.shared.path)"
        APIServices.shared.requestNetworkAPI(method: .get, urlString: characterDetailsString, completion: { result in
            switch result {
              case .success(let data):
                    let modelObject = ResponseHandler.fetchResponse(responseData: data, modelType: CharactersModel.self)
                        completion(.success(modelObject))
            case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
