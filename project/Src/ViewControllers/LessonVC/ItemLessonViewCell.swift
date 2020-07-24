//
//  ItemLessonViewCell.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit

protocol ItemLessonViewDelegate {
    func onLessonClicked(curIndex: Int)
    func onSwitchStateChanged(curIndex: Int, isOn: Bool)
}

class ItemLessonViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var switch_state: UISwitch!
    
    var delegate: ItemLessonViewDelegate!
    
    var curIndex = 0
    var curItem: Lesson!
    
    func bind(index: Int, item: Lesson)  {
        self.curIndex = index
        self.curItem = item
        lblTitle.text = item.name
    }
    
    @IBAction func actionChangeState(_ sender: UISwitch) {
        delegate.onSwitchStateChanged(curIndex: curIndex, isOn: sender.isOn)
    }
    
    @IBAction func actionClicked(_ sender: UIButton) {
        delegate.onLessonClicked(curIndex: curIndex)
    }
    
    
    
}
