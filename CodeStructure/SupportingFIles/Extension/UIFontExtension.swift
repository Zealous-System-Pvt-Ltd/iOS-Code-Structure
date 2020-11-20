//
//  UIFontExtension.swift
//  Admin
//
//  Created by Admin on 21/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static var delatFontSize : CGFloat {
        return 0.0
    }
    class func Segoe_UI_Bold(_ size : CGFloat) -> UIFont {
        return UIFont(name: "SegoeUI-Bold", size: size)!;
    }
    class func Segoe_UI_Regular(_ size : CGFloat) -> UIFont {
        return UIFont(name: "SegoeUI", size: size)!;
    }
    
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("--- Font Names = [\(names)]")
        }
    }
}
