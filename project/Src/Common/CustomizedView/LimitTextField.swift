//
//  LimitTextField.swift
//  iwanadeal
//
//  Created by DangLV on 09/01/2017.
//  Copyright © 2017 Moza Tech. All rights reserved.
//

import UIKit

@IBDesignable
class LimitTextField: UITextField, UITextFieldDelegate {
    
    @IBInspectable var maxLength: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    // MARK: - UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(maxLength > 0) {
            let newLength = textField.text!.count + string.count - range.length
            return newLength <= maxLength
        } else {
            return true
        }
    }
    
}
