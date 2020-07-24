//
//  Conversation.swift
//  project
//
//  Created by SUUSOFT on 8/4/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class Conversation {
    var id: Int = 0
    var text: String = ""
    var duration: Int = 0
    var question_id: String = ""
    var questionAnswer: QuestionAnswer!
    var isHighlight : Bool = false
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.duration = json["time"].intValue
        self.text = json["text"].stringValue
        self.question_id = json["question_id"].stringValue
        self.questionAnswer = QuestionAnswer(json: json["questionAnswer"])
    }
    
    
    
}
