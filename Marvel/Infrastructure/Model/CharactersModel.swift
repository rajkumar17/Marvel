//
//  CharactersModel.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation

struct CharactersModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataResponses?
}
