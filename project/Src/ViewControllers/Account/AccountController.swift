//
//  AccountController.swift
//  project
//
//  Created by Trần Thành on 2/17/20.
//  Copyright © 2020 SUUSOFT. All rights reserved.
//

import UIKit


class AccountController: NavBarViewController, ItemDiaLogSelectedDelegate {
    var loading: Bool = false
    var listData : SettingsApp?
    func onDialogItemSeleted(item: SettingObj) {
        if item.isLanguage() {
            lblLanguageSelected.text = item.title
            DataStoreManager.shared().saveSettingsLanguage(key: item.id)
            // set language
            Bundle.setLanguage(item.id)
            // refresh data
            configUI();
            // push for all screens
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationID.CHANGE_LANGUAGE ), object: self)
            
        }  else if item.isTheme() {
            lblThemeSelected.text = item.title
            //save current theme
            DataStoreManager.shared().saveSettingsTheme(key: item.title)
            //update
            Colors.configTheme()
            
            // push for all screens
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationID.CHANGE_THEME ), object: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "Account")
        configUI()
        initMenuHeader()
        getSettingServer()
    }

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLanguageSelected: UILabel!
    @IBOutlet weak var lblThemeSelected: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBAction func btnAbout(_ sender: Any) {
        let url = listData?.about
        Utilities.openUrl(urlString: url)
    }
    
    @IBAction func btnFAQs(_ sender: Any) {
        let url = listData?.faq
         Utilities.openUrl(urlString: url)
    }
    
    
    func initMenuHeader()  {
        Utilities.createCornerImage(for: imgAvatar, radius: 40)
        let user = DataStoreManager.shared().getUser()
        if !user.name.isEmpty {
            lblName.text = user.name
            lblEmail.text = user.email
        }else{
            lblName.text = ""
            lblEmail.text = ""
        }
        
        if user.image.isEmpty {
            imgAvatar.image = #imageLiteral(resourceName: "placeholder")
        }else{
            imgAvatar.kf.setImage(with: URL(string: user.image))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getSettingServer()
    }
    
    func configUI(){
        lblThemeSelected.text = DataStoreManager.shared().getSettingsTheme()
        self.lblLanguageSelected.text = DataStoreManager.shared().getSettingsLanguage()
    }
    
   
    // 4. inside the selector method for the method call the property and then call the doSomething method
    
    @IBAction func changeLanguage(_ sender: Any) {
        let dialogLanguage = DialogViewController(nibName: "DialogViewController", bundle: nil)
        dialogLanguage.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dialogLanguage.delegate = self
        dialogLanguage.dialogTitle = "SELECT_LANGUAGE".localized()
        dialogLanguage.datas = SettingObj.getLanguageList()
        self.present(dialogLanguage, animated: true, completion: nil)
        
    }
    
    
    @IBAction func changeTheme(_ sender: Any) {
        let dialogLanguage = DialogViewController(nibName: "DialogViewController", bundle: nil)
        dialogLanguage.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dialogLanguage.delegate = self
        dialogLanguage.dialogTitle = "CHANGE_THEME".localized()
        dialogLanguage.datas = SettingObj.getThemeList()
        self.present(dialogLanguage, animated: true, completion: nil)

    }
    

    @IBAction func logOutAction(_ sender: Any) {
        self.showAlert(title: "Alert", message: "Do you want to logout?" , btnLeft: "No", actionLeft: nil, btnRight: "Yes") {
            DataStoreManager.shared().clearUser()
            self.rootmainNav()
        }
    }
    
    func rootmainNav(){
        if let mainNavigationController = UIApplication.shared.keyWindow?.rootViewController as? MainNavigationController {
            mainNavigationController.showLoginController()
        }
    }

    func getSettingServer(){
        APIManagement.shared.getSetting(actionFail: { (status, message) in
            self.showToast(message: message)
            self.loading = false
        }) { (status , message, data) in
            self.loading = false
            self.listData = data
        }
    }
}
