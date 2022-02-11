//
//  ResponseHandler.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation

class ResponseHandler {
    
   class func fetchResponse<T: Codable>(responseData: Data, modelType: T.Type) -> T?  {
       do {
           let modelObject = try JSONDecoder().decode(T.self, from: responseData)
           return modelObject
       } catch(let error) {
           print("PARSER ERROR = \(error)")
       }
       return nil
    }
}
