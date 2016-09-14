//
//  ComicManager.swift
//  xkcd
//
//  Created by Drew Hood on 9/13/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData

class ComicManager {
    
    // Data
    private let moc: NSManagedObjectContext
    
    // Singleton
    static let sharedManager = ComicManager()
    private init() {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        self.moc = appDel.persistentContainer.viewContext
    }
    
    // MARK: - Delegation
    var delegate: ComicManagerDelegate?
    
    func delegateAdded(comic: Comic) {
        // Inform our delegate.
        self.delegate?.comicManager(manager: self, addedComic: comic)
    }
    
    func delegateUpdated(comic: Comic) {
        self.delegate?.comicManager(manager: self, updatedComic: comic)
    }
    
    func delegateRemoved(comic: Comic) {
        self.delegate?.comicManager(manager: self, removedComic: comic)
    }
    
    // MARK: - Comic Retrieval
    func retrieveNewComics() {
        // Download new comics from site. 
        
        // TODO: Build the real version. 
        // For now, just downnload a few comics.
        
        // Real algo: 
        /* 
            - Find latest comic
            - Retrieve comics back to the highest ID
            - Scan ID numbers for missing comics
        */
        
        func saveNewComic(dictionary: [String:AnyObject]) {
            
            let newComic = Comic.newComic(inContext: self.moc).seed(withDictionary: dictionary)
            
            do {
                try newComic.managedObjectContext?.save()
                
                // Notify delegate
                self.delegateAdded(comic: newComic)
            } catch {
                print("Error saving new comic!")
            }
        }
        
        for id in 1700...1730 {
            if let _ = self.getComic(withId: Int32(id)) {
                continue
            }
            
            let urlStr = "https://xkcd.com/\(id)/info.0.json"
            
            Alamofire.request(urlStr).responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let responseDict = JSON as! [String:AnyObject]
                    saveNewComic(dictionary: responseDict)
                    break
                case .failure(let error):
                    print("Error retrieving new comic:")
                    debugPrint(error)
                    break
                }
            }
        }
    }
    
    func getComics(favorites: Bool = false) -> [Comic]? {
        // Perform Core Data lookup
        let fetchRequest: NSFetchRequest<Comic> = Comic.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let comics: [Comic] = try self.moc.fetch(fetchRequest)
            return comics
        } catch {
            print("Error with fetch!")
        }
        
        return nil
    }
    
    func getComic(withId id: Int32) -> Comic? {
        // Perform Core Data lookup
        let fetchRequest: NSFetchRequest<Comic> = Comic.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "id == \(id)")
        fetchRequest.predicate = predicate
        
        do {
            let comics: [Comic] = try self.moc.fetch(fetchRequest)
            if comics.count > 0 {
                return comics[0]
            }
        } catch {
            print("Error with fetch!")
        }
        
        return nil
    }
    
    // MARK: - Images
    func retrieveImage(forComic comic: Comic) {
        
    }
}
