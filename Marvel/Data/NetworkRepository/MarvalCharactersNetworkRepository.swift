//
//  MarvalCharactersNetworkRepository.swift
//  Marvel
//
//  Created by Rajkumar on 10/02/22.
//

import Foundation

protocol MarvalCharactersNetworkRepositoryProtocol {
    func getMarvalCharacters(completion:@escaping (completion))
    func getMarvalCharacterDetails(characterID: Int, completion:@escaping ((CharacterDetailsModel?)->Void))
}

class MarvalCharactersNetworkRepository: MarvalCharactersNetworkRepositoryProtocol {
    
    func getMarvalCharacters(completion:@escaping (completion)) {
        APIServices.shared.requestNetworkAPI(method: .get, urlString: AppConfiguration.shared.charactersUrl, completion: { result in
            switch result {
              case .success(let data):
                if let datas = data {
                    let modelObject = ResponseHandler.fetchResponse(responseData: datas, modelType: CharactersModel.self)
                    completion(modelObject)
                }
            case .failure(_):
                break
            }
        })
    }

    func getMarvalCharacterDetails(characterID: Int, completion:@escaping ((CharacterDetailsModel?)->Void)) {
        let characterDetailsString = "\(AppConfiguration.shared.apiBaseURL)characters/\(characterID)\(AppConfiguration.shared.path)"
        APIServices.shared.requestNetworkAPI(method: .get, urlString: characterDetailsString, completion: { result in
            switch result {
              case .success(let data):
                if let datas = data {
                    let modelObject = ResponseHandler.fetchResponse(responseData: datas, modelType: CharacterDetailsModel.self)
                    completion(modelObject)
                }
            case .failure(_):
                break
            }
        })
    }
}
