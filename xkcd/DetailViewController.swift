//
//  DetailViewController.swift
//  xkcd
//
//  Created by Drew Hood on 9/13/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var detailItem: Comic?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.title
            
            self.configureWebView()
        }
    }
    
    private func configureWebView() {
        //if let urlStr = self.detailItem?.localImageUrl {
           // let htmlStr = "<html><img src=\"\(urlStr)\"></html>"
            let url = URL(string: "https://xkcd.com/\(self.detailItem!.id)")
            let urlreq = URLRequest(url: url!)
            
            print("loading url \(url)")
            
            if self.webView != nil {
                // self.webView.loadHTMLString(htmlStr, baseURL: nil)
                self.webView.loadRequest(urlreq)
            }
        //}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureView()
        
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Interface Actions

    @IBAction func favoriteAction(sender: AnyObject) {
        
    }
    
    @IBAction func nextAction(sender: AnyObject) {
        
    }
    
    @IBAction func previousAction(sender: AnyObject) {
        
    }

}

