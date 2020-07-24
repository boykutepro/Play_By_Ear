//
//  ItemConversationCell.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit

class ItemConversationCell: UITableViewCell {
    
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(item: Conversation) {
        self.lblContent.attributedText = item.text.htmlToAttributedString
        if item.isHighlight {
            lblContent.textColor = UIColor.purple
        }else{
            lblContent.textColor = UIColor.black
        }
    }
    
    func setTextHighLight()  {
        lblContent.textColor = UIColor.purple
    }
    
    func unHighLight()  {
        lblContent.textColor = UIColor.black
    }
    
}
