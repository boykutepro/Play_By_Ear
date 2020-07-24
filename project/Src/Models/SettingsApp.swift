//
//  Category.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class SettingsApp {
    var about: String
    var faq : String
    var help : String
    var term : String
    
    init(json: JSON) {
        self.about = json["about"].stringValue
        self.faq = json["faq"].stringValue
        self.help = json["help"].stringValue
        self.term = json["term"].stringValue
    }
}
