//
//  DetailViewController.swift
//  xkcd
//
//  Created by Drew Hood on 9/13/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate, ComicManagerImageDelegate {

    //@IBOutlet weak var webView: UIWebView!
    private var imageView: UIImageView?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // Data
    private let comicManager = ComicManager.sharedManager
    
    var detailItem: Comic?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.title
            
            if self.detailItem != nil {
                self.comicManager.retrieveImage(forComic: self.detailItem!)
            }
            
//            self.configureWebView()
        }
    }
    
//    private func configureWebView() {
//        //if let urlStr = self.detailItem?.localImageUrl {
//           // let htmlStr = "<html><img src=\"\(urlStr)\"></html>"
//            let url = URL(string: "https://xkcd.com/\(self.detailItem!.id)")
//            let urlreq = URLRequest(url: url!)
//            
//            print("loading url \(url)")
//            
//            if self.webView != nil {
//                // self.webView.loadHTMLString(htmlStr, baseURL: nil)
//                self.webView.loadRequest(urlreq)
//            }
//        //}
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.comicManager.imageDelegate = self
        
        let idiom = UIDevice.current.userInterfaceIdiom
        switch idiom {
            case .phone:
                self.scrollView.minimumZoomScale = 0.8
            default:
                self.scrollView.minimumZoomScale = 1.0
        }
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
    
    // MARK: - Image Delegation
    func comicManager(manager: ComicManager, retrievedImage image: UIImage, forComic comic: Comic) {
        // Create an ImageView
        self.imageView = UIImageView(image: image)
//        if self.scrollView.frame.size.width > self.imageView!.frame.size.width {
//            self.imageView!.frame.size.width = self.scrollView.frame.size.width
//        } else if self.imageView!.frame.size.height > self.imageView!.frame.size.width {
//            self.imageView!.frame.size.width = self.scrollView.frame.size.width
//            self.scrollView.flashScrollIndicators()
//        } else {
//            self.scrollView.flashScrollIndicators()
//        }
        
        self.scrollView.addSubview(self.imageView!)
        self.scrollView.setZoomScale(1.0, animated: true)
    }
    
    // MARK: - ScrollView Delegation
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }

}

