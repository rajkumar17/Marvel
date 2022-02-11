//
//  Cells+Dequeue.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation
import UIKit

//MARK: - Resuable

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UIView: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
