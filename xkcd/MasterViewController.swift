//
//  MasterViewController.swift
//  xkcd
//
//  Created by Drew Hood on 9/13/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, ComicManagerDelegate {

    var detailViewController: DetailViewController? = nil
    let comicManager = ComicManager.sharedManager
    
    var comicList: [Comic]?
    
    private static let COMIC_CELL_ID = "Comic"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "xkcd"
        self.retrieveComics()
        self.comicManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Comic Manager
    func retrieveComics() {
        self.comicList = self.comicManager.getComics()
        self.tableView.reloadData()
    }
    
    // MARK: Delegate
    func comicManager(manager: ComicManager, addedComic comic: Comic) {
        self.retrieveComics()
    }
    
    func comicManager(manager: ComicManager, updatedComic comic: Comic) {
        self.retrieveComics()
    }
    
    func comicManager(manager: ComicManager, removedComic comic: Comic) {
        self.retrieveComics()
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.comicList != nil ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comicList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterViewController.COMIC_CELL_ID, for: indexPath)
        let comic = self.comicList![indexPath.row]
        cell.textLabel?.text = "\(comic.id) - \(comic.title!)"
        
        return cell
    }

    // MARK: - Segues
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showDetail" {
    //            if let indexPath = self.tableView.indexPathForSelectedRow {
    //            let object = self.fetchedResultsController.object(at: indexPath)
    //                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
    //                controller.detailItem = object
    //                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
    //                controller.navigationItem.leftItemsSupplementBackButton = true
    //            }
    //        }
    //    }

}

