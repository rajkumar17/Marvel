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
}

typealias completionHandler = ((Result<Data,APIStatus>)->Void)

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
    // Method request to serice to fetch the response
    // Parameter: data, response, error
    // Return: completionHandler
    private func callBackResponse(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (completionHandler)) {
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            completionHandler(.failure(.networkFailure))
          return
        }
        switch statusCode {
        case 200...299:
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            completionHandler(.success(data))
        case 400...499:
            completionHandler(.failure(.unAuthorized))
            break
        default:
            completionHandler(.failure(.serverError))
        }
    }
    // Method to genetare the urlRequest
    // Parameter: method, urlString
    // Return: URLRequest
    private func getURLRequest(method: HTTPCustomMethod,
                       urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            print("API url is empty")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    // Method to make a api request and response handle
    // Parameter: method, urlString
    // Return: completionHandler
    func requestNetworkAPI(method: HTTPCustomMethod,
                           urlString: String,
                           completion: @escaping (completionHandler)) {
        guard let request = getURLRequest(method: method, urlString: urlString) else {
            print("API request is empty")
            return
        }
        
        let task = sessionConfiguration?.dataTask(with: request) { [weak self] data, response, error in
           self?.callBackResponse(data: data, response: response, error: error) { result in
               switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
               }
           }
        }
        task?.resume()
    }
}
