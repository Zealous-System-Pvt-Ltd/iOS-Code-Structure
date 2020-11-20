//
//  PhoneTextField.swift
//  CodeStructure
//
//  Created by Admin on 07/02/19.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class PhoneTextField: UITextField, UITextFieldDelegate {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.delegate = self
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        let newText = oldText.replacingCharacters(in: r, with: string)
        return string == "" ? true : newText.trimming().count < 15
    }

}
