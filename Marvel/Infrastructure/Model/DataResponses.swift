//
//  DataResponses.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation

// MARK: - DataResponses
struct DataResponses: Codable {
    let offset, limit, total, count: Int?
    let results: [ResultData]?
}
