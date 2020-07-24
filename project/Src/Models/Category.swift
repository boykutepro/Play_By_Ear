//
//  Category.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var id: String
    var name: String
    var description: String
    var image: String
    var image_banner: String
    var status: String
    var isChecked: Bool = false
    var parentId: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.image = json["img_thumb"].stringValue
        self.image_banner = json["img_banner"].stringValue
        self.status = ""
        self.description = json["description"].stringValue
        self.parentId = json["parent_id"].stringValue
    }
}
