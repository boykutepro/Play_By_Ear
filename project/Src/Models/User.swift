//
//  User.swift
//  PhotoAlbum
//
//  Created by SUUSOFT on 7/4/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON
import os.log

class User : NSObject, NSCoding {
    
    
    //MARK: Archiving Paths
    var id: String
    var name: String
    var userName: String
    var email: String
    var type: String
    var image: String
    var phone: String
    var balance: Int64
    
    var birthday: String
    var address: String
    var status: Int
    var isFollowed: Bool
    var gender: Int
    var isPremium: Int = 0
    
    override init() {
        self.id = ""
        self.name = ""
        self.userName = ""
        self.email = ""
        self.type = ""
        self.image = ""
        self.phone = ""
        self.balance = 0
        self.birthday = ""
        self.address = ""
        self.status = 1
        self.isFollowed = false
        self.gender = 1
        self.isPremium = 0
        
    }
    
    init(id: String, name : String, userName : String, email : String, _ image: String = "", type : String, balance: Int64, birthday: String, phone: String, gender: Int, address: String, is_premium: Int) {
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.type = type
        self.image = image
        self.phone = phone
        self.balance = balance
        self.birthday = birthday
        self.address = address
        self.status = 1
        self.isFollowed = false
        self.isPremium = is_premium
        self.gender = gender
        
        
    }
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.userName = json["email"].stringValue
        self.email = json["email"].stringValue
        self.type = json["type"].stringValue
        self.image = json["avatar"].stringValue
        self.phone = json["phone"].stringValue
        self.balance = json["balance"].int64Value
        self.birthday = json["dob"].stringValue
        self.status = json["status"].intValue
        self.gender = json["gender"].intValue
        self.isFollowed = false
        self.address = json["address"].stringValue
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(balance, forKey: "balance")
        
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(isPremium, forKey: "isPremium")
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let userName = aDecoder.decodeObject(forKey: "userName") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let address = aDecoder.decodeObject(forKey: "address") as! String
        let birthday = aDecoder.decodeObject(forKey: "birthday") as! String
        //let status = aDecoder.decodeInteger(forKey: "status")
        let balance = aDecoder.decodeInt64(forKey: "balance")
        
        let gender = aDecoder.decodeInteger(forKey: "gender")
        let isPremium = aDecoder.decodeInteger(forKey: "isPremium")
        
        self.init(id: id, name: name, userName: userName, email: email, image, type: type, balance: balance, birthday: birthday, phone: phone, gender: gender, address: address, is_premium: isPremium)
    }
    
    func isPremiumAcc() -> Bool {
        return isPremium == 1 ? true : false
    }
    
    func checkPremium() -> Bool  {
        let user = DataStoreManager.shared().getUser()
        
        return user.isPremium == 1 ? true : false
    }
    
}
