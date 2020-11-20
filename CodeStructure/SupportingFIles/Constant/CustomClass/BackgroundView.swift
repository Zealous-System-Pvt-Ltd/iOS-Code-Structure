//
//  BackgroundView.swift
//  CodeStructure
//
//  Created by Admin on 10/12/18.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        self.setGradientBackground([#colorLiteral(red: 0.9803921569, green: 0.7490196078, blue: 0.3137254902, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.431372549, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.2666666667, blue: 0.4039215686, alpha: 1)], .LeftToRight)
    }
}

class BackgroundViewFromTop: UIView {
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        self.setGradientBackground([#colorLiteral(red: 0.9803921569, green: 0.7490196078, blue: 0.3137254902, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.431372549, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.2666666667, blue: 0.4039215686, alpha: 1)], .TopToBottom)
    }
}
