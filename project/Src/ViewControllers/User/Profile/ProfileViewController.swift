//
//  ProfileViewController.swift
//  EBook
//
//  Created by Trang Pham on 7/6/18.
//  Copyright © 2018 NKT. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class ProfileViewController: NavBarViewController, UpdateDelegate, ItemDiaLogSelectedDelegate {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblChangeTheme: UILabel!
    @IBOutlet weak var lblThemeSelected: UILabel!
    
    @IBOutlet weak var lblCleanCache: UILabel!
    @IBOutlet weak var lblCleanCacheDes: UILabel!
    
    @IBOutlet weak var lblSettingScreenDescription: UILabel!
    @IBOutlet weak var lblScreenSettings: UILabel!
    @IBOutlet weak var swLanguage: UISwitch!
    
    @IBOutlet weak var btnPolicy: UIButton!
    @IBOutlet weak var lblAbout: UILabel!
    
    @IBOutlet weak var btnLogour: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configNavBar()
        configUI()
        customizeUI()
        bindData()
        
    }

    func configNavBar()  {
        setNavTitle(title: "PROFILE".localized())
       // addActionMenu(id: 1, image: UIImage(named: "ic_edit")!)
        navBar.lblTitle.textColor = UIColor.black
        setNavBackgroundColor(color: "#ffffff")
    }
    
    func onItemMenuSelected(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            openEditProfile()
            break
            
        default:
            break
        }
    }
    
    
    @IBAction func actionEdit(_ sender: UIButton) {
        openEditProfile()
    }
    
    func customizeUI()  {
      
        viewHeader.backgroundColor = UIColor.colorWithHexString(Colors.primaryColor)
    }
   
    func bindData()  {
        let user = DataStoreManager.shared().getUser()
        lblName.text = user.name
        lblEmail.text = user.email
       // lblPhone.text = user.phone
        
        if user.name.isEmpty {
            lblName.text = "User Name"
        }
        if user.image.isEmpty {
            imgAvatar.image = UIImage(named: "ic_user")
        }else{
            imgAvatar.kf.setImage(with: URL(string: user.image))
        }
        
        
    }
    
    func onUpdateProfile() {
        bindData()
    }
    
    func openEditProfile()  {
         let editProfileVC = EditProfileViewController()
        editProfileVC.setDelegate(delegate: self)
         self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    // ===================== SETTINGS ===========================
    func configUI(){
        
        lblScreenSettings.text = "SCREEN_SETTINGS".localized()
        lblSettingScreenDescription.text = "SETTINGS_SCREEN_DES".localized()
        lblChangeTheme.text = "CHANGE_THEME".localized()
        lblCleanCache.text = Localized("CLEAN_CACHE")
        lblCleanCacheDes.text = Localized("CLEAN_CACHE_DES")

        btnLogour.setTitle( Localized("PROFILE_SIGNOUT"), for: .normal)
        lblAbout.text =  Localized("PROFILE_ABOUT")
        btnPolicy.setTitle( Localized("PROFILE_ABOUT_LINK"), for: .normal)
     
        swLanguage.isOn = DataStoreManager.shared().isSettingsKeepScreen()
        
        let themeTitle =  DataStoreManager.shared().getSettingsTheme() == "-1" ? "" : getThemeName(id: Int(DataStoreManager.shared().getSettingsTheme())!)
        
        lblThemeSelected.text = themeTitle
        
    }
    
    func getThemeName(id: Int) -> String {
        if id == 0 {
            return "LIGHT".localized()
        }else if id == 1{
            return "DARK".localized()
        }else{
            return "BEIGE".localized()
        }
    }
    
    @IBAction func switchKeepScreenOn(_ sender: UISwitch) {
        if sender.isOn {
            UIApplication.shared.isIdleTimerDisabled = true
            DataStoreManager.shared().saveSettingsScreen(isKeep: true)
        }else{
            UIApplication.shared.isIdleTimerDisabled = false
            DataStoreManager.shared().saveSettingsScreen(isKeep: false)
        }
    }
    
    
    @IBAction func actionChangeTheme(_ sender: UIButton) {
        let dialogLanguage = DialogViewController(nibName: "DialogViewController", bundle: nil)
        dialogLanguage.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dialogLanguage.delegate = self
        dialogLanguage.dialogTitle = "CHANGE_THEME".localized()
        dialogLanguage.datas = SettingObj.getThemeList()
        self.present(dialogLanguage, animated: true, completion: nil)
    }
    
    
    @IBAction func actionGoToPage(_ sender: UIButton) {
       
    }
    
    @IBAction func actionLogour(_ sender: UIButton) {
        let viewSplash = LoginViewController(nibName: "LoginViewController", bundle: nil)
       
        self.navigationController?.pushViewController(viewSplash, animated: true)
    }
    
    @IBAction func actionDeleteCache(_ sender: UIButton) {
       

        
    }
    
    
    //
    func onDialogItemSeleted(item: SettingObj) {
        if item.isLanguage() {
            
            DataStoreManager.shared().saveSettingsLanguage(key: item.id)
            // set language
            Bundle.setLanguage(item.id)
            // refresh data
            configUI();
            // push for all screens
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationID.CHANGE_LANGUAGE ), object: self)
            
        }else if item.isTheme(){
            lblThemeSelected.text = item.title
            //save current theme
            DataStoreManager.shared().saveSettingsTheme(key: item.id)
            
            //update
            //Colors.configTheme()
            
            // push for all screens
//            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationID.CHANGE_THEME ), object: self)
            
            
        }
        
    }
    
    


}
