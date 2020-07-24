//
//  JsonParser.swift
//  
//
//  Created by SUUSOFT on 3/29/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import SwiftyJSON
class SearchFull {
       var songs: [Lesson]
       init() {
            self.songs = [Lesson]()
       }
}

struct JsonParser {
    static let shared = JsonParser()
    
    func parseStatusAndMessage(json: JSON) -> (status: String, message: String) {
        let status = json["status"].stringValue
        let message = json["message"].stringValue
        return (status, message)
    }
    
    
    //MARK: - User
    func parseUser(json: JSON) -> (status: String, message: String, user: User) {
        let token = json["login_token"].stringValue
        DataStoreManager.shared().saveToken(token: token)
        
        let tuple = parseStatusAndMessage(json: json)
        let user = User(json: json["data"])
        return (tuple.status, tuple.message, user)
    }
    
    
   
    //MARK: - Category
    func parseListCategories(json: JSON) -> (status: String, message: String, arrCategories: [Category], totalPage: Int) {
        let tuple = parseStatusAndMessage(json: json)
        var arrCategories = [Category]()
        let arrCategoriesJson = json["data"].arrayValue
        for categoryJson in arrCategoriesJson {
            let category = Category(json: categoryJson)
            arrCategories.append(category)
        }
        
        let totalPage = json["total_page"].intValue
        
        return (tuple.status, tuple.message, arrCategories, totalPage: totalPage)
    }
    
  
    //MARK: - Category
    func parseListDanhMuc(json: JSON) -> (status: String, message: String, list: [Category]) {
        let tuple = parseStatusAndMessage(json: json)
        var listChiTieu = [Category]()
        let arrCategoriesJson = json["data"].arrayValue
        for categoryJson in arrCategoriesJson {
            let object = Category(json: categoryJson)
            listChiTieu.append(object)
        }
        return (tuple.status, tuple.message, listChiTieu)
    }
    
   
    
   
    //MARK: - Category
    func parseListUser(json: JSON) -> (status: String, message: String, list: [User]) {
        let tuple = parseStatusAndMessage(json: json)
        var listChiTieu = [User]()
        let arrCategoriesJson = json["data"].arrayValue
        for categoryJson in arrCategoriesJson {
            let object = User(json: categoryJson)
            listChiTieu.append(object)
        }
        return (tuple.status, tuple.message, listChiTieu)
    }
   
    //MARK: - Lesson
    func parseLessons(json: JSON) -> (status: String, message: String, totalPage: Int,  list: [Lesson]) {
        let tuple = parseStatusAndMessage(json: json)
        var listChiTieu = [Lesson]()
        let arrCategoriesJson = json["data"].arrayValue
        for categoryJson in arrCategoriesJson {
            let object = Lesson(json: categoryJson)
            listChiTieu.append(object)
        }
        let totalPage = json["total_page"].intValue
        return (tuple.status, tuple.message, totalPage: totalPage, listChiTieu)
    }
    
    //MARK: - Lesson
       func parseQuestionAnswer(json: JSON) -> (status: String, message: String, totalPage: Int,  list: [QuestionAnswer]) {
           let tuple = parseStatusAndMessage(json: json)
           var listChiTieu = [QuestionAnswer]()
           let arrCategoriesJson = json["data"].arrayValue
           for categoryJson in arrCategoriesJson {
               let object = QuestionAnswer(json: categoryJson)
               listChiTieu.append(object)
           }
           let totalPage = json["total_page"].intValue
           return (tuple.status, tuple.message, totalPage: totalPage, listChiTieu)
       }
    
    func parseSearchFull(json: JSON) -> (status: String, message: String, searchFull: SearchFull) {
        let tuple = parseStatusAndMessage(json: json)
        let searchFull: SearchFull = SearchFull()
        var arrSongs = [Lesson]()
        let arrayTops = json["data"].arrayValue
        for categoryJson in arrayTops {
            let object = Lesson(json: categoryJson)
            arrSongs.append(object)
        }
        searchFull.songs = arrSongs
        return (tuple.status, tuple.message, searchFull)
    }
    
    
    
    func parseQuizz(json: JSON) -> (status: String, message: String, list: [QuestionAnswer]) {
        let tuple = parseStatusAndMessage(json: json)
        var list = [QuestionAnswer]()
        let arrCategoriesJson = json["data"].arrayValue
        for categoryJson in arrCategoriesJson {
            let object = QuestionAnswer(json: categoryJson)
            list.append(object)
        }
        return (tuple.status, tuple.message, list)
    }
   
    
    
    //MARK: - User
    func parseSetting(json: JSON) -> (status: String, message: String, setting: SettingsApp) {
        let tuple = parseStatusAndMessage(json: json)
        let user = SettingsApp(json: json["data"])
        return (tuple.status, tuple.message, user)
    }
    
    
    
}
