//
//  EditProfileViewController.swift
//  EBook
//
//  Created by Trang Pham on 7/6/18.
//  Copyright © 2018 NKT. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol UpdateDelegate {
    func onUpdateProfile()
}

class EditProfileViewController: NavBarViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    
    
    var delegate: UpdateDelegate?
    
    func setDelegate(delegate: UpdateDelegate)  {
        self.delegate = delegate
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = "NAME".localized()
        btnUpdate.setTitle("UPDATE".localized(), for: .normal)
        
        configNavBar()

        bindData() 

        
    }
    
    override func isNavBar() -> Bool {
        return true
    }
    
    func configNavBar()  {
        setNavTitle(title: "EDIT_PROFILE".localized())
        
    }
    
    func bindData()  {
        let user = DataStoreManager.shared().getUser()
        txtName.text = user.name
        txtPhone.text = user.phone
        
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        let name = txtName.text
        let phone = txtPhone.text
        //let password = txtPassword.text
        
        if (name?.isEmpty)! || (phone?.isEmpty)! {
            return
        }
        
        let user = DataStoreManager.shared().getUser()
        requestUpdate(user: user, name: name!, phone: phone!, password: "")
        
        
    }
    
    
    func requestUpdate(user: User, name: String, phone: String, password: String){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        
    }
    
   
}
