//
//  Constant.swift
//  CodeStructure
//
//  Created by Admin on 04/02/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

//LOGIN USER
var _theActiveUser: ActiveUser! {
    get{
        return Helper.getActiveUserDetail()
    }set{
        
    }
}

//GOOGLE
var Google_Client_ID = "AIzaSyB6lpe-wnrj7Ilgti8dwe3qAcyNRrJxOSE"

struct BasePath {
    
    // Stripe API key
    static var StripeKey = "pk_test_51HcDyIDgSIr6UuDSfKei1MOqaIIbO41Qa8D8aZdy4Tn1zEvMdppsXV33vnilXIiFfVtoKnYtlo1ONJc6QXncSEG500bcFaQBua" // Test
    //static var StripeKey = "pk_live_51HcDyIDgSIr6UuDSFaDGEiAIiypTbm8enIzi4tqYIiyvkY6EPaVupDq4AMbXkfwOIn6vhsUddm5pBoCnwr1vxwSA00zr8c3PpL" // Live

    static var Path                           = "\(BasePath)api/"
    static var BasePath                       = "https://dev.zealousys.com/public/"
}

struct Path {
    
    static let Login                        = "\(BasePath.Path)login"
    static let GetProfileTeacher            = "\(BasePath.Path)get-profile"
    static let SearchTeacher                = "\(BasePath.Path)search"
}

//MARK: - Screen Size
struct ScreenSize {    
    static let width         = UIScreen.main.bounds.size.width
    static let height        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.width, ScreenSize.height)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6PLUS      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_11        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

//MARK:- GET HEIGHT OF STATUS BAR
func GetHeightofNavBar()->CGFloat{
    var statusHeight: CGFloat!
    if #available(iOS 13.0, *) {
         statusHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height
    } else {
        // Fallback on earlier versions
        statusHeight = UIApplication.shared.statusBarFrame.height
    }
    return 43.0 + statusHeight
}

//MARK: Action sheet function
func showProfilePicAction(strMessage: String, completion:@escaping ((Int)->())) {
    let actionSheet = UIAlertController(title: "App Name", message: strMessage, preferredStyle: .actionSheet)
    let alertCancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel) { (UIAlertAction) in
        completion(0)
    }
    let alertLibrarylAction = UIAlertAction(title: "Library".localized, style: .default) { (UIAlertAction) in
        completion(1)
    }
    let alertCameralAction = UIAlertAction(title: "Camera".localized, style: .default) { (UIAlertAction) in
        completion(2)
    }
    actionSheet.addAction(alertCancelAction)
    actionSheet.addAction(alertLibrarylAction)
    actionSheet.addAction(alertCameralAction)
    UIApplication.topViewController()?.present(actionSheet, animated: true, completion: nil)
}

struct ValidationMessage {
    
    static let selectLang                   = "Please select your Language.".localized
    
    //SINGIN
    static let enterEmail                   = "Please enter Email Address.".localized
    static let enterValidEmail              = "Please enter a valid Email Address.".localized
    static let enterYourPassword            = "Please enter password.".localized
    static let validPassword                = "Please enter atleast 6 characters password.".localized
    static let passwordNotMatch             = "Both password does not match.".localized
    static let enterOtp                     = "Please enter OTP.".localized
    
    static let somthingWrong                = "Something went wrong. Please try again later.".localized
    static let internetNotAvailable         = "No internet connection. Please check your internet connection.".localized
}
