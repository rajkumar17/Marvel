//
//  Constants.swift
//  Marvel
//
//  Created by Rajkumar on 14/02/22.
//

import Foundation

struct Constants {
    
    struct APIStatusError {
        
    static let noInternetConnection = "No Internet Connection, Please try again!"
        //MARK:- Method
        // Parameter: error status
     static func getFailureCaseErrorMessage(error: APIStatus) -> String{
            switch error {
            case .noData:
                 return "Data Not Found!"
            case .networkFailure:
                 return "Network not found!"
            case .unAuthorized:
                 return "Authorized Failed!"
            case .serverError:
                 return "Server Error. Please try again!"
            case .invalidRequest:
                 return "Invalid Request!"
            }
        }
    }
}


