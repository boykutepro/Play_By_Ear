//
//  Lesson.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LessonType {
    static let TYPE_AUDIO = "audio"
    static let TYPE_TEXT = "text"
    static let TYPE_VIDEO = "video"
    static let TYPE_QUIZ = "quizz"
     static let TYPE_LOCAL = "local"
}

class Lesson {
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var status: String = ""
    var link_url: String = ""
    var overview: String = ""
    var content: String = ""
    var level: String = ""
    var type: String = ""
    var songs_count = 0
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.image = json["img_thumb"].stringValue
        self.link_url = json["attachment"].stringValue
        self.overview = json["content"].stringValue
        self.content = json["description"].stringValue
        self.level = json["level"].stringValue
        self.type = json["type"].stringValue
        self.songs_count = json["songs_count"].intValue 
    }
    

    func getUrl() -> URL {
        if type == "local" {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(link_url)
            return fileURL
        }
        return URL(string: link_url)!
    }
    
    
    init(data: [String: AnyObject]) {
        if let id = data["id"] as? Int {
            self.id = id
        }
        if let name = data["name"] as? String {
            self.name = name
        }
        if let image = data["image"] as? String {
            self.image = image
        }
        if let status = data["status"] as? String {
            self.status = status
        }
        if let link_url = data["link_url"] as? String {
            self.link_url = link_url
        }
        if let overview = data["overview"] as? String {
            self.overview = overview
        }
        if let type = data["type"] as? String {
            self.type = type
        }
        
    }
  
    // Encode
    public func encode() -> [String: AnyObject] {
        var dictionary : Dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        dictionary["name"] = name as AnyObject
        dictionary["image"] = image as AnyObject
        dictionary["status"] = status as AnyObject
        dictionary["link_url"] = link_url as AnyObject
        dictionary["overview"] = overview as AnyObject
        dictionary["type"] = type as AnyObject
        return dictionary
    }
    
    
}
