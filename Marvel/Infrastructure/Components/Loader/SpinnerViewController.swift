//
//  SpinnerViewController.swift
//  Marvel
//
//  Created by Rajkumar on 11/02/22.
//

import UIKit

class SpinnerViewController: UIViewController {

    // An instance of charactersImageView? which will be used for holding the character imageview
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        // Do any additional setup after loading the view.
    }
}
