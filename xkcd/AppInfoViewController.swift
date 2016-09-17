//
//  AppInfoViewController.swift
//  xkcd
//
//  Created by Drew Hood on 9/17/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    @IBAction func dismissAction() {
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMoreAction() {
        UIApplication.shared.open(URL(string: "https://xkcd.com/about/")!, options: [:], completionHandler: nil)
    }
}
