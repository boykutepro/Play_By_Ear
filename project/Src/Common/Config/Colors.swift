//
//  Colors.swift
//  project
//
//  Created by Mac on 8/15/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class Colors{

    // MARK: Colors for theme
    // MARK: Colors for theme
    static var primaryColor                 = "#7CDBDD"
    static var secondPrimaryColor           = "FDFDFD"
    static var errorQuestionColor           = "FF6D6D"
    static var primaryTextColor             = "5D5D5D"
    static var secondPrimaryTextColor       = "#8f8d8d"
    static var dividerColor                 = "#BDBDBD"
    static var primaryColorLight            = "#1679c4"
    static var tinColor                     = "#ffffff"
    static var buttonColor                  = "#727272"
    static var itemTabbarColor              = "#828282"
    
    //MARK:  Base for colors
    static let lightBlack                   = "1C1C1C"
    static let red                          = "F44336"
    static let blue                         = "6FCFF1"
    static let violet                       = "6FCFF1"
    static let white                        = "#ffffff"
    static let green                        = "#4CAF50"
    
    //MARK: settings screens
    static let bgDialog                     = "#88000000"
    static let bgSettings                   = "#ebebeb"
    static let dialogHeaderColor            = "#eee"
    static let dialogDivider                = "#e9e9e9"
    
    // check theme from user default. If theme was saved then read config theme from file
    // else read the default color in this class
    static func configTheme()  {
        let curTheme = DataStoreManager.shared().getSettingsTheme()
        if !curTheme.isEmpty {
            let object = JsonFileUtil.readJsonObjectRoot(fileName: "themes")
            let listTheme = object["data"].arrayValue
            for item in  listTheme{
                if item["name"].stringValue == curTheme {
                    Colors.primaryColor = item["primaryColor"].stringValue
                    Colors.secondPrimaryColor = item["primaryColorDark"].stringValue
                    Colors.primaryTextColor = item["primaryTextColor"].stringValue
                    Colors.secondPrimaryTextColor = item["secondPrimaryTextColor"].stringValue
                    Colors.primaryColorLight = item["primaryColorLight"].stringValue
                    Colors.dividerColor = item["dividerColor"].stringValue
                    Colors.tinColor = item["colorAccent"].stringValue
                    break
                }
            }
        }
        
    }
    
}

