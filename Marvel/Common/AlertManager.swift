//
//  AlertManager.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import Foundation
import UIKit

class AlertManager {
    
    class func showAlertView(alertTitle: String, alertMsg: String, view: UIViewController) {
        let alert = UIAlertController(title:alertTitle, message:alertMsg, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated:true, completion:nil)
    }
}
