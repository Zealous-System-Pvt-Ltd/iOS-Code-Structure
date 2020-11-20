//
//  Extension.swift
//  Admin
//
//  Created by Admin on 07/09/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVKit
import Alamofire
import Kingfisher
import Foundation
import SwiftyJSON
import CoreLocation
import AVFoundation
import AssetsLibrary
import NVActivityIndicatorView
import UserNotifications
import Kingfisher
import MessageUI
import Toaster

typealias ServiceResponse = (JSON, Error?) -> Void

// AppDelegate Shared Instance
var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

// Check Network Rechable
var isReachable: Bool {
    return NetworkReachabilityManager()!.isReachable
}

/// App's name (if applicable).
public var appDisplayName: String? {
    // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
    return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
}

/// Link of current app in appstore
public var appStoreLink: String {
    return "https://itunes.apple.com/us/app/my-sub/id1302095954?ls=1&mt=8"
    //return "itms-apps://itunes.apple.com/app/bars/id1302095954"
}

/// Shared instance of current device.
public var currentDevice: UIDevice {
    return UIDevice.current
}

// Current orientation of device.
public var deviceOrientation: UIDeviceOrientation {
    return currentDevice.orientation
}

/// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

/// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

/// App's bundle ID (if applicable).
public var appBundleID: String? {
    return Bundle.main.bundleIdentifier
}

/// Application icon badge current number.
public var applicationIconBadgeNumber: Int {
    get {
        return UIApplication.shared.applicationIconBadgeNumber
    }
    set {
        UIApplication.shared.applicationIconBadgeNumber = newValue
    }
}

/// App's current version (if applicable).
public var appVersion: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
}

/// Check if device is iPad.
public var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

/// Check if device is iPhone.
public var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

/// Check if application is running on simulator (read-only).
public var isRunningOnSimulator: Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}

///Document directory
public var doumentDirectory:String {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
}


/// Shared instance UIApplication.
public var sharedApplication: UIApplication {
    return UIApplication.shared
}

func callNumber(phoneNumber:String) {
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        if (sharedApplication.canOpenURL(phoneCallURL)) {
            sharedApplication.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}

// Get Latitude
var token:String {
    return UserDefaults.standard.value(forKey: "token") as? String ?? ""
}

// Return TimeZone
var timezone: String {
    return TimeZone.current.identifier
}

// User Default
var userPref: UserDefaults {
    return UserDefaults.standard
}

var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
}

var homeStoryboard: UIStoryboard {
    return UIStoryboard(name: "Home", bundle: nil)
}

func getWidth(_ text: String, _ fontSize: CGFloat) -> CGFloat {
    
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Roboto-BoldCondensed", size: fontSize)
    label.text = text
    label.sizeToFit()
    return label.frame.size.width
}

func getHeight(_ text: String, _ font: UIFont = UIFont(name: "Roboto-BoldCondensed", size: 17)!) -> CGFloat {
    let label = UILabel(frame: CGRect(x: 15, y: 0, width: screenWidth - 45, height: .greatestFiniteMagnitude))
    label.font = font
    label.text = text
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.sizeToFit()
    return ceil(label.frame.size.height)
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// Definition:
extension Notification.Name {
    static let homePostNotification = Notification.Name("HomeReferesh")
    static let buyPostNotification = Notification.Name("BuyReferesh")
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    func today() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
    }
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

// Return LoggedIn userId
var isLoggedIn: Bool {
    return userPref.object(forKey: "UserInfo") != nil
}

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}

extension UIViewController: NVActivityIndicatorViewable, MFMailComposeViewControllerDelegate {
    
//    func logOutUserFromApp(isMessage: Bool = true) {
//        if isMessage {
//            self.showTostMessage(message: "Your session is expired. Please login again", isSuccess: true)
//        }
//
//        _theUser = nil
//        UserDefaults.standard.removeObject(forKey: "ActiveUser")
//        UserDefaults.standard.synchronize()
//
//        let objHomeVC = mainStoryboard.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
//        let navigation = UINavigationController(rootViewController: objHomeVC)
//        navigation.navigationBar.isHidden = true
//        appDelegate.window?.rootViewController = navigation
//    }
    
    func loadViewControllerfromNib(VC :UIViewController,framsize:CGRect){
        self.removeChildViewController()
        VC.view.frame = framsize
        VC.willMove(toParent: self)
        self.view.addSubview(VC.view)
        self.addChild(VC)
        VC.didMove(toParent: self)
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }

    func showAlertForLocationEnable(){
       
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings This will help to find organization activities near you", preferredStyle: UIAlertController.Style.alert)
            
            let okbtn = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            
            let cancelbtn = UIAlertAction(title: "Cancel", style: .default, handler: {(cAlertAction) in
                self.showAlertForLocationEnable()
            })
            alertController.addAction(cancelbtn)
            
            alertController.addAction(okbtn)
           self.present(alertController, animated: true, completion: nil)
        }

    
    
    func removeChildViewController(){
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    
    func addchildcontroller(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    func convertToDictionary(text: String) -> [[String:Any]] {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
            } catch {
                print(error.localizedDescription)
                return []
            }
        }
        return []
    }
    
    //MARK:- Send Email
    func sendEmail(_ subject:String,_ email:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func removeAllDeliverNotification() {
        UIApplication.shared.applicationIconBadgeNumber = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
 
    // Go Back Action
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    // Go Back Action
    @IBAction func backTapped(_ sender: UIControl) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        let sidemenu = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController")
        self.navigationController?.present(sidemenu, animated: true)
    }
    
    // Return AuthToken
    func getToken() -> String {
        let authToken = UserDefaults.standard.object(forKey: "token")
        return (authToken == nil ? "" : authToken as! String)
    }
    
    // Return DeviceToken
    func getDeviceToken() -> String {
        let deviceToken = UserDefaults.standard.object(forKey: "DeviceToken")
        return (deviceToken == nil ? "" : deviceToken as! String)
    }
    
    // Showing Toast Message
    func showTostMessage(message: String, isSuccess:Bool = false, isFromBottom:Bool = true) {
        self.view.endEditing(true)
        if message != "" {
            ToastView.appearance().backgroundColor = isSuccess ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.8588235294, green: 0.3137254902, blue: 0.2901960784, alpha: 1)
            ToastView.appearance().textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            ToastView.appearance().font = UIFont(name: "Poppins-Regular", size: 14.0)
//            ToastView.appearance().bottomOffsetPortrait = isFromBottom ? (appDelegate.tabController == nil ? 30: appDelegate.tabController.tabBar.frame.size.height+8) : screenHeight - (UIApplication.shared.keyWindow?.safeAreaInsets.top)! - 50
            Toast(text: message).show()
        }
    }
    
    
    func showcustomConfirmation(title:String = "", message:String, completion:(() -> Void)?){
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.set(message: message, font: UIFont.boldSystemFont(ofSize: 15), color: .black)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            guard completion != nil else {
                return
            }
            completion!()
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmation(title:String = "CodeStructure", message:String, completion:(() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            guard completion != nil else {
                return
            }
            completion!()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //    func LoginSignInPopUp() {
//        let alertController = UIAlertController(title: nil, message: "Please select option", preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: { (alert) in
//            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            self.navigationController?.pushViewController(loginVC, animated: true)
//        }))
//        alertController.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { (alert) in
//            let signinVC = mainStoryboard.instantiateViewController(withIdentifier: "JoinRequiemVC") as! JoinRequiemVC
//            signinVC.isFromPopUp = true
//            self.navigationController?.pushViewController(signinVC, animated: true)
//        }))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
    
    func randomString() -> String {
        let len: Int = 3
        let needle : NSString = "0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len {
            let length = UInt32 (needle.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", needle.character(at: Int(rand)))
        }
        return randomString as String
    }
    
    // Show LoadingView When API is called
    func showLoading(_ color: UIColor = #colorLiteral(red: 0.9803921569, green: 0.7490196078, blue: 0.3137254902, alpha: 1)) {
        let size = CGSize(width: 40, height:40)
        startAnimating(size, message: nil, type: .ballClipRotate, color: color, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    }
    
    // Hide LoadingView
    func hideLoading() {
        stopAnimating()
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    
    // Listing of All Font Installed/Supported by System
    func fontName() {
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
    
    // Give Alpha Animation to the Selected View
    func setAlphaAnimation(selectedView: UIView, alpha: CGFloat) {
        if alpha == 1 {
            selectedView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            selectedView.alpha = alpha
        }) {
            (complete) -> Void in
            if alpha == 0 {
                selectedView.isHidden = true
            }
        }
    }
    
    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    // Check Location is Allowed or Not
    func isAllowLocation() -> Bool {
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        }
    }
    
    //MARK: - WebService Call
    func webServiceCall(_ url: String, param:[String:Any] = [String: Any](), isWithLoading: Bool = true, loaderColor: UIColor = #colorLiteral(red: 0.9803921569, green: 0.7490196078, blue: 0.3137254902, alpha: 1), imageKey: [String] = ["image"], imageData: [Data] = [],imageName:[String] = [], videoKey: [String] = ["video"], videoData: [Data] = [Data](), audioKey: [String] = ["audio"], audioData: [Data] = [Data](), isNeedToken: Bool = true,hidekeyboard:Bool = true, methods: HTTPMethod = .post, completionHandler:@escaping ServiceResponse) {
        
        print("URL :- \(url)")
        print("Parameter :- \(param)")
        if hidekeyboard{
            hideKeyboard()
        }
        
        if isReachable {
            
            if isWithLoading {
                showLoading(loaderColor)
            }
            
            var headers = HTTPHeaders()
            headers = [
                "accept": "application/json"
            ]
            if isNeedToken && _theActiveUser != nil {
                headers["Authorization"] = "Bearer \(token)"
            }
            
            print("HTTPHeaders :- \(headers) ")
            
            if imageData.count > 0 || videoData.count > 0 || audioData.count > 0 {
                
                AF.upload(multipartFormData: { MultipartFormData in
                    
                    for (key, value) in param {
                        MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                    for i in 0..<imageData.count {
                        if imageData[i].count > 0 {
                            let fileName = imageName.count > i ? imageName[i]:"file[\(i)]"
                            MultipartFormData.append(imageData[i], withName: imageKey[i], fileName: fileName, mimeType: "image/png")
                        }
                    }
                    
                    for i in 0..<videoData.count {
                        if videoData[i].count > 0 {
                            MultipartFormData.append(videoData[i], withName: videoKey[i], fileName: "file.mp4", mimeType: "video/mp4")
                        }
                    }
                    
                    for i in 0..<audioData.count {
                        if audioData[i].count > 0 {
                            MultipartFormData.append(audioData[i], withName: audioKey[i], fileName: "file.m4a", mimeType: "audio/m4a")
                        }
                    }


                      }, to: url, method: methods, headers: headers)
                 .responseJSON { (response) in
                          
                    switch response.result {
                    case .success(let value):
                        if let response = value as? [String: Any]{
                            let json = JSON(response)
                            completionHandler(json, nil)
                            print("JSON: - \(json)")
                        }
                    case .failure(let error):
                        print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)
                        
                        let response: [String: Any] = [
                            "errorCode": response.error?.responseCode as Any,
                            "status": false,
                            "message": ValidationMessage.somthingWrong
                        ]
                        
                        let json = JSON(response)
                        completionHandler(json, nil)
                        
                        print("JSON: - \(json)")

                    }

                    if isWithLoading {
                        self.hideLoading()
                    }

                 }
                
            }
            else
            {
                AF.request(url, method: methods ,parameters: param,headers: headers)
                    .responseJSON {  result in
                                                
                        switch result.result {
                        case .success(let value):
                            if let response = value as? [String: Any]{
                                let json = JSON(response)
                                completionHandler(json, nil)
                                print("JSON: - \(json)")
                            }
                        case .failure(let error):
                            print(NSString(data: result.data!, encoding: String.Encoding.utf8.rawValue)!)
                            
                            let response: [String: Any] = [
                                "errorCode": result.error?.responseCode as Any,
                                "status": false,
                                "message": ValidationMessage.somthingWrong
                            ]
                            
                            let json = JSON(response)
                            completionHandler(json, nil)
                            
                            print("JSON: - \(json)")

                        }

                        if isWithLoading {
                            self.hideLoading()
                        }
                }
            }
        }
        else {
            let response: [String: Any] = [
                "errorCode": "",
                "status": false,
                "message": ValidationMessage.internetNotAvailable
            ]
            
            let json = JSON(response)
            completionHandler(json, nil)
        }
    }
}
extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroudColor(color: UIColor) {
        if let bgView = self.view.subviews.first,
            let groupView = bgView.subviews.first,
            let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributedString, forKey: "attributedMessage")//4
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
extension UITextView {
    
    func setCharacterSpacing(characterSpacing: CGFloat = 0.0) {

         guard let labelText = text else { return }

         let attributedString: NSMutableAttributedString
         if let labelAttributedText = attributedText {
             attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
         } else {
             attributedString = NSMutableAttributedString(string: labelText)
         }

         // Character spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))

         attributedText = attributedString
     }

    
    func padding() {
        self.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.autocapitalizationType = .sentences
    }
    
}

extension UITextField {
    
    func setCharacterSpacing(characterSpacing: CGFloat = 0.0) {

         guard let labelText = text else { return }

         let attributedString: NSMutableAttributedString
         if let labelAttributedText = attributedText {
             attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
         } else {
             attributedString = NSMutableAttributedString(string: labelText)
         }

         // Character spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))

         attributedText = attributedString
     }

    
    func padding(width:Int = 12) {
        let padding = UIView(frame: CGRect(x: 0, y: 5, width: CGFloat(width), height: 12))
        self.rightView = padding
        self.rightViewMode = UITextField.ViewMode.always
        self.leftView = padding
        self.leftViewMode = UITextField.ViewMode.always
        self.autocapitalizationType = .sentences
    }
    
    func setPlaceHolderTextColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    func placeholder(text value: String, color: UIColor = .red) {
        self.attributedPlaceholder = NSAttributedString(string: value, attributes: [ NSAttributedString.Key.foregroundColor : color])
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UISearchBar {
    
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }
    
    func setSearchIcon(image: UIImage) {
        setImage(image, for: .search, state: .normal)
    }
    
    func setClearIcon(image: UIImage) {
        setImage(image, for: .clear, state: .normal)
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! // was image
    }
    
    
}
extension UIButton{
    
}

extension UILabel {
    
    func setColorofStringLabel(mainstring:String,colorstring:String,color:UIColor){
        let main_string = mainstring
        let string_to_color = colorstring

        let range = (main_string as NSString).range(of: string_to_color)

        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        self.attributedText = attribute
    }

    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }

        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
    
    func setCharacterSpacing(characterSpacing: CGFloat = 0.0) {

         guard let labelText = text else { return }

         let attributedString: NSMutableAttributedString
         if let labelAttributedText = attributedText {
             attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
         } else {
             attributedString = NSMutableAttributedString(string: labelText)
         }

         // Character spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))

         attributedText = attributedString
     }
   
    
    var isTruncated: Bool {
        
        guard let labelText = text else {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
    
    func getWidth() -> CGFloat{
       var rect: CGRect = self.frame //get frame of label
        rect.size = (self.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: self.font.fontName , size: self.font.pointSize)!]))! //Calculate as per label font
        return rect.width
    }
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
    
    func getHeight(width:CGFloat,numberOfLines:Int = 0) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    func heightForLabel(text:String, width:CGFloat) -> CGFloat{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}

extension Float {
        
    func makeCommaSeprator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.groupingSize = 3
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func makeAroundPointFifty() -> Float {
        var amount = Float(Int(self))
        if self > amount {
            let valueAbove = self - amount
            if valueAbove == 0.5 {
                return self
            } else if valueAbove > 0.5 {
                amount += 1
            } else {
                amount += 0.50
            }
        }
        return amount
    }
    
    func makeAroundPointFiftyLess() -> Float {
        var amount = Float(Int(self))
        if self > amount {
            let valueAbove = self - amount
            if valueAbove == 0.5 {
                return self
            } else if valueAbove > 0.5 {
                amount += 0.5
            } 
        }
        return amount
    }
}

extension String {
    
    public var isContainrOnlyCharacters: Bool {
        guard !isEmpty else {
            return false
        }
        let allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterSet = CharacterSet(charactersIn: allowed)
        guard rangeOfCharacter(from: characterSet.inverted) == nil else {
            return false
        }
        return true
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = self.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func SetLineSpaceofParagraph(linespace:CGFloat)->NSAttributedString{
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linespace
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
    

    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }

    
     func containsOnlyDigits() -> Bool
    {
        
        let notDigits = NSCharacterSet.decimalDigits.inverted
        
        if rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
        {
            return true
        }
        
        return false
    }
    
    func isValidPostalCode() -> Bool {
        let codeRegEx = "^[a-zA-Z][0-9][a-zA-Z][- ]*[0-9][a-zA-Z][0-9]$"
        
        let codeValid = NSPredicate(format:"SELF MATCHES %@", codeRegEx)
        return codeValid.evaluate(with: self)
    }
    
    // Check for Password Validation
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        if passwordValid.evaluate(with: self) {
            return true
        }
        return false
    }
    
    func isvalidPwd() -> Bool {
        if self.count >= 6 {
            return true
        }
        return false
    }
    
    func isvalidPhone() -> Bool {
        if (self.count >= 10 &&  self.count <= 12) {
            return true
        }
        return false
    }
    
    func isValidCapitalPassword() -> Bool {
        let passwordRegEx = ".*[A-Z]+.*"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordValid.evaluate(with: self)
    }
    
    func isValidLowerPassword() -> Bool {
        let passwordRegEx = ".*[A-Z]+.*"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordValid.evaluate(with: self)
    }
    
    func isValidNumberPassword() -> Bool {
        let passwordRegEx = ".*[0-9]+.*"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordValid.evaluate(with: self)
    }
    
    func isValidSpecialCharPassword() -> Bool {
        let passwordRegEx = ".*[!&^%$#@()/]+.*"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordValid.evaluate(with: self)
    }
    
    // Check for Valid Email Address
    func isValidEmail() -> Bool {
//        let emailRegEx = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"    //old
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //new
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimming())
    }
    
    // Check for String is Empty
    func isEmpty() -> Bool {
        return self.trimming().isEmpty
    }
    
    // Return the string after trimming
    func trimming() -> String {
        let strText = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return strText
    }
    
    func toDate(_ format:String = "dd/MM/yyyy") -> Date {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.date(from: self) ?? Date()
    }
    
    var encodeEmoji: String? {
        let encodedStr = NSString(cString: self.cString(using: String.Encoding.nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue)
        return encodedStr as String?
    }
    
    var decodeEmoji: String {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if data != nil {
            let valueUniCode = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue) as String?
            if valueUniCode != nil {
                return valueUniCode!
            } else {
                return self
            }
        } else {
            return self
        }
    }
    
    //MARK:- CONVERT DATE AS PER FORMATE
    func  ConvertDateasPerFormate() -> String{
        
        let dateFormatter = DateFormatter()
        if self.contains(":"){
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }
        let date = dateFormatter.date(from:self)!
        let datestr = date.toString(formates: "dd-MM-yyyy")
        return datestr
    }
    
    
    func convertTimeStampToDate() -> Date {
        let jsonDate = "/Date(\(self))/"
        let prefix = "/Date("
        let suffix = ")/"
        let scanner = Scanner(string: jsonDate)
        
        // Check prefix:
        guard scanner.scanString(prefix, into: nil)  else { return Date() }
        
        // Read milliseconds part:
        var milliseconds : Int64 = 0
        guard scanner.scanInt64(&milliseconds) else { return Date() }
        // Milliseconds to seconds:
        var timeStamp = TimeInterval(milliseconds)/1000.0
        
        // Read optional timezone part:
        var timeZoneOffset : Int = 0
        if scanner.scanInt(&timeZoneOffset) {
            let hours = timeZoneOffset / 100
            let minutes = timeZoneOffset % 100
            // Adjust timestamp according to timezone:
            timeStamp += TimeInterval(3600 * hours + 60 * minutes)
        }
        
        // Check suffix:
        guard scanner.scanString(suffix, into: nil) else { return Date() }
        
        // Success! Create NSDate and return.
        return Date(timeIntervalSince1970: timeStamp)
    }
}

extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension UITableView {
    // Set Text when no any Data found for TableView
    func setTextForBlankTableview(message : String, color: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)) -> Void {
        DispatchQueue.main.async {
            let messageLabel: UILabel = UILabel(frame: CGRect(x: 17, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            messageLabel.text = message
            messageLabel.textColor = color
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.init(name: "Poppins-Regular", size: 20.0)
            messageLabel.sizeToFit()
            self.backgroundView = messageLabel
        }
    }
    
    func setTextForBlankTableFooter(message : String, color: UIColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1),height:CGFloat = 50) -> Void {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Poppins-Regular", size: 17.0)
        self.tableFooterView = messageLabel
    }
    
    // Set Loader in FooterView When pagination is enable
    func makeFooterView(color: UIColor = #colorLiteral(red: 0.1098039216, green: 0.8078431373, blue: 0.8078431373, alpha: 1)) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let act = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 15, y: 10, width: 30, height: 30))
        act.color = color
        act.type = .ballClipRotate
        view.addSubview(act)
        act.startAnimating()
        self.tableFooterView = view
    }
    
    func makeHeaderView(color: UIColor = #colorLiteral(red: 0.1098039216, green: 0.8078431373, blue: 0.8078431373, alpha: 1)) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let act = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 15, y: 10, width: 30, height: 30))
        act.color = color
        act.type = .ballClipRotate
        view.addSubview(act)
        act.startAnimating()
        self.tableHeaderView = view
    }
    
    // Remove Footer View From Tableview
    func removeFooterView() {
        self.tableFooterView = UITableViewHeaderFooterView.init()
    }
    
    func removeHeaderView() {
        self.tableHeaderView = UITableViewHeaderFooterView.init()
    }
    
    // Add Pull to Refresh
    func addPullToRefresh(color: UIColor = #colorLiteral(red: 0.9803921569, green: 0.7490196078, blue: 0.3137254902, alpha: 1)) -> UIRefreshControl {
        let view = UIRefreshControl()
        view.tintColor = color
        self.addSubview(view)
        return view
    }
    
    func extraOperation(_ count:Int,_ isWhiteColor: Bool = false, message : String = "NO RECORD FOUND") {
        removeFooterView()
        if count == 0 {
            if isReachable {
                setTextForBlankTableview(message: message,color:isWhiteColor ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1))
            } else {
                setTextForBlankTableview(message: "There seems to be a network problem",color:isWhiteColor ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1))
            }
        } else {
            backgroundView = nil
        }
        reloadData()
    }
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
       
    }
    
}
extension UIView {
    
    func removeSublayer(_ view: UIView, layerIndex index: Int) {
        guard let sublayers = view.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > index {
            view.layer.sublayers!.remove(at: index)
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }

    func addGradient(frame: CGRect) {
        let gradientView = UIView(frame: self.frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.6, 0.5]
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        addSubview(gradientView)
    }
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}
extension UIImageView {
    
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
      contentMode = mode
      URLSession.shared.dataTask(with: url) { data, response, error in
          guard
              let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
              let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
              let data = data, error == nil,
              let image = UIImage(data: data)
              else { return }
          DispatchQueue.main.async() { [weak self] in
              self?.image = image
          }
      }.resume()
  }
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
      guard let url = URL(string: link) else { return }
      downloaded(from: url, contentMode: mode)
  }

    
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    // Download image and set into given imageview
    func setImage(image:String, placeholder: UIImage = UIImage(named: "icon_profile_w")!, aContentMode: ContentMode = .scaleAspectFill) {
        if image != "" {
            let url = URL(string: image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            self.image = nil
            self.contentMode = aContentMode
            var kf = self.kf
            kf.indicatorType = .activity
            self.kf.setImage(with: url, placeholder: placeholder,
                             options: [.transition(.fade(1))],
                             progressBlock: nil)
        } else {
            self.contentMode = placeholder == UIImage(named: "profile")! ? .center : .scaleAspectFill
            self.image = placeholder
        }
    }
    
    func setImageviewImage(url: String , placeHolderImage: String) {
        if url != ""
        {
            let placeholderImage = UIImage(named: placeHolderImage)
            var kf = self.kf
            kf.indicatorType = .activity
            kf.setImage(with: URL(string: url), placeholder: placeholderImage,
                        options: [.transition(.fade(1))],
                        progressBlock: nil)
        } else {
            self.image = UIImage(named: placeHolderImage)
            self.contentMode = .scaleAspectFit
            
        }
        self.clipsToBounds = true
    }
}

extension AVCaptureDevice {
    enum AuthorizationStatus {
        case justDenied
        case alreadyDenied
        case restricted
        case justAuthorized
        case alreadyAuthorized
        case unknown
    }

    class func authorizeVideo(completion: ((AuthorizationStatus) -> Void)?) {
        AVCaptureDevice.authorize(mediaType: AVMediaType.video, completion: completion)
    }

    class func authorizeAudio(completion: ((AuthorizationStatus) -> Void)?) {
        AVCaptureDevice.authorize(mediaType: AVMediaType.audio, completion: completion)
    }

    private class func authorize(mediaType: AVMediaType, completion: ((AuthorizationStatus) -> Void)?) {
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch status {
        case .authorized:
            completion?(.alreadyAuthorized)
        case .denied:
            completion?(.alreadyDenied)
        case .restricted:
            completion?(.restricted)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    if granted {
                        completion?(.justAuthorized)
                    } else {
                        completion?(.justDenied)
                    }
                }
            })
        @unknown default:
            completion?(.unknown)
        }
    }
}

extension UICollectionView {
    func setTextForBlankCollectionView(message : String, color: UIColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)) -> Void {
        let messageLabel: UILabel = UILabel(frame: CGRect(x: 17, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Poppins-Regular", size: 20.0)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func extraOperation(_ count:Int,_ isWhiteColor: Bool = false,message: String = "NO RECORD FOUND") {
        backgroundView = nil
        if count == 0 {
            if isReachable {
                setTextForBlankCollectionView(message: message,color:isWhiteColor ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1))
            } else {
                setTextForBlankCollectionView(message: "There seems to be a network problem",color:isWhiteColor ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1))
            }
        }
        reloadData()
    }
}

extension UIImage {
    
    func resizedImage(newSize: CGSize) -> UIImage
       {
           // Guard newSize is different
           guard self.size != newSize else { return self }
           
           UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
           self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
           let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
           return newImage
       }
    
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage
         {
             let widthFactor = size.width / rectSize.width
             let heightFactor = size.height / rectSize.height
             
             var resizeFactor = widthFactor
             if size.height > size.width {
                 resizeFactor = heightFactor
             }
             
             let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
             let resized = resizedImage(newSize: newSize)
             return resized
         }
    
    // Rotate Image by given Degree
    public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // Fix Orentation of Given Image
    func fixOrientation() -> UIImage {
        // No-op if the orientation is already correct
        if ( self.imageOrientation == UIImage.Orientation.up ) {
            return self;
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImage.Orientation.down || self.imageOrientation == UIImage.Orientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImage.Orientation.left || self.imageOrientation == UIImage.Orientation.leftMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }
        
        if ( self.imageOrientation == UIImage.Orientation.right || self.imageOrientation == UIImage.Orientation.rightMirrored ) {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
        }
        
        if ( self.imageOrientation == UIImage.Orientation.upMirrored || self.imageOrientation == UIImage.Orientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImage.Orientation.leftMirrored || self.imageOrientation == UIImage.Orientation.rightMirrored ) {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImage.Orientation.left ||
            self.imageOrientation == UIImage.Orientation.leftMirrored ||
            self.imageOrientation == UIImage.Orientation.right ||
            self.imageOrientation == UIImage.Orientation.rightMirrored ) {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        } else {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - roundedRadius: corner radius
    ///
    /// - Returns: the resized image with rounded corners.
    ///
    func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            currentContext.addPath(UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: .allCorners,
                                                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
            currentContext.clip()
            
            //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
            draw(in: rect)
            currentContext.drawPath(using: .fillStroke)
            let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedCornerImage
        }
        return nil
    }
}

open class CustomSlider : UISlider {
    @IBInspectable open var trackWidth:CGFloat = 2 {
        didSet {setNeedsDisplay()}
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
            width: defaultBounds.size.width,
            height: trackWidth
        )
    }
}

//MARK: - Convertation Of Date

func getLabelHight(text:String,font: UIFont, width:CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRect(x:0,y: 0,width: width,height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.textAlignment = .center
    label.text = text
    label.sizeToFit()
    return label.frame.height
}

func getLabelWidth(text:String,font: UIFont, height:CGFloat) -> CGFloat
{
    let label:UILabel = UILabel(frame: CGRect(x:0,y: 0,width: CGFloat.greatestFiniteMagnitude,height: height))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.textAlignment = .center
    label.text = text
    label.sizeToFit()
    return label.frame.width
}

func fileSize(forURL url: Any) -> Double {
    var fileURL: URL?
    var fileSize: Double = 0.0
    if (url is URL) || (url is String)
    {
        if (url is URL) {
            fileURL = url as? URL
        }
        else {
            fileURL = URL(fileURLWithPath: url as! String)
        }
        var fileSizeValue = 0.0
        try? fileSizeValue = (fileURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
        if fileSizeValue > 0.0 {
            fileSize = (Double(fileSizeValue) / (1024 * 1024))
        }
    }
    return fileSize
}
