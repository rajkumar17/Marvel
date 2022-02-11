//
//  ResultData.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation
// MARK: - Result
struct ResultData: Codable {
    let id: Int?
    let name, description: String?
    let modified:String?
    let thumbnail: Thumbnail?
    let resourceURI: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case modified, thumbnail, resourceURI
    }
}
