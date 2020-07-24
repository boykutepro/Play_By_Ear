//
//  ItemDialogViewCell.swift
//  project
//
//  Created by Mac on 9/1/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import UIKit

class ItemDialogViewCell: UITableViewCell {
    
    @IBOutlet weak var imgKun: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bind(item : SettingObj) {
        lblTitle.text = item.title
        
        if item.color.isEmpty {
            imgKun.isHidden = true
        }else if !item.color.isEmpty && item.isColor(){
            imgKun.backgroundColor = UIColor.colorWithHexString(item.color)
        }else if !item.image.isEmpty && !item.isColor(){
            imgKun.image = UIImage(named: item.image)
        }
    }


    
}
