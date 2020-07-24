//
//  SettingObj.swift
//  project
//
//  Created by Mac on 9/1/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit

class SettingObj{
    var id : String
    var title : String
    var color : String
    var image : String
    var typeOfImage : TypeOfImageSettings
    var type : SettingType
    
    init(id: String, title : String, type : SettingType ,_ color : String = "" , _ image: String = "", _ typeOfImage : TypeOfImageSettings = TypeOfImageSettings.COLOR) {
        self.id =  id
        self.title = title
        self.color = color
        self.image = image
        self.type = type
        self.typeOfImage = typeOfImage
    }
    
    func isColor() -> Bool {
        if typeOfImage == TypeOfImageSettings.COLOR {
            return true
        }
        return false
    }
    
    func isLanguage() -> Bool {
        if type == SettingType.LANGUAGE {
            return true
        }
        return false
    }
    
    func isTheme() -> Bool {
        if type == SettingType.THEME {
            return true
        }
        return false
    }
    
    static func getThemeList() -> [SettingObj]{
        var datas = [SettingObj]()
        
        let object = JsonFileUtil.readJsonObjectRoot(fileName: "themes")
        
        let listTheme = object["data"].arrayValue
        for item in  listTheme{
            let item = SettingObj(
                id: item["id"].stringValue,
                title: item["name"].stringValue,
                type : SettingType.THEME,
                item["primaryColor"].stringValue,
                "",
                TypeOfImageSettings.COLOR)
            datas.append(item)
        }
        
        return datas
    }
    
    static func getLanguageList() -> [SettingObj] {
        var datas = [SettingObj]()
        
        let object = JsonFileUtil.readJsonObjectRoot(fileName: "languages")
        
        let listTheme = object["data"].arrayValue
        for item in  listTheme{
            let item = SettingObj(
                id: item["code"].stringValue,
                title: item["name"].stringValue,
                type : SettingType.LANGUAGE
            )
            
            datas.append(item)
        }
        
        return datas
        
    }
    
}

enum TypeOfImageSettings {
    case COLOR
    case IMAGE
}

enum SettingType {
    case LANGUAGE
    case THEME
}
