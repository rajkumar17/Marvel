//
//  UIViewController+SpinnerView.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSpinnerView(viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = view.frame
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    func hideSpinnerView(viewController: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
}
