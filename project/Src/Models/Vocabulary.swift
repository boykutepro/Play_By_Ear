//
//  Category.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Vocabulary {
    var id: Int
    var mean: String
    var image: String
    var word: String = ""
    var pronunciation: String
    var expanded = false
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.mean = json["mean"].stringValue
        self.image = json["image"].stringValue
        self.word = json["word"].stringValue
        self.pronunciation = json["pronunciation"].stringValue
        
    }
    
    
}
