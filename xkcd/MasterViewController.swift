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
    private static let DETAIL_VIEW_SEGUE_ID = "showDetail"
    
    private var favorites: Bool = false {
        didSet {
            if favorites {
                self.navigationItem.title = "Favorites"
            } else {
                self.navigationItem.title = "xkcd"
            }
            
            self.retrieveComics()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "xkcd"
        self.retrieveComics()
        self.comicManager.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(toggleFavorites))
    }
    
    func toggleFavorites() {
        self.favorites = !self.favorites
    }
    
    // MARK: - Comic Manager
    func retrieveComics() {
        self.comicList = self.comicManager.getComics(favorites: self.favorites)
        self.tableView.reloadData()
    }
    
    // MARK: Delegate
    func comicManager(manager: ComicManager, addedComic comic: Comic) {
        self.comicList = self.comicManager.getComics(favorites: self.favorites)
        let index = IndexPath(row: self.comicList!.index(of: comic)!, section: 0)
        self.tableView.insertRows(at: [index] , with: .automatic)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MasterViewController.DETAIL_VIEW_SEGUE_ID {
            let object: Comic?
            if let indexPath = self.tableView.indexPathForSelectedRow {
                object = self.comicList![indexPath.row]
            } else if let tableViewCell = sender as? UITableViewCell {
                let row = self.tableView.indexPath(for: tableViewCell)?.row
                object = self.comicList![row!]
            } else {
                object = nil
            }
            
            if let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController {
                self.detailViewController = controller
                self.detailViewController!.detailItem = object
                self.detailViewController!.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                self.detailViewController!.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}

