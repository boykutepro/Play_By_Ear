//
//  RegisterViewController.swift
//  project
//
//  Created by Phan Van Da on 8/18/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import MBProgressHUD


class RegisterViewController: BaseViewController {
  
  @IBOutlet weak var lblSignUp: UILabel!
  
  @IBOutlet weak var lblEmail: UILabel!
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var viewHighlightEmail: UIView!
  
  @IBOutlet weak var lblPass: UILabel!
  @IBOutlet weak var txtPass: UITextField!
  @IBOutlet weak var viewHighlightPass: UIView!
  
  @IBOutlet weak var lblConfirmPass: UILabel!
  @IBOutlet weak var txtConfirmPass: UITextField!
  @IBOutlet weak var viewHighlighConfirmPass: UIView!
  
  @IBOutlet weak var btnSignUp: UIButton!
  @IBOutlet weak var btnLogin: UIButton!
  
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var viewHighlightName: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var marginTopView: NSLayoutConstraint!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    marginTopView.constant = CGFloat(barHeight)
    configDevice()

  }
  
  func configDevice() {
    
    lblSignUp.text = "SIGNUP_SIGN_UP".localized()
   
    lblEmail.text  = "SIGNUP_EMAIL".localized()
    txtEmail.placeholder = "Email".localized()
    
    lblName.text  = "NAME".localized()
    txtName.placeholder = "NAME".localized()
   
    lblPass.text = "SIGNUP_PASSWORD".localized()
    txtPass.placeholder = "SIGNUP_PASSWORD".localized()
    
    lblConfirmPass.text = "SIGNUP_CONFIRM_PASS".localized()
    txtConfirmPass.placeholder = "SIGNUP_CONFIRM_PASS".localized()
    
    btnSignUp.setTitle("SIGNUP_SIGN_UP".localized(), for: .normal)
    btnLogin.setTitle("LOGIN_TITLE".localized(), for: .normal)
    
    lblEmail.getUniversalSize()
    txtEmail.getUniversalSize()
    lblPass.getUniversalSize()
    txtPass.getUniversalSize()
    btnSignUp.getUniversalSize()
    lblConfirmPass.getUniversalSize()
    txtConfirmPass.getUniversalSize()
    
    txtEmail.changePlacehoderColor(UIColor.colorWithHexString(Colors.primaryColor))
    txtPass.changePlacehoderColor(UIColor.colorWithHexString(Colors.primaryColor))
    txtConfirmPass.changePlacehoderColor(UIColor.colorWithHexString(Colors.primaryColor))
    txtName.changePlacehoderColor(UIColor.colorWithHexString(Colors.primaryColor))

    lblSignUp.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
    btnSignUp.backgroundColor = UIColor.colorWithHexString(Colors.white)
    
    Utilities.createCornerRadius(for: btnSignUp, radius: 8)
    // config Border & bound
   
    lblName.isHidden = true
    lblEmail.isHidden = true
    lblPass.isHidden  = true
    lblConfirmPass.isHidden = true
    
    self.view.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
  }
    
 
    
  @IBAction func changeEmail(_ sender: Any) {
    lblEmail.isHidden = false
    viewHighlightEmail.configUIHighLight(true)
  }
  
  @IBAction func changePass(_ sender: Any) {
    lblPass.isHidden = false
    viewHighlightPass.configUIHighLight(true)
  }
  
  @IBAction func changeConfirmPass(_ sender: Any) {
    lblConfirmPass.isHidden = false
    viewHighlighConfirmPass.configUIHighLight(true)
  }
  
  @IBAction func didEndEmail(_ sender: Any) {
    viewHighlightEmail.configUIHighLight(false)
  }
  
  @IBAction func didEndPass(_ sender: Any) {
    viewHighlightPass.configUIHighLight(false)
    }
  
  @IBAction func didEndConfirmPass(_ sender: Any) {
    viewHighlighConfirmPass.configUIHighLight(false)
  }
  
    
  @IBAction func actionBtnLoginTapped(_ sender: Any) {
    
    self.navigationController?.popViewController(animated: true)
    
  }
  
  @IBAction func actionBtnBackTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    
  }
 
  
  func checkInformation() -> Bool {
    
    if (!Utilities.validateInfomation(txtName.text!, minCharacter: 1, maxCharacter: 32)) {
        self.showAlertNormal(title: "Missing", message: "Your name can not be empty")
        return false
    }

    if (!Utilities.validateEmail(txtEmail.text!)) {
      self.showAlertNormal(title: "Error", message: "Invalid gmail, please try again")
      return false
    }
    if (!Utilities.validateInfomation(txtPass.text!, minCharacter: 6, maxCharacter: 15)) {
      self.showAlertNormal(title: "Missing", message: "Please enter password between 6 to 15 characters")
      return false
    }

    if (!Utilities.validateInfomation(txtConfirmPass.text!, minCharacter: 6, maxCharacter: 15)) {
      self.showAlertNormal(title: "Missing", message: "Please enter confirm password between 6 to 15 characters")
      return false
    }
    if (!(txtConfirmPass.text?.isEqual(txtPass.text))!){
      self.showAlertNormal(title: "Error", message: "Please confirm password equals current password")
      return false
    }
    return true
  }
    

  @IBAction func actionSignUpTapped(_ sender: Any) {
    if (checkInformation()){
       signinToServer()
       
    }
  }
    
    func saveUser(user: User)  {
        DataStoreManager.shared().saveUser(user: user)
    }
    
    func signinToServer(){
        showHideProgress(isShow: true)
        let url = API.register
        let param = [
            "username" : txtEmail.text!,
            "password" : txtPass.text!,
            "name" : txtName.text!,
            "type" : 2,
            "status" : 1,
            ] as [String : AnyObject]
        APIManagement.shared.user(pathURL: url, parameter: param, actionFail: { (status, message) in
             self.showHideProgress(isShow: false)
            self.showAlert(title: "", message: message, btnLeft: "", actionLeft: nil, btnRight: "OK", actionRight: nil)
        }) { (user) in
             self.showHideProgress(isShow: false)
             self.showToast(message: "Register successfully!")
             self.confirmSuccess()
        }
    
        
    }
    
    func confirmSuccess()  {
        showAlert(title: "Successfully!", message: "Register successfully! Please try to login" , btnLeft: "", actionLeft: {
             self.navigationController?.popViewController(animated: true)
        }, btnRight: "OK") {
             self.navigationController?.popViewController(animated: true)
        }
    }
}
    
    




