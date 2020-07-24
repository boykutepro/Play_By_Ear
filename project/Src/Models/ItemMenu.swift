//
//  ItemMenu.swift
//  project
//
//  Created by Mac on 8/24/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit

class ItemMenu {
    var id : Int
    var image : UIImageView
    var isHidden : Bool
    
    init(id : Int, image: UIImageView, _ isHidden: Bool = false) {
        self.id = id
        self.image = image
        self.isHidden = isHidden
    }
    
}
