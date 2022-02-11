//
//  APIServices.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation
import UIKit

enum APIStatus: Error {
  case noData
  case networkFailure
  case unAuthorized
  case serverError
  case invalidRequest
  case invalidUser
}

typealias completionHandler = ((Result<Data?,APIStatus>) -> Void)

enum HTTPCustomMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
}

class APIServices {
 
    //MARK:- Constant
    static let shared = APIServices()
    
    //MARK:- PRIVATE
    private var sessionConfiguration: URLSession? {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 180
        return URLSession(configuration: configuration)
    }
    
    //Method request to serice to fetch the response
    private func callBackResponse(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (completionHandler)) {
        if(error == nil) {
            completionHandler(.failure(.networkFailure))
        } else {
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completionHandler(.failure(.invalidRequest))
                return
            }
            completionHandler(.success(data))
        }
    }
    
    private func getURLRequest(method: HTTPCustomMethod,
                       urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    func requestNetworkAPI(method: HTTPCustomMethod,
                           urlString: String,
                           completion: @escaping (completionHandler)) {
        guard let request = getURLRequest(method: method, urlString: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
           self?.callBackResponse(data: data, response: response, error: error) { result in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.invalidRequest))
                }
            }
        }
        task.resume()
    }
}
