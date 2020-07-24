//
//  RegisterViewController1.swift
//  EBook
//
//  Created by Trang Pham on 12/25/19.
//  Copyright © 2019 NKT. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController1: BaseViewController {
  
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
 
  
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var viewHighlightName: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
 
    configDevice()

  }
  
  func configDevice() {
    
    lblSignUp.text = "SIGNUP_SIGN_UP".localized()
   
    lblEmail.text  = "SIGNUP_EMAIL".localized()
    txtEmail.placeholder = "Email"
    
    lblName.text  = "NAME".localized()
    txtName.placeholder = "NAME".localized()
   
    lblPass.text = "SIGNUP_PASSWORD".localized()
    txtPass.placeholder = "SIGNUP_PASSWORD".localized()
    
    lblConfirmPass.text = "SIGNUP_CONFIRM_PASS".localized()
    txtConfirmPass.placeholder = "SIGNUP_CONFIRM_PASS".localized()
    
    btnSignUp.setTitle("SIGNUP_SIGN_UP".localized(), for: .normal)

    
    lblEmail.getUniversalSize()
    txtEmail.getUniversalSize()
    lblPass.getUniversalSize()
    txtPass.getUniversalSize()
    btnSignUp.getUniversalSize()
    lblConfirmPass.getUniversalSize()
    txtConfirmPass.getUniversalSize()
    
    txtEmail.changePlacehoderColor(UIColor.colorWithHexString(Colors.white))
    txtPass.changePlacehoderColor(UIColor.colorWithHexString(Colors.white))
    txtConfirmPass.changePlacehoderColor(UIColor.colorWithHexString(Colors.white))
    txtName.changePlacehoderColor(UIColor.colorWithHexString(Colors.white))

    self.view.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
    lblSignUp.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
    btnSignUp.backgroundColor = UIColor.colorWithHexString(Colors.white)
    
    Utilities.createCornerRadius(for: btnSignUp, radius: 8)
    // config Border & bound

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
    
    func gotoHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
       
    }
  
  @IBAction func actionSignUpTapped(_ sender: Any) {
    if (checkInformation()){
        requestRegister(name: txtName.text!, email: txtEmail.text!, password: txtPass.text!)
       
    }
  }
    
    func saveUser(user: User)  {
        DataStoreManager.shared().saveUser(user: user)
    }
    
    func requestRegister(name: String, email: String, password: String){
        MBProgressHUD.showAdded(to: self.view, animated: true)
       
        
    }
    
    
}
    
    

