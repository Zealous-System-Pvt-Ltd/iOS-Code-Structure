//
//  DefaultManager.swift
//  CodeStructure
//
//  Created by Admin on 22/05/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

let ACCESSTOKEN   = "Accesstoken"
let LANGUAGE = "language"
let FILTERDATA = "Filter"
let SEARCH = "Search"
let SEARCHFOREVENT = "Event"
let SEARCHEVENT = "SearchEvent"
let INTEREST = "Interest"
let EVENTINTEREST = "EventInterest"
let SORT = "Sort"
let MINIMIZE = "Minimize"
let BROWSER = "Broswer"
let FIREBASETOKEN = "Firebasetoken"
let FONTSIZE = "Fontsize"
let PREVIOUSFONTSIZE = "PreviousFontsize"

class DefaultManager: NSObject
{
    
    //MARK: - Singleton
    override init()
    {
        super.init()
    }
    
    static let sharedInstance : DefaultManager = {
        let instance = DefaultManager()
        return instance
    }()
    
    class func runningOnSimulator() -> Bool
    {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
    
    //MARK: - Access Token
    class func GetAccessToken() -> String
    {
        var accessToken:String? = nil
        if let key = UserDefaults.standard.object(forKey: ACCESSTOKEN) as? String {
            accessToken = key
        }
        
        if accessToken != nil {
            return UserDefaults.standard.value(forKey: ACCESSTOKEN) as! String
        }else{
            return ""
        }
        
    }
    //MARK: - FCM Token
    class func GetFCMToken() -> String
    {
        var accessToken:String? = nil
        if let key = UserDefaults.standard.object(forKey: FIREBASETOKEN) as? String {
            accessToken = key
        }
        
        if accessToken != nil {
            return UserDefaults.standard.value(forKey: FIREBASETOKEN) as! String
        }else{
            return ""
        }
        
    }
    
    class func SetFCMToken(_ clientUserToken: String) {
        UserDefaults.standard.set(clientUserToken, forKey: FIREBASETOKEN)
        UserDefaults.standard.synchronize()        
    }

    class func setAccessToken(_ clientUserToken: String) {
        UserDefaults.standard.set(clientUserToken, forKey: ACCESSTOKEN)
        UserDefaults.standard.synchronize()
        
    }

    //MARK:- GET CHANGE LANGUAGE
    class func GetCurrentLanguage() -> String {
        var language:String? = nil
        if let key = UserDefaults.standard.object(forKey: LANGUAGE) as? String {
            language = key
        }
        
        if language != nil {
            return UserDefaults.standard.value(forKey: LANGUAGE) as! String
        }else{
//            return "en"
            return Locale.current.languageCode!
        }
    }
    
    //MARK:- SET CHANGE LANGUAGE
    class func SetCurrentLanguage(_ language: String){
        UserDefaults.standard.set(language, forKey: LANGUAGE)
        UserDefaults.standard.synchronize()
    }
}
