//
//  BackGroundButton.swift
//  CodeStructure
//
//  Created by Admin on 11/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class BackGroundButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        self.setGradientBackground([#colorLiteral(red: 0.8156862745, green: 0.3803921569, blue: 1, alpha: 1), #colorLiteral(red: 0.7176470588, green: 0.6666666667, blue: 1, alpha: 1)])
    }
}
