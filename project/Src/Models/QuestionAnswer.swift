//
//  Category.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionAnswer {
    var id: Int
    var question: String
    var image: String
    var answer: String = ""
    var explaination: String
    var attachment: String
    var tip: String
    var level: String
    var suggest = [Suggest]()
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.question = json["question"].stringValue
        self.image = json["image"].stringValue
        self.answer = json["answer"].stringValue
        self.explaination = json["explaination"].stringValue
        self.attachment = json["attachment"].stringValue
        self.tip = json["tip"].stringValue
        self.level = json["level"].stringValue
        
        let suggesJson = json["answer_response"].arrayValue
        for item in suggesJson {
            let sug = Suggest(json: item)
            self.suggest.append(sug)
        }
        
    }
    
    
}
