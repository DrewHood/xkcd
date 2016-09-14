//
//  ComicManager.swift
//  xkcd
//
//  Created by Drew Hood on 9/13/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import Foundation

class ComicManager {
    
    // Singleton
    static let sharedManager = ComicManager()
    private init() {}
    
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
        
    }
    
    // MARK: - Images
    func retrieveImage(forComic comic: Comic) {
        
    }
}
