//
//  LoginCollectionViewCell.swift
//  project
//
//  Created by tranthanh on 3/10/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit



class LoginCollectionViewCell: UICollectionViewCell {
     weak var delegate: LoginControllerDelegate?
    
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var passTf: UITextField!
    
    @IBAction func loginBtn(_ sender: Any) {
        delegate?.finishLoggingIn(email: emailTf.text!, pass: passTf.text!)
    }
    
    @IBAction func faceBtn(_ sender: Any) {
        delegate?.loginFacebook()
    }
    
    @IBAction func googleBtn(_ sender: Any) {
        delegate?.loginGoogle()
    }
   
    @IBAction func actionRegister(_ sender: UIButton) {
        delegate?.register()
    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
    }

}
