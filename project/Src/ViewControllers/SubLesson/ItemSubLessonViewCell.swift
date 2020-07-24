//
//  ItemLessonViewCell.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit

class ItemSubLessonViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgLesson: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    fileprivate func getSever() {
        lblTitle.text = lesson?.name
        imgLesson.kf.setImage(with: URL(string: lesson?.image ?? ""))
        
        switch lesson?.type {
        case LessonType.TYPE_AUDIO:
             self.iconImageView.image = #imageLiteral(resourceName: "hearing")
        case LessonType.TYPE_VIDEO:
            self.iconImageView.image = #imageLiteral(resourceName: "video")
        case LessonType.TYPE_QUIZ:
             self.iconImageView.image = #imageLiteral(resourceName: "decision")
        default:
            self.iconImageView.image = #imageLiteral(resourceName: "decision")
        }
       
    }
    
    var lesson : Lesson? {
        didSet {
            getSever()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utilities.createBorder(for: viewContent, color: UIColor.colorWithHexString(Colors.dividerColor), width: 1)
    }
    
    func getfileUrl(){
        
    }
    
}
