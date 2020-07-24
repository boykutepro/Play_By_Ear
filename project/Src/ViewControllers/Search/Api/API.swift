//
//  API.swift
//  project
//
//  Created by tranthanh on 3/7/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import Alamofire
import UIKit

struct SearchResults: Decodable {
  let data: [LessonDecodable]
}


class APIService {
 static let shared = APIService()
    
    func fetchLesson(searchText : String ,comletionHandler : @escaping ([LessonDecodable]) -> () ){
        let param = [
        "token" : DataStoreManager.shared().getToken(),
        "keyword": searchText,
        "page": 1,
        "number_per_page" : 10
        ] as [String : Any]
         let url = API.baseURL + API.searchlesson
        Alamofire.request(url, method: .post, parameters: param , encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Lesson search failed", error)
                return
            }
            guard let data = dataResponse.data else {return}
            
            do {
                let searchResult =  try JSONDecoder().decode(SearchResults.self, from: data)
                print(searchResult)
                comletionHandler(searchResult.data)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
    
    
}
