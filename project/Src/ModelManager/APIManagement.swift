//
//  APIManagement.swift
//
//
//  Created by SUUSOFT on 3/29/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation

struct APIManagement {
    
    //MARK: - Shared instance
    static let shared = APIManagement()
    
    typealias completionCommon = (_ status: String, _ message: String) -> Void
    
    
    //MARK: - Login , Register , Profile
    func user(pathURL: String, parameter: [String: AnyObject], actionFail: @escaping completionCommon, actionSuccess: @escaping (_ user: User?) -> Void) {
        var status = ""
        var message = ""
        var user: User? = nil
        // Send request to server
        RequestClient.shared.sendPostRequest(parameters: parameter, pathURL: pathURL) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseUser(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.success.rawValue {
                    user = tupple.user
                    actionSuccess(user)
                } else {
                     actionFail(status, message)
                }
            }
        }
    }
   
    
    //MARK: - Forgot Password , Change Password , Subscription, Favourite Photo & UnFavourite Photo
    func common(pathURL: String, parameter: [String: AnyObject], actionFail: @escaping completionCommon, actionSuccess: @escaping completionCommon) {
        var status = ""
        var message = ""
        // Send request to server
        RequestClient.shared.sendPostRequest(parameters: parameter, pathURL: pathURL) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseUser(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.error.rawValue {
                    actionFail(status, message)
                } else {
                    actionSuccess(status, message)
                }
            }
        }
    }
    
    //MARK:
    func getCategoris(parameter: [String: AnyObject],actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ arrCategories: [Category]) -> ())) {
        var status = ""
        var message = ""
        var arrCategories = [Category]()
        let url = API.listCategory
        // Send request to server
        RequestClient.shared.sendPostRequest(parameters: parameter, pathURL: url) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseListCategories(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.error.rawValue {
                    actionFail(status, message)
                } else {
                    arrCategories = tupple.arrCategories
                    actionSuccess(status, message, arrCategories)
                }
            }
        }
    }
    
   
    
    
    //MARK: - Category
    func listCategories( url: String,  parameter: [String: AnyObject], actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ totalPage: Int ,_ arrCategories: [Category]) -> ())) {
        var status = ""
        var message = ""
        var arrCategories = [Category]()
       
        // Send request to server
        RequestClient.shared.sendPostRequest(parameters: parameter, pathURL: url) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseListCategories(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.error.rawValue {
                    actionFail(status, message)
                } else {
                    arrCategories = tupple.arrCategories
                    actionSuccess(status, message, tupple.totalPage ,arrCategories)
                }
            }
        }
    }
    
    //MARK: - Lesson
    func getLessons(parameter: [String: AnyObject]?, actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ totalPage: Int, _ arrCategories: [Lesson]) -> ())) {
        var status = ""
        var message = ""
        var arrCategories = [Lesson]()
//        let url = API.lessonCategory
         let url = API.lessonCategory
        // Send request to server
        RequestClient.shared.sendRequest(parameters: parameter, pathURL: url) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseLessons(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.error.rawValue {
                    actionFail(status, message)
                } else {
                    arrCategories = tupple.list
                    actionSuccess(status, message, tupple.totalPage, arrCategories)
                }
            }
        }
    }
    
    //MARK: - Lesson
        func getSubLessons(parameter: [String: AnyObject]?, actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ totalPage: Int, _ arrCategories: [Lesson]) -> ())) {
            var status = ""
            var message = ""
            var arrCategories = [Lesson]()
             let url = API.lessonSub
            // Send request to server
            RequestClient.shared.sendRequest(parameters: parameter, pathURL: url) { (error, json) in
                // Set status , message for earch case
                switch error {
                case .server:
                    status = ResponseStatus.error.rawValue
                    message = FFError.server.rawValue
                    actionFail(status, message)
                case .parse:
                    status = ResponseStatus.error.rawValue
                    message = FFError.parse.rawValue
                    actionFail(status, message)
                case .none:
                    let tupple = JsonParser.shared.parseLessons(json: json)
                    status = tupple.status
                    message = tupple.message
                    // Check error from response
                    if status == ResponseStatus.error.rawValue {
                        actionFail(status, message)
                    } else {
                        arrCategories = tupple.list
                        actionSuccess(status, message, tupple.totalPage, arrCategories)
                    }
                }
            }
        }
        
    //MARK: - Lesson
    func getListQuestionInput(parameter: [String: AnyObject]?, actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ totalPage: Int, _ arrCategories: [QuestionAnswer]) -> ())) {
               var status = ""
               var message = ""
               var arrCategories = [QuestionAnswer]()
                let url = API.listQuestion
               // Send request to server
               RequestClient.shared.sendRequest(parameters: parameter, pathURL: url) { (error, json) in
                   // Set status , message for earch case
                   switch error {
                   case .server:
                       status = ResponseStatus.error.rawValue
                       message = FFError.server.rawValue
                       actionFail(status, message)
                   case .parse:
                       status = ResponseStatus.error.rawValue
                       message = FFError.parse.rawValue
                       actionFail(status, message)
                   case .none:
                       let tupple = JsonParser.shared.parseQuestionAnswer(json: json)
                       status = tupple.status
                       message = tupple.message
                       // Check error from response
                       if status == ResponseStatus.error.rawValue {
                           actionFail(status, message)
                       } else {
                           arrCategories = tupple.list
                           actionSuccess(status, message, tupple.totalPage, arrCategories)
                       }
                   }
               }
           }
    
    
     //MARK: - Search Lesson
    
    func searchFullLesson(parameter: [String: AnyObject]?, actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String,_ searchFull: SearchFull) -> ())) {
            var status = ""
            var message = ""
            // Send request to server
          RequestClient.shared.sendPostRequest(parameters: parameter, pathURL: API.searchlesson) { (error, json) in
                // Set status , message for earch case
                switch error {
                case .server:
                    status = ResponseStatus.error.rawValue
                    message = FFError.server.rawValue
                    actionFail(status, message)
                case .parse:
                    status = ResponseStatus.error.rawValue
                    message = FFError.parse.rawValue
                    actionFail(status, message)
                case .none:
                    let tupple = JsonParser.shared.parseSearchFull(json: json)
                    status = tupple.status
                    message = tupple.message
                    // Check error from response
                    if status == ResponseStatus.error.rawValue {
                        actionFail(status, message)
                    } else {
                        actionSuccess(status, message, tupple.searchFull)
                    }
                }
            }
        }
    
    
    
    //MARK: - Package
    func getSetting(actionFail: @escaping completionCommon, actionSuccess: @escaping ((_ status: String, _ message: String, _ setting: SettingsApp) -> ())) {
        var status = ""
        var message = ""
     
        let url = API.settings
        // Send request to server
        RequestClient.shared.sendPostRequest(parameters: nil, pathURL: url) { (error, json) in
            // Set status , message for earch case
            switch error {
            case .server:
                status = ResponseStatus.error.rawValue
                message = FFError.server.rawValue
                actionFail(status, message)
            case .parse:
                status = ResponseStatus.error.rawValue
                message = FFError.parse.rawValue
                actionFail(status, message)
            case .none:
                let tupple = JsonParser.shared.parseSetting(json: json)
                status = tupple.status
                message = tupple.message
                // Check error from response
                if status == ResponseStatus.error.rawValue {
                    actionFail(status, message)
                } else {
                    actionSuccess(status, message, tupple.setting)
                }
            }
        }
    }
    
   
   
}
