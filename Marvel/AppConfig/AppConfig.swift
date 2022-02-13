//
//  AppConfig.swift
//  Marvel
//
//  Created by Rajkumar on 08/02/22.
//

import Foundation
import CryptoKit

final class AppConfiguration {
    
    static let shared = AppConfiguration()
    // Init
    private init() {}
    
    // Get the baseURL from .plist
    lazy var apiBaseURL: String = {
      guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
       fatalError("APIBaseURL must not be empty in plist")
      }
      return apiBaseURL
    }()
    // An reference for characters url
    lazy var charactersUrl: String = {
       return "\(apiBaseURL)characters?\(path)"
    }()
    // An reference for path
    lazy var path: String = {
        return "ts=\(AppConfiguration.dashedDate.string(from: Date()))&apikey=\(AppConfiguration.publicKey)&hash=\(md5Hash)"
    }()
    // An reference for public key
    static let publicKey = "63263ce283a3d8d98e8343d67feaab10"
    // An reference for private key
    static let privateKey = "3fdd7351dd49a660d7a298da2cba063f1c7d2f76"
    // An reference for date
    static let dashedDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        return formatter
    }()
    
    lazy var md5Hash: String = {
        return convertToMd5Hash("\(AppConfiguration.dashedDate.string(from: Date()))\(AppConfiguration.privateKey)\(AppConfiguration.publicKey)")
    }()
    func convertToMd5Hash(_ source: String) -> String {
        let digest = Insecure.MD5.hash(data: source.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
