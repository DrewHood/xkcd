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
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private static let COMIC_INFO_SEGUE_ID = "COMIC_INFO_SEGUE_ID"
    
    // Data
    private let comicManager = ComicManager.sharedManager

    var detailItem: Comic? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        // TODO: This is a quick hack
        // Test to see if nib is loaded
        if self.activityIndicator == nil {
            return
        }
        
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.title
            
            if self.detailItem != nil {
                self.comicManager.retrieveImage(forComic: self.detailItem!)
                self.activityIndicator.startAnimating()
            }
            
        }
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.COMIC_INFO_SEGUE_ID {
            if let comicInfoView = segue.destination as? ComicInfoViewController {
                comicInfoView.comic = self.detailItem
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Interface Actions

    @IBAction func favoriteAction(sender: AnyObject) {
        if let comic = self.detailItem {
            if comic.favorite {
                self.comicManager.unfavorite(comic: comic)
            } else {
                self.comicManager.favorite(comic: comic)
            }
        }
    }
    
    @IBAction func nextAction(sender: AnyObject) {
        var nextComicId = self.detailItem!.id + 1
        if nextComicId == 404 { nextComicId = 405 }
        
        self.detailItem = self.comicManager.getComic(withId: nextComicId)
    }
    
    @IBAction func previousAction(sender: AnyObject) {
        var nextComicId = self.detailItem!.id - 1
        if nextComicId == 404 { nextComicId = 403 }
        
        self.detailItem = self.comicManager.getComic(withId: nextComicId)
    }
    
    @IBAction func retryAction(sender: AnyObject) {
        self.configureView() // just reconfigure the view
    }
    
    @IBAction func showAltAction(sender: UILongPressGestureRecognizer) {
        self.performSegue(withIdentifier: DetailViewController.COMIC_INFO_SEGUE_ID, sender: sender)
    }
    
    // MARK: - Image Delegation
    func comicManager(manager: ComicManager, retrievedImage image: UIImage, forComic comic: Comic) {
        // Create an ImageView
        self.imageView = UIImageView(image: image)
        
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        self.scrollView.addSubview(self.imageView!)
        self.scrollView.setZoomScale(1.0, animated: true)
        
        self.activityIndicator.stopAnimating()
        self.errorView.isHidden = true
    }
    
    func comicManager(manager: ComicManager, encounteredImageRetrievalError error: Error) {
        self.activityIndicator.stopAnimating()
        self.errorView.isHidden = false
    }
    
    // MARK: - ScrollView Delegation
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        // Do nothing for now
    }

}

