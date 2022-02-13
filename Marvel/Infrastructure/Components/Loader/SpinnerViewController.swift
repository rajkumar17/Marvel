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
    @IBOutlet weak var loaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        loaderView.layer.masksToBounds = true
        loaderView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
}
