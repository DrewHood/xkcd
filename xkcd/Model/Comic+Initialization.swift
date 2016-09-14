//
//  Comic+Initialization.swift
//  xkcd
//
//  Created by Drew Hood on 9/14/16.
//  Copyright © 2016 Drew R. Hood. All rights reserved.
//

import Foundation

extension Comic {
    
    convenience init(withDictionary dict: [String:AnyObject]) {
        self.init()
        
        self.id = dict["num"] as! Int32
        self.title = dict["title"] as? String
        self.safeTitle = dict["safe_title"] as? String
        self.alt = dict["alt"] as? String
        self.remoteImageUrl = dict["img"] as? String
        self.link = dict["link"] as? String
        self.news = dict["news"] as? String
        
        let month = dict["month"] as! Int32
        let day = dict["day"] as! Int32
        let year = dict["year"] as! Int32
        
        self.timestamp = Date(withDateString: "\(year)-\(month)-\(day)") as NSDate?
    }
    
}
