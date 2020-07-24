//
//  File.swift
//  AT-Fastfood-iOS
//
//  Created by Mac on 8/11/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import UIKit

class Menu {
    var id : String
    var title : String
    var icon : UIImage
    var status : String
    var isShowIcon : Bool
    
    init(id: String, title: String, icon : UIImage, _ showIcon: Bool = true) {
        self.id = id
        self.title = title
        self.icon = icon
        self.status = ""
        self.isShowIcon = showIcon
    }
    

}
