//
//  AppConfig.swift
//  Marvel
//
//  Created by Rajkumar on 08/02/22.
//

import Foundation

final class AppConfiguration {
    
    static let shared = AppConfiguration()
   
    private init() {}
    
    // Get the baseURL from .plist
    lazy var apiBaseURL: String = {
      guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
       fatalError("APIBaseURL must not be empty in plist")
      }
      return apiBaseURL
    }()
    
    lazy var charactersUrl: String = {
       return "\(apiBaseURL)characters\(path)"
    }()
    
    
    lazy var path: String = {
        return "?ts=\(AppConfiguration.dashedDate.string(from: Date()))&apikey=\(AppConfiguration.publicKey)&hash=b9effb6c7ac73fd8a46ecfda4b9eb630"
    }()
    
//    var charactersDetailsUrl : String = {
//        didSet {
//            return "\(apiBaseURL)characters/\(path)"
//        }
//        willSet {
//            
//        }
//    }
    
    static let publicKey = "63263ce283a3d8d98e8343d67feaab10"
    static let privateKey = "3fdd7351dd49a660d7a298da2cba063f1c7d2f76"

    static let dashedDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
    
}