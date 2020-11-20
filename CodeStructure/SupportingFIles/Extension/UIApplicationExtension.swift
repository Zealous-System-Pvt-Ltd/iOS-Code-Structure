//
//  UIApplicationExtension.swift
//  Admin
//
//  Created by Admin on 8/17/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

//MARK: - UIApplication Extension
extension UIApplication {
    
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = viewController as? UINavigationController {
            
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            
            if let selected = tab.selectedViewController {
                
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
