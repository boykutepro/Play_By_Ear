//
//  SettingsViewController.swift
//  project
//
//  Created by Mac on 8/16/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit


class SettingsViewController: NavBarViewController, ItemDiaLogSelectedDelegate {

    @IBOutlet weak var lblChangeLanguage: UILabel!
    @IBOutlet weak var lblLanguageSelected: UILabel!
  
    @IBOutlet weak var lblSettingScreenDescription: UILabel!
    @IBOutlet weak var lblScreenSettings: UILabel!
    
    @IBOutlet weak var lblChangeTheme: UILabel!
    
    @IBOutlet weak var lblThemeSelected: UILabel!
    
    @IBOutlet weak var swLanguage: UISwitch!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "SETTINGS".localized())
        configUI()
    
    }
  
   
    func configUI(){
        
        lblChangeLanguage.text = "SELECT_LANGUAGE".localized()
        lblScreenSettings.text = "SCREEN_SETTINGS".localized()
        lblSettingScreenDescription.text = "SETTINGS_SCREEN_DES".localized()
        lblChangeTheme.text = "CHANGE_THEME".localized()
        
        swLanguage.isOn = DataStoreManager.shared().isSettingsKeepScreen()
        lblThemeSelected.text = DataStoreManager.shared().getSettingsTheme()
    
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
    
    @IBAction func actionChangeLanguage(_ sender: UIButton) {
        let dialogLanguage = DialogViewController(nibName: "DialogViewController", bundle: nil)
        dialogLanguage.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dialogLanguage.delegate = self
        dialogLanguage.dialogTitle = "SELECT_LANGUAGE".localized()
        dialogLanguage.datas = SettingObj.getLanguageList()
        self.present(dialogLanguage, animated: true, completion: nil)
    }
  
    
    @IBAction func actionChangeTheme(_ sender: UIButton) {
        let dialogLanguage = DialogViewController(nibName: "DialogViewController", bundle: nil)
        dialogLanguage.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dialogLanguage.delegate = self
        dialogLanguage.dialogTitle = "CHANGE_THEME".localized()
        dialogLanguage.datas = SettingObj.getThemeList()
        self.present(dialogLanguage, animated: true, completion: nil)
    }
    
    //
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
            
        }else if item.isTheme(){
            lblThemeSelected.text = item.title
            //save current theme
            DataStoreManager.shared().saveSettingsTheme(key: item.title)
            
            //update 
            Colors.configTheme()
            
            // push for all screens
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationID.CHANGE_THEME ), object: self)
            
            
        }
        
    }
    
    
}
