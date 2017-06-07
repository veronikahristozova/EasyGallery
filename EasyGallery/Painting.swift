//
//  Painting.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/6/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Painting {
    let author: String
    let name: String
    let pictureURL: String
    let year: Int
    let ref: DatabaseReference?
    
    init(name: String, pictureURL: String, author: String, year: Int) {
        self.author = author
        self.name = name
        self.pictureURL = pictureURL
        self.ref = nil
        self.year = year
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["Name"] as! String
        author = snapshotValue["Author"] as! String
        pictureURL = snapshotValue["PictureURL"] as! String
        year = snapshotValue["Year"] as! Int
        ref = snapshot.ref
    }
    func toAnyObject() -> Any {
        return [
            "ID": 2,
            "Name": name,
            "Author": author,
            "PictureURL": pictureURL,
            "Year": year
        ]
    }
}
