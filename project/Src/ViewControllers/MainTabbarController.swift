//
//  TabbarController.swift
//  project
//
//  Created by tranthanh on 2/20/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit
import MBProgressHUD
import XLPagerTabStrip
import Alamofire
import SwiftyJSON


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
    /// Return an UINib object from the nib file with the same name.
    class var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    class var viewFromNib: UIView? {
        let views = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)
        let view = views![0] as! UIView
        return view
    }
}

class MainTabBarController:  UITabBarController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.colorWithHexString(Colors.secondPrimaryColor)
        self.tabBar.tintColor = UIColor.colorWithHexString(Colors.primaryColor)
        self.tabBar.unselectedItemTintColor = UIColor.colorWithHexString(Colors.itemTabbarColor)
        self.tabBar.clipsToBounds = true
        initTabs()
    }
    func initTabs() {
        let homeVC = initVCForTabbar(type: HomeViewController.self, vcStr: HomeViewController.className, title: "Home", icon: "icons8_home")
        let favoriteVC = initVCForTabbar(type: FavoriteController.self, vcStr: FavoriteController.className, title: "Favorited", icon: "heart1")
        let downloadVC = initVCForTabbar(type: DownloadedViewController.self, vcStr: DownloadedViewController.className, title: "Downloaded", icon: "icons8_downloads")
        let accountVC = initVCForTabbar(type: AccountController.self, vcStr: AccountController.className, title: "Account", icon: "icons8_user")
        self.setViewControllers([homeVC!,favoriteVC!,downloadVC!,accountVC!], animated: true)
    }
    
    func initVCForTabbar<T: UIViewController>(type: T.Type, vcStr: String, title: String, icon: String) -> T? {
        let item = UITabBarItem()
        item.title = title
        item.image = UIImage(named: icon)
        let viewController = T(nibName: vcStr, bundle: nil)
        viewController.tabBarItem = item
        return viewController
    }
    
}
