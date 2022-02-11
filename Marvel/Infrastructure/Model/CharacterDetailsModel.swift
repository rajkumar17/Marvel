//
//  CharacterDetailsModel.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation

struct CharacterDetailsModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataResponses?
}
