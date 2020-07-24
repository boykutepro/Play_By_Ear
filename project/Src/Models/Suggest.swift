//
//  Category.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Suggest {
    var id: Int = 0
    var question: String = ""
    var image: String = ""
    var is_correct: Int = 0
    var a: String
    var b: String
    var c: String
    var d: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.a = json["A"].stringValue
        self.b = json["B"].stringValue
        self.c = json["C"].stringValue
        self.d = json["D"].stringValue
        
    }
    
    
}
