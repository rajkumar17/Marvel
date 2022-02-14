//
//  UIView+Inspectable.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import Foundation
import UIKit

extension UIView {
    
    // Method to apply the rounded corner radius to view
    func applyingRoundedCornersView(cornerRadius:CGFloat = 12.5, borderWidth:CGFloat = 0.1, borderColor:CGColor = UIColor.black.cgColor) {
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
    }
    // Method to apply the shadow effect to view
    func addShadow(shadowColor: CGColor = UIColor.gray.cgColor,
                   shadowOffset: CGSize = CGSize(width:1, height:1),
                   shadowOpacity: Float = 1.0,
                   shadowRadius: CGFloat = 5.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
