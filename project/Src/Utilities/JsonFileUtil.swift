//
//  JsonFileUtil.swift
//  project
//
//  Created by Mac on 9/5/17.
//  Copyright © 2017 SUUSOFT. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonFileUtil{

    static func readJsonObjectRoot(fileName : String) -> JSON{
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null {
                    return jsonObj
                    
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

        return JSON.null
        
    }
    
   

}
