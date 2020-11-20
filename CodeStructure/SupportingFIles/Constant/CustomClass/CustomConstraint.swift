//
//  CustomConstraint.swift
//  CodeStructure
//
//  Created by Admin on 13/12/18.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HeaderHeightConstraint: NSLayoutConstraint {
    
    override var constant: CGFloat {
        set {
            self.constant = newValue
        } get {
            return UIApplication.shared.statusBarFrame.height+CGFloat(50)
        }
    }
}

class HeaderHeightWithBackConstraint: NSLayoutConstraint {
    
    override var constant: CGFloat {
        set {
            self.constant = newValue
        } get {
            return UIApplication.shared.statusBarFrame.height+CGFloat(104)
        }
    }
}

class HeaderHeightCustomConstraint: NSLayoutConstraint {
    
    override var constant: CGFloat {
        set {
            self.constant = newValue
        } get {
            return UIApplication.shared.statusBarFrame.height+CGFloat(160)
        }
    }
}

class HeaderHeightDetailConstraint: NSLayoutConstraint {
    
    override var constant: CGFloat {
        set {
            self.constant = newValue
        } get {
            return UIApplication.shared.statusBarFrame.height+CGFloat(230)
        }
    }
}
