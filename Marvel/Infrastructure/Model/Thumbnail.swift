//
//  Thumbnail.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let imageExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
