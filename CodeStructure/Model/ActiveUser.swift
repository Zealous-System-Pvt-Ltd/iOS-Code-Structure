//
//  ActiveUser.swift
//  CodeStructure
//
//  Created by Admin on 20/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

// ActiveUser Model
class ActiveUser : Codable {

    var activeUser : UserDetail!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
                            
        var responseJson = json["response"]["user"]
        if !responseJson.isEmpty {
            activeUser = UserDetail(fromJson: responseJson)
        } else {
            responseJson = json["response"]
            activeUser = UserDetail(fromJson: responseJson)
        }
    }
}

// UserDetail Model
class UserDetail : Codable {
        
    var userID : Int!
    var firstName : String!
    var lastName : String!
    var profile_url : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty {
            return
        }
        
        userID = json["userID"].intValue
        firstName = json["firstName"].stringValue
        lastName = json["lastName"].stringValue
        profile_url = json["profile_url"].stringValue
    }
}

class Helper {
    
    //Get Active user detail
    //Active Status
    class func getActiveUserDetail() -> ActiveUser?{
        
        guard let data = UserDefaults.standard.object(forKey: "ActiveUser") as? Data else {
            return nil
        }
        do {
            
            let jsonDecoder = JSONDecoder()
            let activeData = try jsonDecoder.decode(ActiveUser.self, from: data)
            return activeData
            
        }catch {
            
            print("Failed to decode of Active user data")
            return nil
        }
    }
    
    //Save Active user detail
    //Active Status
    class func saveActiveUserDetail(_ object : ActiveUser?) {
        
        do {
            let jsonEncoder = JSONEncoder()
            let data = try  jsonEncoder.encode(object)
            UserDefaults.standard.set(data, forKey: "ActiveUser")
            _theActiveUser = object
        }catch {
            print("Failed to encode of Active user data")
        }
    }
}
