//
//  Array+SafeGet.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation

extension Array {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    func getOrNull(_ index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
