//
//  NavBarViewController.swift
//  project
//
//  Created by Mac on 8/17/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import LBTATools

class NavBarViewController: BaseViewController, NavBarDelegate {

    var navBar: NavBarView!
    let heightSceen: CGFloat = UIScreen.main.bounds.height
    let widthSceen: CGFloat = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarColor()
        initNavBar()
    }
    
    // MARK: For NAV
    func setNavTitle(title : String)  {
        navBar.setTitle(title: title)
    }
    
    func setNavBackgroundColor(color : String)  {
        navBar.setBackgroud(color: color)
    }
    
    // action for menu button. Show or hide left menu
   
    
    func onNavBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // init nav bar
    func initNavBar()  {
        var barHeight = 20
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                break
            case 1334:
                print("iPhone 6/6S/7/8")
                break
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                break
            case 2436:
                print("iPhone X, XS")
                barHeight = 44
                break
            case 2688:
                print("iPhone XS Max")
                barHeight = 44
                break
            case 1792:
                print("iPhone XR")
                barHeight = 44
                break
            default:
                print("Unknown")
            }
        }
        
//        navBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 44))
        navBar = NavBarView(frame: CGRect(x: 0, y: barHeight, width: Int(widthSceen), height: 44))
        navBar.isNavBar = isNavBar()
        navBar.delegate = self
        navBar.configMenuButton()
        view.addSubview(navBar)
      
        
    }
    
    // MARK: for Status Bar
    // set color for status bar
   
    
    func  isNavBar() -> Bool {
        return false
    }
    
    func addActionMenu(id : Int, image : UIImage)  {
        navBar.addActionMenu(id: id, image: image)
    }
    
    func updateMenuImage(tag : Int,  image : UIImage)  {
        navBar.updateMenuImage(tag : tag, image : image)
    }
    
    override func onChangeTheme() {
        configTheme()
    }
    
    func configTheme(){
        setNavBackgroundColor(color: Colors.primaryColor)
        setStatusBarColor()
    }    
}
