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
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureView()
    }
    
    private func configureView() {
        if self.comic != nil , let textView = self.altTextView {
            textView.text = self.comic?.alt
            
            if let news = self.comic?.news {
                self.newsView.isHidden = false
                self.newsTextView.text = news
            } else {
                self.newsView.isHidden = true
            }
            
            self.linkButton.isHidden = self.comic?.link == nil
        }
    }
    
    // MARK: - Interface Actions
    @IBAction func dismissAction(sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func linkAction(sender: AnyObject) {
        if self.comic != nil, let url = self.comic?.link {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
}
