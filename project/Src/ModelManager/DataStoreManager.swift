//
//  DataStoreManager.swift
//  project
//
//  Created by Mac on 8/28/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation

class DataStoreManager{
    
    // stored key
    let KEY_USER   = "KEY_USER_PREF"
    let KEY_SETTING_LANGUAGE   = "KEY_SETTING_LANGUAGE"
    let KEY_SETTING_KEEP_SCREEN   = "KEY_SETTING_KEEP_SCREEN"
    let KEY_SETTING_THEME   = "KEY_SETTING_THEME"
    let KEY_TOKEN   = "KEY_TOKEN"
    // varieable
    let userDefault = UserDefaults.standard
    
   
    // singleton
    private static var sharedDefault: DataStoreManager = {
        let object = DataStoreManager()
        return object
    }()
    
    class func shared() -> DataStoreManager {
        return sharedDefault
    }
    
     func saveToken(token : String)  {
           userDefault.set(token, forKey: KEY_TOKEN)
           userDefault.synchronize()
       }
       
       func getToken() -> String {
           if let value = userDefault.string(forKey: KEY_TOKEN){
               return value
           }
           return ""
       }
    
    
    //MARK: USER
    // save user
    func saveUser(user : User) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefault.set(data, forKey: KEY_USER)
        userDefault.synchronize()
    
    }
    
    func getUser() -> User {
        if let decoded = userDefault.object(forKey: KEY_USER) as? Data{
            let decodedData = NSKeyedUnarchiver.unarchiveObject(with: decoded ) as! User
            return decodedData
        }
        return User.init()
        
        
    }
    
    func clearUser()     {
        userDefault.removeObject(forKey: KEY_USER)
         DataStoreManager.shared().saveToken(token: "")
    }
    
    // MARK : SETTINGS
    func saveSettingsLanguage(key : String) {
        userDefault.set(key, forKey: KEY_SETTING_LANGUAGE)
        userDefault.synchronize()
    }
    
    func getSettingsLanguage() -> String {
        if let value = userDefault.string(forKey: KEY_SETTING_LANGUAGE) {
            return value
        }
        return LanguageCode.EN
    }
    
    func saveSettingsScreen(isKeep : Bool)  {
        userDefault.set(isKeep, forKey: KEY_SETTING_KEEP_SCREEN)
        userDefault.synchronize()
    }
    
    func isSettingsKeepScreen() -> Bool {
        return userDefault.bool(forKey: KEY_SETTING_KEEP_SCREEN)
    }
    
    func saveSettingsTheme(key : String) {
        userDefault.set(key, forKey: KEY_SETTING_THEME)
        userDefault.synchronize()
    }
    
    func getSettingsTheme() -> String {
        if let value = userDefault.string(forKey: KEY_SETTING_THEME){
            return value
        }
        return "Deep Purple"
    }
    
}
