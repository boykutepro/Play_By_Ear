//
//  Global.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    // Token
    static var deviceToken = ""
    static var loginToken = ""
    static let FCM_KEY_SERVER = "AIzaSyD72MkG6li0f_w9jSq9f5A_bsrp_u-3puE"
    // User
//    static var currentUser: User!
    
}

// language
func Localized(_ key: String) -> String{
    return key.localized()
}

var FAVORITE_LESSON = [Lesson]() {
    didSet {
        var listBook = [[String: AnyObject]]()
        for book in FAVORITE_LESSON {
            listBook.append(book.encode())
        }
        UserDefaults.standard.set(listBook, forKey: "FAVORITE_LESSON")
    }
}

var DOWNLOADED_LESSON = [Lesson]() {
    didSet {
        var listBook = [[String: AnyObject]]()
        for book in DOWNLOADED_LESSON {
            listBook.append(book.encode())
        }
        UserDefaults.standard.set(listBook, forKey: "DOWNLOADED_LESSON")
    }
}

