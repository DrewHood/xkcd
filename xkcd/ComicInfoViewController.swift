//
//  ComicInfoViewController.swift
//  xkcd
//
//  Created by Drew Hood on 9/17/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import Foundation
import UIKit

class ComicInfoViewController: UIViewController {
    
    var comic: Comic? {
        didSet {
            self.configureView()
        }
    }
    
    @IBOutlet weak var altTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureView()
    }
    
    private func configureView() {
        if self.comic != nil , let textView = self.altTextView {
            textView.text = self.comic?.alt
        }
    }
    
    // MARK: - Interface Actions
    @IBAction func dismissAction(sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
