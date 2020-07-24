//
//  ForgotPassWordViewController.swift
//  project
//
//  Created by SUUSOFT on 8/15/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit

class ForgotPassWordViewController: BaseViewController {
  
 
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var btnReset: UIButton!
   @IBOutlet weak var lblForgotPassword: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    configDevice()
  }
    
  
  func configDevice(){
    
    lblForgotPassword.text = "FORGOT_FORGOT_PASSWORD".localized()
    txtEmail.placeholder = "FORGOT_EMAIL".localized()
    btnReset.setTitle("FORGOT_REST_MY_PASSWORD".localized(), for: .normal)
   
    txtEmail.getUniversalSize()
    btnReset.getUniversalSize()
    
     txtEmail.changePlacehoderColor(.lightGray)
    // config border & bound
    Utilities.createCornerRadius(for: btnReset, radius: 24)
    
   

    self.view.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
  }

  
  @IBAction func actionBtnBackTapped(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func actionResetPassWordTapped(_ sender: Any) {
    if (!Utilities.validateEmail(txtEmail.text!)) {
      self.showAlertNormal(title: "Error", message: "Invalid gmail, please try again")
        return
    }
    self.requestToServer()
  }
    
  func requestToServer()  {
       self.showHideProgress(isShow: true)
        let parameter = ["email": txtEmail.text!,
        ] as [String : AnyObject]
     APIManagement.shared.common(pathURL: API.forgetPassword, parameter: parameter, actionFail: { (status, message) in
         self.showHideProgress(isShow: false)
         self.showAlert(title: "", message: message, btnLeft: "", actionLeft: nil, btnRight: "OK", actionRight: nil)
    }) { (status, message) in
            self.showHideProgress(isShow: false)
            self.txtEmail.text = ""
            self.showAlert(title: "", message: "Please check your email to reset password!", btnLeft: "", actionLeft: nil, btnRight: "OK", actionRight: nil)
    }
    }
}







