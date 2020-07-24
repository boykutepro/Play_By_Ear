//
//  SlidingTabStripController.swift
//  project
//
//  Created by tranthanh on 2/27/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class  SlidingTabStripController: ButtonBarPagerTabStripViewController {
    
    
    override func viewDidLoad() {
        configureTabbar()
        super.viewDidLoad()
        listenerNotificationForSettings()
     }

    func configureTabbar()  {
        settings.style.buttonBarBackgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
        settings.style.buttonBarItemBackgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
        settings.style.selectedBarBackgroundColor = UIColor.colorWithHexString(Colors.white)
        
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:18) ?? UIFont.systemFont(ofSize: 18)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        settings.style.buttonBarLeftContentInset = 16
        settings.style.buttonBarRightContentInset = 16
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.colorWithHexString(Colors.secondPrimaryTextColor)
            newCell?.label.textColor = UIColor.colorWithHexString(Colors.primaryTextColor)
        }
        
    }
    
    func listenerNotificationForSettings()  {
        // listener for change language settings
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeLanguage), name: Notification.Name(rawValue: NotificationID.CHANGE_LANGUAGE), object: nil )
        
        // listener for change language settings
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeTheme), name: Notification.Name(rawValue: NotificationID.CHANGE_THEME), object: nil )
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: NotificationID.CHANGE_THEME), object: nil)
    }
    
    @objc  func onChangeLanguage()  {
        
    }
    
   @objc func onChangeTheme()  {
        configureTabbar()
        buttonBarView.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
        buttonBarView.reloadData()
    }
}

