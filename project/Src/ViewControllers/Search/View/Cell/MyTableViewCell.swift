//
//  MyTableViewCell.swift
//  project
//
//  Created by tranthanh on 3/7/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var miniImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    fileprivate func getSever() {
       nameLbl.text = lesson?.name
        miniImageView.kf.setImage(with: URL(string: lesson?.image ?? ""))
        switch lesson?.type {
               case LessonType.TYPE_AUDIO:
                    self.iconImageView.image = #imageLiteral(resourceName: "hearing")
               case LessonType.TYPE_VIDEO:
                   self.iconImageView.image = #imageLiteral(resourceName: "video")
               case LessonType.TYPE_QUIZ:
                    self.iconImageView.image = #imageLiteral(resourceName: "decision")
               default:
                   self.iconImageView.image = #imageLiteral(resourceName: "hearing")
        }
    }
    
    var lesson : Lesson? {
        didSet {
            getSever()
        }
    }
    
}
